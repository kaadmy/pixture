--
-- Partial blocks mod
-- By Kaadmy, for Pixture
--

partialblocks = {}

function partialblocks.register_material(name, desc, node)
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
end

-- Register some default node partials
partialblocks.register_material("cobble", "Cobble", "default:cobble")
partialblocks.register_material("stone", "Stone", "default:stone")
partialblocks.register_material("brick", "Brick", "default:brick")

partialblocks.register_material("wood", "Wood", "default:planks")
partialblocks.register_material("oak", "Oak", "default:planks_oak")
partialblocks.register_material("birch", "Birch", "default:planks_birch")

default.log("mod:partialblocks", "loaded")