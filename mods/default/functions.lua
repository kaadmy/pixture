--
-- Functions/ABMs
--

-- Saplings growing

function default.grow_tree(pos, variety)
   local function grow()
      if variety == "apple" then
	 minetest.place_schematic({x = pos.x-2, y = pos.y-1, z = pos.z-2}, minetest.get_modpath("default").."/schematics/default_tree.mts", "0", {}, false)
      elseif variety == "oak" then
	 minetest.place_schematic({x = pos.x-2, y = pos.y-1, z = pos.z-2}, minetest.get_modpath("default").."/schematics/default_tree.mts", "0", {["default:leaves"] = "default:leaves_oak", ["default:tree"] = "default:tree_oak", ["default:apple"] = "air"}, false)
      elseif variety == "birch" then
	 minetest.place_schematic({x = pos.x-1, y = pos.y-1, z = pos.z-1}, minetest.get_modpath("default").."/schematics/default_squaretree.mts", "0", {["default:leaves"] = "default:leaves_birch", ["default:tree"] = "default:tree_birch", ["default:apple"] = "air"}, false)
      end
   end

   minetest.remove_node(pos)

   minetest.after(0, grow)

   default.log(variety.." tree sapling grows at "..minetest.pos_to_string(pos), "info")
end

minetest.register_abm( -- apple trees or default trees
   {
      nodenames = {"default:sapling"},
      interval = 10,
      chance = 40,
      action = function(pos, node)
		  local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil

		  if is_soil == nil or is_soil == 0 then return end

		  default.grow_tree(pos, "apple")
	       end
   })

minetest.register_abm( -- oak trees
   {
      nodenames = {"default:sapling_oak"},
      interval = 10,
      chance = 60,
      action = function(pos, node)
		  local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
		  if is_soil == nil or is_soil == 0 then return end
		  default.grow_tree(pos, "oak")
	       end
   })

minetest.register_abm( -- birch trees
   {
      nodenames = {"default:sapling_birch"},
      interval = 10,
      chance = 50,
      action = function(pos, node)
		  local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
		  if is_soil == nil or is_soil == 0 then return end
		  default.grow_tree(pos, "birch")
	       end
   })

-- Vertical plants

function default.dig_up(pos, node, digger)
   --	if digger == nil then return end
   local np = {x = pos.x, y = pos.y + 1, z = pos.z}
   local nn = minetest.get_node(np)
   if nn.name == node.name then
      minetest.node_dig(np, nn, digger)
   end
end

-- Leaf decay

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
				local finds_per_second = 5000
				default.leafdecay_trunk_find_allow_accumulator =
				   math.floor(dtime * finds_per_second)
			     end)

default.after_place_leaves = function(pos, placer, itemstack, pointed_thing)
				local node = minetest.get_node(pos)
				node.param2 = 1
				minetest.set_node(pos, node)
			     end

minetest.register_abm( -- leaf decay
   {
      nodenames = {"group:leafdecay"},
      neighbors = {"air", "group:liquid"},
      -- A low interval and a high inverse chance spreads the load
      interval = 2,
      chance = 3,

      action = function(p0, node, _, _)
		  --print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
		  local do_preserve = false
		  local d = minetest.registered_nodes[node.name].groups.leafdecay
		  if not d or d == 0 then
		     --print("not groups.leafdecay")
		     return
		  end
		  local n0 = minetest.get_node(p0)
		  if n0.param2 ~= 0 then
		     --print("param2 ~= 0")
		     return
		  end
		  local p0_hash = nil
		  if default.leafdecay_enable_cache then
		     p0_hash = minetest.hash_node_position(p0)
		     local trunkp = default.leafdecay_trunk_cache[p0_hash]
		     if trunkp then
			local n = minetest.get_node(trunkp)
			local reg = minetest.registered_nodes[n.name]
			-- Assume ignore is a trunk, to make the thing work at the border of the active area
			if n.name == "ignore" or (reg and reg.groups.tree and reg.groups.tree ~= 0) then
			   --print("cached trunk still exists")
			   return
			end
			--print("cached trunk is invalid")
			-- Cache is invalid
			table.remove(default.leafdecay_trunk_cache, p0_hash)
		     end
		  end
		  if default.leafdecay_trunk_find_allow_accumulator <= 0 then
		     return
		  end
		  default.leafdecay_trunk_find_allow_accumulator =
		     default.leafdecay_trunk_find_allow_accumulator - 1
		  -- Assume ignore is a trunk, to make the thing work at the border of the active area
		  local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
		  if p1 then
		     do_preserve = true
		     if default.leafdecay_enable_cache then
			--print("caching trunk")
			-- Cache the trunk
			default.leafdecay_trunk_cache[p0_hash] = p1
		     end
		  end
		  if not do_preserve then
		     -- Drop stuff other than the node itself
		     local itemstacks = minetest.get_node_drops(n0.name)
		     for _, itemname in ipairs(itemstacks) do
			if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0 or itemname ~= n0.name then
			local p_drop = {
			   x = p0.x - 0.5 + math.random(),
			   y = p0.y - 0.5 + math.random(),
			   z = p0.z - 0.5 + math.random(),
			}
			minetest.add_item(p_drop, itemname)
		     end
		  end
		  -- Remove node
		  minetest.remove_node(p0)
		  nodeupdate(p0)
	       end
	    end
   })

minetest.register_abm( -- dirt becomes dirt with grass if uncovered
   {
      nodenames = {"default:dirt"},
      interval = 2,
      chance = 40,
      action = function(pos, node)
		  local above = {x=pos.x, y=pos.y+1, z=pos.z}
		  local name = minetest.get_node(above).name
		  local nodedef = minetest.registered_nodes[name]
		  if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light") and nodedef.liquidtype == "none" and (minetest.get_node_light(above) or 0) >= 11 then
		     minetest.set_node(pos, {name = "default:dirt_with_grass"})
	       end
	    end
   })

minetest.register_abm( -- dirt with grass becomes dirt if covered
   {
      nodenames = {"default:dirt_with_grass"},
      interval = 2,
      chance = 10,
      action = function(pos, node)
		  local above = {x=pos.x, y=pos.y+1, z=pos.z}
		  local name = minetest.get_node(above).name
		  local nodedef = minetest.registered_nodes[name]
		  if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light") and nodedef.liquidtype == "none") then
		     minetest.set_node(pos, {name = "default:dirt"})
		  end
	       end
   })

minetest.register_abm( -- grass expands
   {
      nodenames = {"default:grass"},
      interval = 20,
      chance = 160,
      action = function(pos, node)
		  local rx = math.random(0, 2) - 1
		  local rz = math.random(0, 2) - 1

		  local edgepos = {x = pos.x+rx, y = pos.y, z = pos.z+rz}
		  local downpos = {x = pos.x+rx, y = pos.y-1, z = pos.z+rz}
		  local edgenode = minetest.get_node(edgepos)
		  local downnode = minetest.get_node(downpos)
		  
		  if edgenode.name == "air" and downnode.name ~= "air" and downnode.buildable_to == false and walkable == true then
		     minetest.set_node(edgepos, {name = "default:grass"})
		  end
	       end
   })

minetest.register_abm( -- cactus grows
   {
      nodenames = {"default:cactus"},
      neighbors = {"group:sand"},
      interval = 20,
      chance = 10,
      action = function(pos, node)
		  pos.y = pos.y-1
		  local name = minetest.get_node(pos).name
		  if minetest.get_item_group(name, "sand") ~= 0 then
		     pos.y = pos.y+1
		     local height = 0
		     while minetest.get_node(pos).name == "default:cactus" and height < 3 do
			height = height+1
			pos.y = pos.y+1
		     end
		     if height < 3 then
			if minetest.get_node(pos).name == "air" then
			   minetest.set_node(pos, {name="default:cactus"})
			end
		     end
		  end
	       end,
   })

minetest.register_abm( -- papyrus grows
   {
      nodenames = {"default:papyrus"},
      neighbors = {"default:sand", "default:dirt_with_grass", "default_dirt"},
      interval = 20,
      chance = 10,
      action = function(pos, node)
		  pos.y = pos.y-1
		  local name = minetest.get_node(pos).name
		  if name == "default:sand" or name == "default:dirt" or name == "default:dirt_with_grass" then
		     if minetest.find_node_near(pos, 3, {"group:water"}) == nil then
			return
		     end
		     pos.y = pos.y+1
		     local height = 0
		     while minetest.get_node(pos).name == "default:papyrus" and height < 3 do
			height = height+1
			pos.y = pos.y+1
		     end
		     if height < 3 then
			if minetest.get_node(pos).name == "air" then
			   minetest.set_node(pos, {name="default:papyrus"})
			end
		     end
		  end
	       end,
   })

minetest.register_abm( -- torch flame
   {
      nodenames = {"default:torch"},
      interval = 5,
      chance = 1,
      action = function(pos, node)
		  minetest.add_particlespawner(
		     {
			amount = 10,
			time = 5,
			minpos = {x = pos.x-0.1, y = pos.y-0.4, z = pos.z-0.1},
			maxpos = {x = pos.x+0.1, y = pos.y, z = pos.z+0.1},
			minvel = {x = -0.3, y = 0.3, z = -0.3},
			maxvel = {x = 0.3, y = 1, z = 0.3},
			minacc = {x = 0, y = 0.5, z = -0},
			maxacc = {x = 0, y = 2, z = 0},
			minexptime = 0.3,
			maxexptime = 0.6,
			minsize = 4,
			maxsize = 6,
			texture = "spark.png"
		     })
	       end
   })

default.log("functions", "loaded")