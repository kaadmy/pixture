--
-- Hunger mod
-- For nodetest
-- Tweaked by Kaadmy, for Pixture
--

hunger = {}

-- Per-player userdata

hunger.userdata = {}

local particlespawners = {}
local player_step = {}
local player_health_step = {}
local player_bar = {}

-- Seconds per hunger update, 2.0 is slightly fast
local timer_interval = tonumber(minetest.setting_get("hunger_step")) or 3.0
local timer = 0

local hunger_file = minetest.get_worldpath() .. "/hunger.dat"
local saving = false

local function save_hunger()
   local f = io.open(hunger_file, "w")

   for name, data in pairs(hunger.userdata) do
      f:write(data.hunger .. " " .. data.saturation .. " " .. name .. "\n")
   end

   io.close(f)

   saving = false
end

local function delayed_save()
   if not saving then
      saving = true

      minetest.after(5, save_hunger)
   end
end

local function load_hunger()
   local f = io.open(hunger_file, "r")
   if f then
      repeat
	 local hnger = f:read("*n")
	 local sat = f:read("*n")
	 local name = f:read("*l")

	 if name == nil or sat == nil then
            break
         end

	 name = name:sub(2)

         if not hunger.userdata[name] then
            hunger.userdata[name] = {
               hunger = 20,
               active = 0,
               moving = 0,
               saturation = 0,
            }
         end

         if hnger then
            hunger.userdata[name].hunger = hnger
         end
         if sat then
            hunger.userdata[name].saturation = sat
         end

      until f:read(0) == nil
      io.close(f)
   else
      save_hunger()
   end
end

local function on_load()
   load_hunger()
end

function hunger.update_bar(player)
   if not player then
      return
   end

   local name = player:get_player_name()

   if player_bar[name] then
      player:hud_change(player_bar[name], "number", hunger.userdata[name].hunger)
   else
      player_bar[name] = player:hud_add(
	 {
	    hud_elem_type = "statbar",
	    position = {x=0.5,y=1.0},
	    text = "hunger.png",
	    number = hunger.userdata[name].hunger,
	    dir = 0,
	    size = {x=16, y=16},
	    offset = {x=64, y=-(48+24+16)},
      })
   end
end

local function on_dignode(pos, oldnode, player)
   if not player then
      return
   end

   local name = player:get_player_name()

   hunger.userdata[name].active = hunger.userdata[name].active + 2
end

local function on_placenode(pos, node, player)
   if not player then
      return
   end

   local name = player:get_player_name()

   hunger.userdata[name].active = hunger.userdata[name].active + 2
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   if not hunger.userdata[name] then
      hunger.userdata[name] = {
         hunger = 20,
         active = 0,
         moving = 0,
         saturation = 0,
      }
   end

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
end

local function on_leaveplayer(player)
   local name = player:get_player_name()

   player_bar[name] = nil
end

local function on_respawnplayer(player)
   local name = player:get_player_name()

   hunger.userdata[name].hunger = 20
   hunger.update_bar(player)

   delayed_save()
end

local function on_item_eat(hpdata, replace_with_item, itemstack,
                           player, pointed_thing)
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

   hunger.userdata[name].hunger = hunger.userdata[name].hunger + hp_change


   hunger.userdata[name].hunger = math.min(20, hunger.userdata[name].hunger)
   hunger.userdata[name].saturation = math.min(100, hunger.userdata[name].saturation
                                                  + saturation)

   local headpos  = player:getpos()

   headpos.y = headpos.y + 1
   minetest.sound_play("hunger_eat", {pos = headpos, max_hear_distance = 8})

   particlespawners[name] = minetest.add_particlespawner(
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

   minetest.after(0.15, function()
                     minetest.delete_particlespawner(particlespawners[name])
   end)

   player_effects.apply_effect(player, "hunger_eating")

   hunger.update_bar(player)
   hunger.save_hunger()

   itemstack:take_item(1)

   return itemstack
end

local function on_globalstep(dtime)
   timer = timer + dtime

   if timer < timer_interval then
      return
   end

   timer = 0

   for _,player in ipairs(minetest.get_connected_players()) do
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

      hunger.userdata[name].moving = math.max(0, moving)
   end

   for _,player in ipairs(minetest.get_connected_players()) do
      local name = player:get_player_name()
      local hp = player:get_hp()

      if hunger.userdata[name] == nil then
         hunger.userdata[name] = {
            hunger = 20,
            active = 0,
            moving = 0,
            saturation = 0,
         }
      end

      if not player_step[name] then
         player_step[name] = 0
      end

      hunger.userdata[name].active = hunger.userdata[name].active +
         hunger.userdata[name].moving

      player_step[name] = player_step[name] + hunger.userdata[name].active + 1

      hunger.userdata[name].saturation = hunger.userdata[name].saturation - 1

      if hunger.userdata[name].saturation <= 0 then
         hunger.userdata[name].saturation = 0
         if player_step[name] >= 24 then -- how much the player has been active
            player_step[name] = 0
            hunger.userdata[name].hunger = hunger.userdata[name].hunger - 1
            if hunger.userdata[name].hunger <= 0 and hp >= 0 then
               player:set_hp(hp - 1)
               hunger.userdata[name].hunger = 0

               local pos_sound  = player:getpos()
               minetest.chat_send_player(
                  name, minetest.colorize("#f00", "You are hungry."))
            end
         end
      end

      hunger.userdata[name].active = 0
      hunger.update_bar(player)

      if player_health_step[name] == nil then player_health_step[name] = 0 end

      player_health_step[name] = player_health_step[name] + 1
      if hp > 0 and hp < 20 and player_health_step[name] >= 5
      and hunger.userdata[name].hunger >= 16 then
         player_health_step[name] = 0
         player:set_hp(hp+1)
      end
   end

   delayed_save()
end

local function fake_on_item_eat(hpdata, replace_with_item, itemstack,
                                player, pointed_thing)
   local headpos  = player:getpos()
   headpos.y = headpos.y + 1
   minetest.sound_play(
      "hunger_eat",
      {
         pos = headpos,
         max_hear_distance = 8
   })

   itemstack:take_item(1)

   return itemstack
end

if minetest.setting_getbool("hunger_enable") then

   minetest.register_on_dignode(on_dignode)
   minetest.register_on_placenode(on_placenode)

   minetest.register_on_joinplayer(on_joinplayer)

   minetest.register_on_leaveplayer(on_leaveplayer)

   minetest.register_on_respawnplayer(on_respawnplayer)

   minetest.register_on_item_eat(on_item_eat)

   minetest.register_globalstep(on_globalstep)
else
   minetest.register_on_item_eat(fake_on_item_eat)
end

player_effects.register_effect(
   "hunger_eating",
   {
      title = "Eating",
      description = "If you are eating food",
      duration = 2,
      physics = {
         speed = 0.6,
      }
})
