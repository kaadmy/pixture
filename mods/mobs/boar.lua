
-- Warthog(Boar) by KrupnoPavel
-- Changed to Boar and tweaked by Kaadmy

mobs:register_mob(
   "mobs:boar",
   {
      type = "animal",
      passive = false,
      attack_type = "dogfight",
      damage = 2,
      hp_min = 15,
      hp_max = 20,
      armor = 200,
      collisionbox = {-0.4, -1, -0.4, 0.4, 0.1, 0.4},
      visual = "mesh",
      mesh = "mobs_boar.x",
      textures = {
	 {"mobs_boar.png"},
      },
      makes_footstep_sound = true,
      sounds = {
	 random = "mobs_boar",
	 attack = "mobs_boar_angry",
	 distance = 16,
      },
      walk_velocity = 2,
      run_velocity = 3,
      jump = true,
      follow = "default:apple",
      view_range = 10,
      drops = {
	 {name = "mobs:pork_raw",
	  chance = 1, min = 1, max = 4},
      },
      water_damage = 1,
      lava_damage = 5,
      light_damage = 0,
      animation = {
	 speed_normal = 20,
	 stand_start = 0,
	 stand_end = 60,
	 walk_start = 61,
	 walk_end = 80,
	 punch_start = 90,
	 punch_end = 110,
      },
      on_rightclick = function(self, clicker)
			 mobs:feed_tame(self, clicker, 8, true)
			 mobs:capture_mob(self, clicker, 0, 5, 40, false, nil)
		      end,
   })

mobs:register_spawn("mobs:boar", {"default:dirt_with_grass"}, 20, 10, 15000, 1, 31000)
mobs:register_egg("mobs:boar", "Boar", "mobs_boar_inventory.png")

-- raw porkchop
minetest.register_craftitem(
   "mobs:pork_raw",
   {
      description = "Raw Porkchop",
      inventory_image = "mobs_pork_raw.png",
      on_use = minetest.item_eat({hp = 4, sat = 30}),
   })

-- cooked porkchop
minetest.register_craftitem(
   "mobs:pork",
   {
      description = "Cooked Porkchop",
      inventory_image = "mobs_pork_cooked.png",
      on_use = minetest.item_eat({hp = 8, sat = 50}),
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "mobs:pork",
      recipe = "mobs:pork_raw",
      cooktime = 5,
   })