--
-- Single village generation
--

local mp = minetest.get_modpath("village")

village.villages = {}

village.chunkdefs = {}

village.chunkdefs["livestock_pen"] = {
   entities = {
      ["mobs:sheep"] = 3,
      ["mobs:boar"] = 1,
   },
}
village.chunkdefs["lamppost"] = { -- not road because of road height limit of 1 nodes
   entity_chance = 2,
   entities = {
      ["mobs:npc_butcher"] = 1,
   },
}
village.chunkdefs["well"] = {
   entities = {
      ["mobs:npc_farmer"] = 1,
      ["mobs:npc_tavernkeeper"] = 1,
   },
}
village.chunkdefs["house"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_farmer"] = 1,
   },
}
village.chunkdefs["tavern"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_tavernkeeper"] = 1,
   },
}

village.chunkdefs["forge"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_blacksmith"] = 1,
   },
}
village.chunkdefs["orchard"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_farmer"] = 1,
   },
}
village.chunkdefs["farm"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_farmer"] = 1,
   },
}
village.chunkdefs["farm_papyrus"] = {
   entity_chance = 2,
   entities = {
      ["mobs:npc_farmer"] = 1,
   },
}

village.chunktypes = {
   "house", "house", "house", "house",
   "tavern", "tavern",
   "forge", "forge",
   "farm", "farm",
   "farm_papyrus",
   "livestock_pen",
   "orchard",
}

function village.get_area_height(minp, maxp)
   local minp, maxp = util.sort_pos(minp, maxp)

   local avg = 0
   local amt = 0
   
   for y = minp.y, maxp.y-1 do
      for x = minp.x, maxp.x-1 do
	 for z = minp.z, maxp.z-1 do
	    if minetest.get_node({x = x, y = y, z = z}).name == "air" or minetest.get_node({x = x, y = y, z = z}).name == "ignore" then
	       avg = avg + y
	       amt = amt + 1
	    end
	 end 
      end
   end

   avg = avg / amt

   return avg
end

function village.spawn_chunk(pos, orient, replace, pr, chunktype, nofill)
   util.getvoxelmanip(pos, {x = pos.x+12, y = pos.y+16, z = pos.z+12})

   if nofill ~= true then
      minetest.place_schematic(
	 {x = pos.x, y = pos.y-8, z = pos.z},
	 mp.."/schematics/village_filler.mts",
	 "0",
	 {},
	 true
      )
   end

   minetest.place_schematic(
      pos,
      mp.."/schematics/village_"..chunktype..".mts",
      orient,
      replace,
      true
   )

   util.reconstruct(pos, {x = pos.x+12, y = pos.y+16, z = pos.z+12})
   util.fixlight(pos, {x = pos.x+12, y = pos.y+16, z = pos.z+12})
   util.nodefunc(
      pos,
      {x = pos.x+12, y = pos.y+16, z = pos.z+12},
      "default:chest",
      function(pos)
	 goodies.fill(pos, chunktype, pr, "main", 3)
      end)
   util.nodefunc(
      pos,
      {x = pos.x+12, y = pos.y+16, z = pos.z+12},
      "music:player",
      function(pos)
	 if pr:next(1, 2) > 1 then
	    minetest.remove_node(pos)
	 end
      end)

   local chunkdef = village.chunkdefs[chunktype]
   if chunkdef ~= nil then
      if chunkdef.entities ~= nil then
	 if chunkdef.entity_chance ~= nil and pr:next(1, chunkdef.entity_chance) == 1 then
	    util.nodefunc(
	       pos,
	       {x = pos.x+12, y = pos.y+16, z = pos.z+12},
	       "village:entity_spawner",
	       function(pos)
		  minetest.remove_node(pos)
	       end)
	    return
	 end
	 
	 local ent_spawns = {}

	 util.nodefunc(
	    pos,
	    {x = pos.x+12, y = pos.y+16, z = pos.z+12},
	    "village:entity_spawner",
	    function(pos)
	       table.insert(ent_spawns, pos)
	       minetest.remove_node(pos)
	    end)

	 if #ent_spawns > 0 then
	    for ent, amt in pairs(chunkdef.entities) do
	       for j = 1, pr:next(1, amt) do
		  local spawn = util.choice_element(ent_spawns, pr)
		  if spawn ~= nil then
		     spawn.y = spawn.y + 1.6
		     minetest.add_entity(spawn, ent)
		  end
	       end
	    end
	 end
      end
   end

   if chunktype == "forge" then
      util.nodefunc(
	 pos,
	 {x = pos.x+12, y = pos.y+16, z = pos.z+12},
	 "default:furnace",
	 function(pos)
	    goodies.fill(pos, "FURNACE_SRC", pr, "src", 1)
	    goodies.fill(pos, "FURNACE_DST", pr, "dst", 1)
	    goodies.fill(pos, "FURNACE_FUEL", pr, "fuel", 1)
	 end)
   end
end

function village.spawn_road(pos, houses, built, roads, depth, pr)
   for i=1,4 do
      local nextpos = {x = pos.x, y = pos.y, z = pos.z}
      local orient = "random"

      if i == 1 then
	 orient = "0"
	 nextpos.z = nextpos.z - 12
      elseif i == 2 then
	 orient = "90"
	 nextpos.x = nextpos.x - 12
      elseif i == 3 then
	 orient = "180"
	 nextpos.z = nextpos.z + 12
      else
	 orient = "270"
	 nextpos.x = nextpos.x + 12
      end

      if built[default.dumpvec(nextpos)] == nil then
	 built[default.dumpvec(nextpos)] = true
	 if depth <= 0 or pr:next(1, 8) < 6 then
	    houses[default.dumpvec(nextpos)] = {pos = nextpos, front = pos}
	    
	    local structure = util.choice_element(village.chunktypes, pr)
	    village.spawn_chunk(nextpos, orient, {}, pr, structure)
	 else
	    roads[default.dumpvec(nextpos)] = {pos = nextpos}
	    village.spawn_road(nextpos, houses, built, roads, depth - 1, pr)
	 end
      end
   end
end

function village.spawn_village(pos, pr)
   local name = village.name.generate(pr)

   local depth = pr:next(village.min_size, village.max_size)
   
   village.villages[name] = {
      pos = pos,
   }

   village.spawn_chunk(pos, "0", {}, pr, "well")

   local houses = {}
   local built = {}
   local roads = {}

   built[default.dumpvec(pos)] = true

   village.spawn_road(pos, houses, built, roads, depth, pr)

   local function connects(pos, nextpos)
      if houses[default.dumpvec(nextpos)] ~= nil then
	 if vector.equals(houses[default.dumpvec(nextpos)].front, pos) then
	    return true
	 end
      end

      if roads[default.dumpvec(nextpos)] ~= nil then
	 return true
      end

      if vector.equals(pos, nextpos) then
	 return true
      end
   end

   for _,road in pairs(roads) do
      local replaces = {
	 ["default:planks"]       = "default:dirt_with_grass", -- north
	 ["default:cobble"]       = "default:dirt_with_grass", -- east
	 ["default:planks_oak"]   = "default:dirt_with_grass", -- south
	 ["default:planks_birch"] = "default:dirt_with_grass"  -- west
      }

      local amt_connections = 0

      for i = 1, 4 do
	 local nextpos = {x = road.pos.x, y = road.pos.y, z = road.pos.z}

	 if i == 1 then
	    amt_connections = amt_connections + 1
	    nextpos.z = nextpos.z + 12
	    if connects(road.pos, nextpos) then
	       replaces["default:planks"] = "default:heated_dirt_path"
	    end
	 elseif i == 2 then
	    amt_connections = amt_connections + 1
	    nextpos.x = nextpos.x + 12
	    if connects(road.pos, nextpos) then
	       replaces["default:cobble"] = "default:heated_dirt_path"
	    end
	 elseif i == 3 then
	    amt_connections = amt_connections + 1
	    nextpos.z = nextpos.z - 12
	    if connects(road.pos, nextpos) then
	       replaces["default:planks_oak"] = "default:heated_dirt_path"
	    end
	 else
	    amt_connections = amt_connections + 1
	    nextpos.x = nextpos.x - 12
	    if connects(road.pos, nextpos) then
	       replaces["default:planks_birch"] = "default:heated_dirt_path"
	    end
	 end

      end

      village.spawn_chunk(road.pos, "0", replaces, pr, "road")
      if amt_connections >= 2 then
	 village.spawn_chunk(
	    {x = road.pos.x, y = road.pos.y+1, z = road.pos.z},
	    "0",
	    {},
	    pr,
	    "lamppost",
	    true
	  )
      end
   end
end