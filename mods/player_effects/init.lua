--
-- Player effects mod
-- By Kaadmy, for Pixture
--

player_effects = {}

player_effects.effects = {}
player_effects.registered_effects = {}

local update_time = 1 -- update every second
local timer = 10
local effects_file = core.get_worldpath() .. "/player_effects"

local function save_effects()
   local f = io.open(effects_file, "w")

   f:write(core.serialize(player_effects.effects))

   io.close(f)
end

local function load_effects()
   local f = io.open(effects_file, "r")

   if f then
      player_effects.effects = core.deserialize(f:read("*all"))

      io.close(f)
   else
      save_effects()
   end
end

function player_effects.register_effect(name, def)
   local rd = {
      title = def.title or name, -- good-looking name of the effect
      description = def.description or "The " .. name .. " effect", -- description of what the effect does
      duration = def.duration or 1, -- how long the effect lasts, <0 is infinite and has to be disabled manually
      physics = def.physics or {} -- physics overrides for the player
   }

   player_effects.registered_effects[name] = rd
end

function player_effects.get_registered_effect(ename)
   local e = player_effects.registered_effects[ename]
   
   if not e then
      default.log("[mod:player_effects] Cannot find registered player effect " .. ename, "error")

      return nil
   end

   return e
end

function player_effects.apply_effect(player, ename)
   local effect = player_effects.get_registered_effect(ename)

   if effect.duration >= 0 then
      player_effects.effects[player:get_player_name()][ename] = core.get_gametime() + effect.duration
   else
      player_effects.effects[player:get_player_name()][ename] = -1
   end

   local phys = {speed = 1, jump = 1, gravity = 1}

   for en, _ in pairs(player_effects.effects[player:get_player_name()]) do
      local effect = player_effects.get_registered_effect(en)

      if effect.physics.speed ~= nil then
	 phys.speed = phys.speed * effect.physics.speed
      end

      if effect.physics.jump ~= nil then
	 phys.jump = phys.jump * effect.physics.jump
      end

      if effect.physics.gravity ~= nil then
	 phys.gravity = phys.gravity * effect.physics.gravity
      end
   end

   player:set_physics_override(phys)

   save_effects()
end

function player_effects.remove_effect(player, ename)
   if player_effects.effects[player:get_player_name()][ename] == nil then return end

   local phys = {speed = 1, jump = 1, gravity = 1}

   for en, _ in pairs(player_effects.effects[player:get_player_name()]) do
      if en ~= ename then
	 local effect = player_effects.get_registered_effect(en)

	 if effect.physics.speed ~= nil then
	    phys.speed = phys.speed * effect.physics.speed
	 end

	 if effect.physics.jump ~= nil then
	    phys.jump = phys.jump * effect.physics.jump
	 end

	 if effect.physics.gravity ~= nil then
	    phys.gravity = phys.gravity * effect.physics.gravity
	 end
      end
   end

   player:set_physics_override(phys)

   player_effects.effects[player:get_player_name()][ename] = nil

   save_effects()
end

function player_effects.refresh_effects(player)
   local phys = {speed = 1, jump = 1, gravity = 1}

   for en, _ in pairs(player_effects.effects[player:get_player_name()]) do
      local effect = player_effects.get_registered_effect(en)

      if effect.physics.speed ~= nil then
	 phys.speed = phys.speed * effect.physics.speed
      end

      if effect.physics.jump ~= nil then
	 phys.jump = phys.jump * effect.physics.jump
      end

      if effect.physics.gravity ~= nil then
	 phys.gravity = phys.gravity * effect.physics.gravity
      end
   end

   player:set_physics_override(phys)

   save_effects()
end

function player_effects.clear_effects(player)
   -- call this if you want to clear all effects, it's faster and more efficient
   player:set_physics_override({speed = 1, jump = 1, gravity = 1})

   player_effects.effects[player:get_player_name()] = {}

   save_effects()
end

local function step(dtime)
   timer = timer + dtime
   if timer > update_time then
      local gt = core.get_gametime()

      for _, player in pairs(core.get_connected_players()) do
	 local name = player:get_player_name()

	 for ename, endtime in pairs(player_effects.effects[name]) do
	    if endtime > 0 then
	       local timeleft = endtime - gt
	       if timeleft <= 0 then
		  player_effects.remove_effect(player, ename)
	       end
	    end
	 end
      end
      timer = 0
   end
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   load_effects()

   if player_effects.effects[name] == nil then
      player_effects.effects[name] = {}
   end

   player_effects.refresh_effects(player)

   save_effects()
end

local function on_leaveplayer(player)
   save_effects()
end

local function on_dieplayer(player)
   player_effects.clear_effects(player)
end

core.register_globalstep(step)
core.register_on_joinplayer(on_joinplayer)
core.register_on_leaveplayer(on_leaveplayer)
core.register_on_dieplayer(on_dieplayer)

core.register_chatcommand(
   "player_effects",
   {
      description = "Show current player effects",
      func = function(name, param)
		local s = "Current player effects:\n"
		local ea = 0

		for ename, endtime in pairs(player_effects.effects[name]) do
		   if endtime < 0 then
		      s = s .. "  " .. player_effects.registered_effects[ename].title .. ": unlimited\n"
		   else
		      s = s .. "  " .. player_effects.registered_effects[ename].title .. ": " .. (endtime - core.get_gametime()) .. " seconds remaining\n"
		   end

		   ea = ea + 1
		end

		if ea > 0 then
		   core.chat_send_player(name, s)
		else
		   core.chat_send_player(name, "You currently have no effects")
		end
	     end
   })

player_effects.register_effect(
   "uberspeed",
   {
      title = "Uberspeed",
      description = "If you can go really fast",
      duration = -1,
      physics = {
	 speed = 8,
      }
   })
player_effects.register_effect(
   "uberspeed_cinematic",
   {
      title = "Cinematic",
      description = "Cinematic fast movement",
      duration = -1,
      physics = {
	 speed = 2,
      }
   })
core.register_privilege("uberspeed", "Can use /uberspeed command")
core.register_chatcommand(
   "uberspeed",
   {
      params = "[on|off|cinematic]",
      description = "Set Uberspeed",
      privs = {uberspeed = true},
      func = function(name, param)
		local player=core.get_player_by_name(name)

		if param == "on" then
		   player_effects.apply_effect(player, "uberspeed")
		elseif param == "cinematic" then
		   player_effects.apply_effect(player, "uberspeed_cinematic")
		elseif param == "off" then
		   player_effects.remove_effect(player, "uberspeed")
		   player_effects.remove_effect(player, "uberspeed_cinematic")
		else
		   core.chat_send_player(name, "Bad param for /uberspeed; type /help uberspeed")
		end
	     end
   })

default.log("mod:player_effects", "loaded")