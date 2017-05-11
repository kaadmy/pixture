-- Npc by TenPlus1
-- Modded by Kaadmy

local npc_types = {
   "farmer",
   "tavernkeeper",
   "blacksmith",
   "butcher",
}

for _, npc_type in pairs(npc_types) do
   mobs:register_mob(
      "mobs:npc_" .. npc_type,
      {
	 type = "npc",
	 passive = false,
	 collides_with_objects = false,
	 damage = 3,
	 attack_type = "dogfight",
	 attacks_monsters = true,
	 hp_min = 10,
	 hp_max = 20,
	 armor = 80,
	 collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	 visual = "mesh",
	 mesh = "mobs_npc.b3d",
	 drawtype = "front",
	 textures = {
	    {"mobs_npc1.png"},
	    {"mobs_npc2.png"},
	 },
	 makes_footstep_sound = true,
	 sounds = {},
	 walk_velocity = 2,
	 run_velocity = 3,
	 jump = true,
	 walk_chance = 50,
	 drops = {
	    {name = "default:planks_oak",
	     chance = 1, min = 1, max = 3},
	    {name = "default:apple",
	     chance = 2, min = 1, max = 2},
	    {name = "default:axe_stone",
	     chance = 5, min = 1, max = 1},
	 },
	 water_damage = 0,
	 lava_damage = 2,
	 light_damage = 0,
	 follow = "gold:gold",
	 view_range = 15,
	 owner = "",
	 order = "stand",
	 animation = {
	    speed_normal = 30,
	    speed_run = 30,
	    stand_start = 0,
	    stand_end = 79,
	    walk_start = 168,
	    walk_end = 187,
	    run_start = 168,
	    run_end = 187,
	    punch_start = 200,
	    punch_end = 219,
	 },
	 on_spawn = function(self)
		       self.npc_type = npc_type
		    end,
	 on_rightclick = function(self, clicker)
			    local item = clicker:get_wielded_item()
			    local name = clicker:get_player_name()

			    -- feed to heal npc
			    if item:get_name() == "mobs:meat" or item:get_name() == "mobs:pork" or item:get_name() == "farming:bread" then
			       
			       local hp = self.object:get_hp()
			       -- return if full health
			       if hp >= self.hp_max then
				  core.chat_send_player(name, "Villager is no longer hungry.")
				  return
			       end

			       hp = hp + 4
			       if hp > self.hp_max then hp = self.hp_max end
			       self.object:set_hp(hp)

			       -- take item
			       if not core.setting_getbool("creative_mode") then
				  item:take_item()
				  clicker:set_wielded_item(item)
			       end
			       
			       -- right clicking with trading book trades, else changes order if tame
			       -- trading is done in the gold mod
			    else
			       -- if owner switch between follow and stand
			       if not self.npc_trade then
				  self.npc_trade = util.choice_element(gold.trades[self.npc_type], gold.pr)
			       end

			       if not gold.trade(self.npc_trade, self.npc_type, clicker) then
				  if self.owner and self.owner == clicker:get_player_name() then
				     if self.order == "follow" then
					self.order = "stand"
				     else
					self.order = "follow"
				     end
				  end
			       end
			    end

			    mobs:feed_tame(self, clicker, 8, false)
			    --			 mobs:capture_mob(self, clicker, 20, 5, 10, false, nil)
			 end,
      })

   --mobs:register_spawn("mobs:npc", {"default:dirt_with_grass"}, 20, 0, 7000, 1, 31000)
   mobs:register_egg("mobs:npc_" .. npc_type, "NPC", "default_brick.png^mobs_egg.png")
end