--
-- Partial blocks mod
-- By Kaadmy, for Pixture
--

partialblocks = {}

function partialblocks.register_material(name, desc, node, can_burn)
   local nodedef = minetest.registered_nodes[node]

   if nodedef == nil then
      minetest.log("warning", "Cannot find node for partialblock: " .. node)
      return
   end

   -- Slab
   minetest.register_node(
      "partialblocks:" .. name .. "_slab",
      {
	 tiles = nodedef.tiles,
	 groups = nodedef.groups,
	 sounds = nodedef.sounds,

	 description = desc .. " slab",
	 drawtype = "nodebox",

	 node_box = {
	    type = "wallmounted",
	    wall_top = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
	    wall_side = {-0.5, -0.5, -0.5, 0, 0.5, 0.5},
	    wall_bottom = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	 },

	 paramtype = "light",
	 paramtype2 = "wallmounted",
      })
   minetest.register_craft( -- Craft to
      {
	 output = "partialblocks:" .. name .. "_slab 3",
	 recipe = {
	    {node, node, node},
	 },
      })
   minetest.register_craft( -- Craft back
      {
	 output = node,
	 type = "shapeless",
	 recipe = {"partialblocks:" .. name .. "_slab"},
      })

   if can_burn then
      minetest.register_craft( -- Fuel
	 {
	    type = "fuel",
	    recipe = "partialblocks:" .. name .. "_slab",
	    burntime = 7,
	 })
   end

   -- Stair
   minetest.register_node(
      "partialblocks:" .. name .. "_stair",
      {
	 tiles = nodedef.tiles,
	 groups = nodedef.groups,
	 sounds = nodedef.sounds,

	 description = desc .. " stair",
	 drawtype = "nodebox",

	 node_box = {
	    type = "fixed",
	    fixed = {
	       {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	       {-0.5, 0, 0, 0.5, 0.5, 0.5},
	    },
	 },

	 paramtype = "light",
	 paramtype2 = "facedir",
      })
   minetest.register_craft( -- Craft to
      {
	 output = "partialblocks:" .. name .. "_stair 6",
	 recipe = {
	    {node, "", ""},
	    {node, node, ""},
	    {node, node, node},
	 },
      })
   minetest.register_craft( -- Craft back
      {
	 output = node,
	 type = "shapeless",
	 recipe = {"partialblocks:" .. name .. "_stair"},
      })

   if can_burn then
      minetest.register_craft( -- Fuel
	 {
	    type = "fuel",
	    recipe = "partialblocks:" .. name .. "_stair",
	    burntime = 7,
	 })
   end
end

-- Register some default node partials
partialblocks.register_material("cobble", "Cobble", "default:cobble", false)
partialblocks.register_material("stone", "Stone", "default:stone", false)
partialblocks.register_material("brick", "Brick", "default:brick", false)

partialblocks.register_material("wood", "Wood", "default:planks", true)
partialblocks.register_material("oak", "Oak", "default:planks_oak", true)
partialblocks.register_material("birch", "Birch", "default:planks_birch", true)

partialblocks.register_material("steel", "Steel", "default:block_steel", false)
partialblocks.register_material("compressed_sandstone", "Compressed Sandstone", "default:compressed_sandstone", false)
partialblocks.register_material("reinforced_cobble", "Reinforced Cobble", "default:reinforced_cobble", false)
partialblocks.register_material("frame", "Frame", "default:frame", false)
partialblocks.register_material("reinforced_frame", "Reinforced Frame", "default:reinforced_frame", false)
partialblocks.register_material("coal", "Coal", "default:block_coal", false)

default.log("mod:partialblocks", "loaded")
