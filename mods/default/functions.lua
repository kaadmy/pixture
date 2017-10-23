--
-- Functions/ABMs
--

-- Chest naming via signs

function default.write_name(pos, text)
   -- Check above, if allowed

   if minetest.settings:get_bool("signs_allow_name_above") then
      local above = {x = pos.x, y = pos.y + 1, z = pos.z}

      local abovedef = nil

      if minetest.registered_nodes[minetest.get_node(above).name] then
	 abovedef = minetest.registered_nodes[minetest.get_node(above).name]
      end
      if abovedef and abovedef.write_name ~= nil then
	 abovedef.write_name(above, text)
      end
   end

   -- Then below

   local below = {x = pos.x, y = pos.y - 1, z = pos.z}

   local belowdef = nil

   if minetest.registered_nodes[minetest.get_node(below).name] then
      belowdef = minetest.registered_nodes[minetest.get_node(below).name]
   end

   if belowdef and belowdef.write_name ~= nil then
      belowdef.write_name(below, text)
   end
end

-- Saplings growing and placing

function default.place_sapling(itemstack, placer, pointed_thing)
   -- Check growability

   local underdef = minetest.get_node(pointed_thing.under)

   if minetest.get_item_group(underdef.name, "soil") == 0 then
      return itemstack
   end

   minetest.set_node(pointed_thing.above, {name = itemstack:get_name()})

   itemstack:take_item()

   return itemstack
end

function default.begin_growing_sapling(pos)
   local node = minetest.get_node(pos)

   if node.name == "default:sapling" then
      minetest.get_node_timer(pos):start(math.random(300, 480))
   elseif node.name == "default:sapling_oak" then
      minetest.get_node_timer(pos):start(math.random(700, 960))
   elseif node.name == "default:sapling_birch" then
      minetest.get_node_timer(pos):start(math.random(480, 780))
   end
end

function default.grow_sapling(pos, variety)
   local function grow()
      if variety == "apple" then
	 minetest.place_schematic(
            {
               x = pos.x - 2,
               y = pos.y - 1,
               z = pos.z - 2
            },
            minetest.get_modpath("default")
               .. "/schematics/default_tree.mts", "0", {}, false)
      elseif variety == "oak" then
	 minetest.place_schematic(
            {
               x = pos.x - 2,
               y = pos.y - 1,
               z = pos.z - 2
            },
            minetest.get_modpath("default")
               .. "/schematics/default_tree.mts", "0",
            {
               ["default:leaves"] = "default:leaves_oak",
               ["default:tree"] = "default:tree_oak",
               ["default:apple"] = "air"
            }, false)
      elseif variety == "birch" then
	 minetest.place_schematic(
            {
               x = pos.x - 1,
               y = pos.y - 1,
               z = pos.z - 1
            },
            minetest.get_modpath("default")
               .. "/schematics/default_squaretree.mts", "0",
            {
               ["default:leaves"] = "default:leaves_birch",
               ["default:tree"] = "default:tree_birch",
               ["default:apple"] = "air"
            }, false)
      end
   end

   minetest.remove_node(pos)

   minetest.after(0, grow)

   default.log("A " .. variety .. " tree sapling grows at " ..
                  minetest.pos_to_string(pos), "info")
end

-- Make preexisting trees restart the growing process

minetest.register_lbm(
   {
      label = "Grow legacy trees",
      name = "default:grow_legacy_trees",
      nodenames = {"default:sapling", "default:sapling_oak", "default:sapling_birch"},
      action = function(pos, node)
         default.begin_growing_sapling(pos)
      end
   }
)

-- Vertical plants

function default.dig_up(pos, node, digger)
   --	if digger == nil then return end
   local np = {x = pos.x, y = pos.y + 1, z = pos.z}
   local nn = minetest.get_node(np)
   if nn.name == node.name then
      minetest.node_dig(np, nn, digger)
   end
end

function default.dig_down(pos, node, digger)
   local np = {x = pos.x, y = pos.y - 1, z = pos.z}
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

      label = "Leaf decay",
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
         end
      end
})

minetest.register_abm( -- dirt and grass footsteps becomes dirt with grass if uncovered
   {
      label = "Grow dirt",
      nodenames = {"default:dirt", "default:dirt_with_grass_footsteps"},
      interval = 2,
      chance = 40,
      action = function(pos, node)
         local above = {x=pos.x, y=pos.y+1, z=pos.z}
         local name = minetest.get_node(above).name
         local nodedef = minetest.registered_nodes[name]
         if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light") and nodedef.liquidtype == "none" and (minetest.get_node_light(above) or 0) >= 8 then
            minetest.set_node(pos, {name = "default:dirt_with_grass"})
         end
      end
})

minetest.register_abm( -- dirt with grass becomes dirt if covered
   {
      label = "Remove grass on covered dirt",
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
      label = "Grass expansion",
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

minetest.register_abm( -- clams grow
   {
      label = "Growing clams",
      nodenames = {"default:clam"},
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
            minetest.set_node(edgepos, {name = "default:clam"})
         end
      end
})

minetest.register_abm( -- cactus grows
   {
      label = "Growing cacti",
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
      label = "Growing papyrus",
      nodenames = {"default:papyrus"},
      neighbors = {"group:plantable_sandy", "group:plantable_soil"},
      interval = 20,
      chance = 10,
      action = function(pos, node)
         pos.y = pos.y-1
         local name = minetest.get_node(pos).name

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
      end,
})

minetest.register_abm( -- weak torchs burn out and die after ~3 minutes
   {
      label = "Burning out weak torches",
      nodenames = {"default:torch_weak"},
      interval = 3,
      chance = 60,
      action = function(pos, node)
         minetest.set_node(pos, {name = "default:torch_dead", param = node.param, param2 = node.param2})
      end
})

default.log("functions", "loaded")
