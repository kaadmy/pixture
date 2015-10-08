farming.register_plant(
   "wheat",
   {
      grow_time = 1440,
      grows_near = {"group:water"},
      growing_distance = 3,
      grows_on = {"group:plantable_soil"},
      light_min = 8,
      light_max = 15,
})

farming.register_plant(
   "cotton",
   {
      grow_time = 2880,
      grows_near = {"group:water"},
      growing_distance = 4,
      grows_on = {"group:plantable_soil"},
      light_min = 12,
      light_max = 15,
})

default.log("plants", "loaded")