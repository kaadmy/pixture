
--
-- Mapgen
--

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.008,
      biomes = {"Wilderness"},
      decoration = {"farming:wheat_4"},
      y_min = 0,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.006,
      biomes = {"Grassland", "Savanna"},
      decoration = {"farming:wheat_4"},
      y_min = 0,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:sand",
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Desert"},
      decoration = {"farming:cotton_4"},
      y_min = 0,
      y_max = 32000,
})

default.log("mapgen", "loaded")
