--
-- Hunger mod
-- For nodetest
-- Tweaked by Kaadmy, for Pixture
--

hunger = {}

hunger.hunger = {} -- the hunger level for each player
hunger.active = {} -- how a player has been active recently
hunger.moving = {} -- how much the player is moving
hunger.saturation = {} -- how saturated with food the player is

local particlespawners = {}
local player_step = {}
local player_health_step = {}
local player_bar = {}
local base_interval = tonumber(core.setting_get("hunger_step")) or 3.0 -- seconds per hunger update, 2.0 is slightly fast
local file = core.get_worldpath() .. "/hunger"

function hunger.save_hunger()
   local output = io.open(file, "w")
   for name, v in pairs(hunger.hunger) do
      output:write(hunger.hunger[name].." "..hunger.saturation[name].." "..name.."\n")
   end
   io.close(output)
end

local function load_hunger()
   local input = io.open(file, "r")
   if input then
      repeat
	 local hnger = input:read("*n")
	 local sat = input:read("*n")
	 local name = input:read("*l")

	 if name == nil or sat == nil then break end

	 name = name:sub(2)

	 if not hnger then hnger = 20 end
	 if not sat then say = 0 end

	 hunger.hunger[name] = hnger
	 hunger.saturation[name] = sat

--	 core.log("action", name.." has "..hnger.." hunger and is saturated to "..sat.."%")
      until input:read(0) == nil
      io.close(input)
   else
      hunger.save_hunger()
   end
end

load_hunger()

function hunger.update_bar(player)
   if not player then return end
   local name = player:get_player_name()
   if player_bar[name] then
      player:hud_change(player_bar[name], "number", hunger.hunger[name])
   else
      player_bar[name] = player:hud_add(
	 {
	    hud_elem_type = "statbar",
	    position = {x=0.5,y=1.0},
	    text = "hunger.png",
	    number = hunger.hunger[name],
	    dir = 0,
	    size = {x=16, y=16},
	    offset = {x=64, y=-(48+24+16)},
	 })
   end
end

if core.setting_getbool("enable_damage") and core.setting_getbool("hunger_enable") then
   player_effects.register_effect(
      "hunger_eating",
      {
	 title = "Eating",
	 description = "If you are eating food",
	 durtion = 2,
	 physics = {
	    speed = 0.6,
	 }
      })

   -- Prevent players from starving while afk (<--joke)
   core.register_on_dignode(
      function(pos, oldnode, player)
	 if not player then return end
	 local name = player:get_player_name()
	 hunger.active[name] = hunger.active[name]+ 2
      end)

   core.register_on_placenode(
      function(pos, node, player)
	 if not player then return end
	 local name = player:get_player_name()
	 hunger.active[name] = hunger.active[name]+ 2
      end)

   core.register_on_joinplayer(
      function(player)
	 local name = player:get_player_name()
	 if not hunger.hunger[name] then hunger.hunger[name] = 20 end
	 player:hud_add(
	    {
	       hud_elem_type = "statbar",
	       position = {x=0.5,y=1.0},
	       text = "hunger.png^[colorize:#666666:255",
	       number = 20,
	       dir = 0,
	       size = {x=16, y=16},
	       offset = {x=64, y=-(48+24+16)},
	    })
	 
	 hunger.update_bar(player)
      end)

   core.register_on_leaveplayer(
      function(player)
	 local name = player:get_player_name()
	 player_bar[name] = nil
      end)

   core.register_on_respawnplayer(
      function(player)
	 local name = player:get_player_name()
	 hunger.hunger[name] = 20
	 hunger.update_bar(player)
	 hunger.save_hunger()
      end)

   core.register_on_item_eat(
      function(hpdata, replace_with_item, itemstack, player, pointed_thing)
	 if not player then return end
	 if not hpdata then return end

	 local hp_change = 0
	 local saturation = 2
	 
	 if type(hpdata) == "number" then
	    hp_change = hpdata
	 else
	    hp_change = hpdata.hp
	    saturation = hpdata.sat
	 end

	 local name = player:get_player_name()

	 hunger.hunger[name] = hunger.hunger[name] + hp_change
	 if hunger.hunger[name] > 20 then
	    hunger.hunger[name] = 20
	 end

	 hunger.saturation[name] = hunger.saturation[name] + saturation
	 if hunger.saturation[name] > 100 then
	    hunger.saturation[name] = 100
	 end

	 local headpos  = player:getpos()
	 headpos.y = headpos.y + 1
	 core.sound_play("hunger_eat", {pos = headpos, max_hear_distance = 8})

	 particlespawners[name] = core.add_particlespawner(
	    {
	       amount = 10,
	       time = 0.1,
	       minpos = {x = headpos.x - 0.3, y = headpos.y - 0.3, z = headpos.z - 0.3},
	       maxpos = {x = headpos.x + 0.3, y = headpos.y + 0.3, z = headpos.z + 0.3},
	       minvel = {x = -1, y = -1, z = -1},
	       maxvel = {x = 1, y = 0, z = 1},
	       minacc = {x = 0, y = 6, z = 0},
	       maxacc = {x = 0, y = 1, z = 0},
	       minexptime = 0.5,
	       maxexptime = 1,
	       minsize = 0.5,
	       maxsize = 2,
	       texture = "magicpuff.png"
	    })

	 core.after(0.15, function() core.delete_particlespawner(particlespawners[name]) end)

	 player_effects.apply_effect(player, "hunger_eating")

	 hunger.update_bar(player)
	 hunger.save_hunger()

	 itemstack:take_item(1)

	 return itemstack
      end)

   -- Main function
   local timer = 0
   core.register_globalstep(
      function(dtime)
	 for _,player in ipairs(core.get_connected_players()) do
	    local name = player:get_player_name()
	    local controls = player:get_player_control()
	    local moving = 0

	    if controls.up or controls.down or controls.left or controls.right then
	       moving = moving + 1
	    end

	    if controls.sneak and not controls.aux1 then
	       moving = moving - 1
	    end

	    if controls.jump then
	       moving = moving + 1
	    end

	    if controls.aux1 then -- sprinting
	       moving = moving + 3
	    end

	    if moving < 0 then moving = 0 end

	    hunger.moving[name] = moving
	 end
	 
	 timer = timer + dtime

	 if timer < base_interval then return end

	 timer = 0
	 for _,player in ipairs(core.get_connected_players()) do
	    local name = player:get_player_name()
	    local hp = player:get_hp()

	    if not hunger.hunger[name] then hunger.hunger[name] = 20 end
	    if not hunger.saturation[name] then hunger.saturation[name] = 0 end

	    if not player_step[name] then player_step[name] = 0 end
	    if not hunger.active[name] then hunger.active[name] = 0 end
	    if hunger.moving[name] == nil then hunger.moving[name] = 0 end

	    hunger.active[name] = hunger.active[name] + hunger.moving[name]

	    player_step[name] = player_step[name] + hunger.active[name] + 1

	    hunger.saturation[name] = hunger.saturation[name] - 1

	    if hunger.saturation[name] <= 0 then
	       hunger.saturation[name] = 0
	       if player_step[name] >= 24 then -- how much the player has been active
		  player_step[name] = 0
		  hunger.hunger[name] = hunger.hunger[name] - 1
		  if hunger.hunger[name] <= 0 and hp >= 0 then
		     player:set_hp(hp - 1)
		     hunger.hunger[name] = 0
		     
		     local pos_sound  = player:getpos()
		     core.chat_send_player(name, "You are hungry.")
		  end
	       end
	    end

	    hunger.active[name] = 0
	    hunger.update_bar(player)

	    if player_health_step[name] == nil then player_health_step[name] = 0 end

	    player_health_step[name] = player_health_step[name] + 1
	    if hp > 0 and hp < 20 and player_health_step[name] >= 5 and hunger.hunger[name] >= 16 then
	       player_health_step[name] = 0
	       player:set_hp(hp+1)
	    end
	 end

	 hunger.save_hunger()
      end)
else
   core.register_on_item_eat(
      function(hpdata, replace_with_item, itemstack, player, pointed_thing)
	 local headpos  = player:getpos()
	 headpos.y = headpos.y + 1
	 core.sound_play("hunger_eat", {pos = headpos, max_hear_distance = 8})

	 itemstack:take_item(1)

	 return itemstack
      end)
end