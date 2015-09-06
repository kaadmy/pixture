-- Mineturtle by Kaadmy

mobs:register_mob(
   "mobs:mineturtle",
   {
      type = "monster",
      passive = false,
      attack_type = "explode",
      hp_min = 10,
      hp_max = 15,
      armor = 200,
      collisionbox = {-0.4, 0, -0.4, 0.4, 0.7, 0.4},
      visual = "mesh",
      mesh = "mobs_mineturtle.x",
      textures = {
	 {"mobs_mineturtle.png"},
      },
      makes_footstep_sound = false,
      sounds = {
	 random = "mobs_mineturtle",
	 explode= "tnt_explode",
	 distance = 16,
      },
      walk_velocity = 2,
      run_velocity = 4,
      jump = true,
      follow = "tnt:tnt",
      view_range = 10,
      drops = {
	 {name = "tnt:tnt",
	  chance = 1, min = 1, max = 3},
      },
      water_damage = 1,
      lava_damage = 5,
      light_damage = 0,
      animation = {
	 speed_normal = 25,
	 speed_run = 35,
	 stand_start = 0,
	 stand_end = 30,
	 run_start = 31,
	 run_end = 50,
	 walk_start = 31,
	 walk_end = 50,
	 punch_start = 51,
	 punch_end = 60,
      },
      on_rightclick = function(self, clicker)
			 mobs:feed_tame(self, clicker, 4, false)
			 mobs:capture_mob(self, clicker, 0, 20, 40, false, nil)
		      end,
   })

mobs:register_spawn("mobs:mineturtle", {"default:dirt_with_grass"}, 20, 5, 200000, 1, 31000)
mobs:register_egg("mobs:mineturtle", "Mine Turtle", "mobs_mineturtle_inventory.png")