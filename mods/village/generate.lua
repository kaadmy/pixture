
--
-- Single village generation
--

village.villages = {}

-- Savefile

local village_file = minetest.get_worldpath() .. "/villages.dat"

local modpath = minetest.get_modpath("village")

function village.get_id(name, pos)
   return name .. minetest.hash_node_position(pos)
end

function village.save_villages()
   local f = io.open(village_file, "w")

   for name, def in pairs(village.villages) do
      f:write(name .. " " .. def.name .. " "
                 .. minetest.hash_node_position(def.pos) .. "\n")
   end

   io.close(f)
end

function village.load_villages()
   local f = io.open(village_file, "r")

   if f then
      repeat
	 local l = f:read("*l")
	 if l == nil then break end

	 for name, fname, pos in string.gfind(l, "(.+) (%a+) (%d.+)") do
	    village.villages[name] = {
	       name = fname,
	       pos = minetest.get_position_from_hash(pos),
	    }
	 end
      until f:read(0) == nil

      io.close(f)
   else
      village.save_villages()
   end

   village.load_waypoints()
end

function village.load_waypoints()
   for name, def in pairs(village.villages) do
      nav.remove_waypoint("village_" .. name)
      nav.add_waypoint(
	 def.pos,
	 "village_" .. name,
	 def.name .. " village",
	 true,
	 "village"
      )
   end
end

function village.get_nearest_village(pos)
   local nearest = 100000 -- big number
   local name = nil

   for name, def in pairs(village.villages) do
      local dist = vector.distance(pos, def.pos)
      if dist < nearest then
	 nearest = dist
	 name = name
      end
   end

   return {dist = nearest, name = name}
end

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

function village.lift_ground(pos, scanheight)
   -- assume ground is lower than pos.y

   local topnode = nil
   local topdepth = 0

   local fillernode = nil
   local fillerdepth = 0

   local stonenode = nil

   for y = pos.y, pos.y - scanheight, -1 do
      local p = {x = pos.x, y = y, z = pos.z}

      local nn = minetest.get_node(p).name
      local an = minetest.get_node({x = p.x, y = p.y + 1, z = p.z}).name

      if nn ~= "air" then
	 local nd = minetest.registered_nodes[nn]
	 if not nd.buildable_to then -- avoid grass, fluids, etc.
	    if topnode == nil and nn ~= an then
	       topnode = nn
	    elseif fillernode == nil and nn ~= an then
	       fillernode = nn
	    else
	       stonenode = nn
	    end
	 end

	 if fillernode and not stonenode then
	    fillerdepth = fillerdepth + 1
	 elseif topnode and not fillernode then
	    topdepth = topdepth + 1
	 end
      end
   end

   if topnode == nil then
      topnode = "default:dirt_with_grass"
      topdepth = 1
   end
   if fillernode == nil then
      fillernode = "default:dirt"
      fillerdepth = 3
   end
   if stonenode == nil then
      stonenode = fillernode
   end

   for y = pos.y - scanheight, pos.y do
      local p = {x = pos.x, y = y, z = pos.z}

      local th = pos.y - y

      if th <= fillerdepth - topdepth then
	 minetest.set_node(p, {name = fillernode})
      elseif th <= topdepth then
	 minetest.set_node(p, {name = topnode})
      else
	 minetest.set_node(p, {name = stonenode})
      end
   end
end

function village.spawn_chunk(pos, orient, replace, pr, chunktype, nofill)
   util.getvoxelmanip(pos, {x = pos.x+12, y = pos.y+12, z = pos.z+12})

   if nofill ~= true then
      util.nodefunc(
	 {x = pos.x-6, y = pos.y-7, z = pos.z-6},
	 {x = pos.x+17, y = pos.y-6, z = pos.z+17},
	 "air",
	 function(pos)
	    village.lift_ground(pos, 15) -- distance to lift ground; larger numbers will be slower
	 end, true)

      minetest.place_schematic(
	 pos,
	 modpath .. "/schematics/village_empty.mts",
	 "0",
	 {},
	 true
      )

      minetest.place_schematic(
	 {x = pos.x-6, y = pos.y-5, z = pos.z-6},
	 modpath .. "/schematics/village_filler.mts",
	 "0",
	 {},
	 false
      )
   end

   minetest.place_schematic(
      pos,
      modpath .. "/schematics/village_" .. chunktype .. ".mts",
      orient,
      replace,
      true
   )

   util.reconstruct(pos, {x = pos.x+12, y = pos.y+12, z = pos.z+12})
   util.fixlight(pos, {x = pos.x+12, y = pos.y+12, z = pos.z+12})

   util.nodefunc(
      pos,
      {x = pos.x+12, y = pos.y+12, z = pos.z+12},
      "default:chest",
      function(pos)
	 goodies.fill(pos, chunktype, pr, "main", 3)
      end, true)

   util.nodefunc(
      pos,
      {x = pos.x+12, y = pos.y+12, z = pos.z+12},
      "music:player",
      function(pos)
	 if pr:next(1, 2) > 1 then
	    minetest.remove_node(pos)
	 end
      end, true)

   local chunkdef = village.chunkdefs[chunktype]
   if chunkdef ~= nil then
      if chunkdef.entities ~= nil then
	 if chunkdef.entity_chance ~= nil and pr:next(1, chunkdef.entity_chance) == 1 then
	    util.nodefunc(
	       pos,
	       {x = pos.x+12, y = pos.y+12, z = pos.z+12},
	       "village:entity_spawner",
	       function(pos)
		  minetest.remove_node(pos)
            end)
	    return
	 end

	 local ent_spawns = {}

	 util.nodefunc(
	    pos,
	    {x = pos.x+12, y = pos.y+12, z = pos.z+12},
	    "village:entity_spawner",
	    function(pos)
	       table.insert(ent_spawns, pos)
	       minetest.remove_node(pos)
	    end, true)

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
	 {x = pos.x+12, y = pos.y+12, z = pos.z+12},
	 "default:furnace",
	 function(pos)
	    goodies.fill(pos, "FURNACE_SRC", pr, "src", 1)
	    goodies.fill(pos, "FURNACE_DST", pr, "dst", 1)
	    goodies.fill(pos, "FURNACE_FUEL", pr, "fuel", 1)
	 end, true)
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

      local hnp = minetest.hash_node_position(nextpos)

      if built[hnp] == nil then
	 built[hnp] = true
	 if depth <= 0 or pr:next(1, 8) < 6 then
	    houses[hnp] = {pos = nextpos, front = pos}

	    local structure = util.choice_element(village.chunktypes, pr)
	    village.spawn_chunk(nextpos, orient, {}, pr, structure)
	 else
	    roads[hnp] = {pos = nextpos}
	    village.spawn_road(nextpos, houses, built, roads, depth - 1, pr)
	 end
      end
   end
end

function village.spawn_village(pos, pr)
   local name = village.name.generate(pr)

   local depth = pr:next(village.min_size, village.max_size)

   village.villages[village.get_id(name, pos)] = {
      name = name,
      pos = pos,
   }

   village.save_villages()
   village.load_waypoints()

   local houses = {}
   local built = {}
   local roads = {}

   local spawnpos = pos

   village.spawn_chunk(pos, "0", {}, pr, "well")
   built[minetest.hash_node_position(pos)] = true

   local t1 = os.clock()
   village.spawn_road(pos, houses, built, roads, depth, pr)
   print(string.format("Took %.2fms to spawn village", (os.clock() - t1) * 1000))

   local function connects(pos, nextpos)
      local hnp = minetest.hash_node_position(nextpos)

      if houses[hnp] ~= nil then
	 if vector.equals(houses[hnp].front, pos) then
	    return true
	 end
      end

      if roads[hnp] ~= nil then
	 return true
      end

      if vector.equals(pos, nextpos) or vector.equals(nextpos, spawnpos) then
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

minetest.after(
   0,
   function()
      village.load_villages()
end)
