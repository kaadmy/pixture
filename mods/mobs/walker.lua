-- Walker by Kaadmy

mobs:register_mob(
   "mobs:walker",
   {
      type = "monster",
      passive = false,
      attack_type = "dogfight",
      damage = 2,
      hp_min = 8,
      hp_max = 16,
      armor = 200,
      collisionbox = {-0.3, 0, -0.3, 0.3, 1.5, 0.3},
      visual = "mesh",
      mesh = "mobs_walker.b3d",
      textures = {
	 {"mobs_walker.png"},
      },
      makes_footstep_sound = true,
      sounds = {
	 attack = "mobs_swing",
	 distance = 16,
      },
      walk_velocity = 1,
      run_velocity = 5,
      jump = false,
      follow = "default:rope",
      view_range = 8,
      drops = {
	 {
	    name = "default:stick",
	    chance = 1, min = 1, max = 2
	 },
	 {
	    name = "default:stick",
	    chance = 3, min = 2, max = 4
	 },
	 {
	    name = "default:fiber",
	    chance = 15, min = 2, max = 3
	 },
      },
      water_damage = 6,
      lava_damage = 10,
      light_damage = 1,
      animation = {
	 speed_normal = 20,
	 speed_run = 30,
	 stand_start = 0,
	 stand_end = 24,
	 run_start = 35,
	 run_end = 50,
	 walk_start = 35,
	 walk_end = 50,
	 punch_start = 25,
	 punch_end = 34,
      },
})

mobs:register_spawn(
   "mobs:walker",
   {
      "default:dry_dirt",
      "default:dirt_with_dry_grass"
   },
   20,
   14,
   200000,
   1,
   31000
)
