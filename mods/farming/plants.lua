farming.register_plant(
   "wheat",
   {
      grow_time = 720,
      grows_near = {"group:water"},
      growing_distance = 3,
      grows_on = {"group:plantable_soil"},
      light_min = 8,
      light_max = 15,
})

farming.register_plant(
   "cotton",
   {
      grow_time = 1440,
      grows_near = {"group:water"},
      growing_distance = 4,
      grows_on = {"group:plantable_sandy", "group:plantable_soil"},
      light_min = 12,
      light_max = 15,
})

-- Achievements

achievements.register_achievement(
   "farmer",
   {
      title = "Farmer",
      description = "Plant 20 wheat seeds",
      times = 20,
      placenode = "farming:wheat_1",
   })

achievements.register_achievement(
   "master_farmer",
   {
      title = "Master Farmer",
      description = "Plant 200 wheat seeds",
      times = 200,
      placenode = "farming:wheat_1",
   })

achievements.register_achievement(
   "cotton_farmer",
   {
      title = "Cotton Farmer",
      description = "Plant 10 cotton seeds",
      times = 10,
      placenode = "farming:cotton_1",
   })

achievements.register_achievement(
   "master_cotton_farmer",
   {
      title = "Master Cotton Farmer",
      description = "Plant 100 cotton seeds",
      times = 100,
      placenode = "farming:cotton_1",
   })

default.log("plants", "loaded")