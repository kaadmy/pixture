--
-- Ambiance mod
-- By Kaadmy, for Pixture
--

ambiance = {}

ambiance.sounds = {}

ambiance.sounds["birds"] = {
   length = 5.0,
   chance = 4,
   file = "ambiance_birds",
   dist = 8,
   nodename = "group:leaves",
   can_play = function(pos)
		 local tod = (minetest.get_timeofday() or 1) * 2

		 if tod > 0.47 and tod < 1.53 then -- bit of overlap into crickets
		    return true
		 end

		 return false
	      end,
}

ambiance.sounds["crickets"] = {
   length = 6.0,
   chance = 3,
   file = "ambiance_crickets",
   dist = 8,
   nodename = "group:grass",
   can_play = function(pos)
		 local tod = (minetest.get_timeofday() or 1) * 2

		 if tod < 0.5 or tod > 1.5 then
		    return true
		 end

		 return false
	      end,
}

ambiance.sounds["flowing_water"] = {
   length = 3.3,
   chance = 1,
   file = "default_water",
   dist = 16,
   nodename = "group:flowing_water",
}

local ambiance_volume = tonumber(minetest.setting_get("ambiance_volume")) or 1.0

local soundspec = {}
local lastsound = {}

local function ambient_node_near(sound, pos)   local nodepos = minetest.find_node_near(pos, sound.dist, sound.nodename)

   if nodepos ~= nil and math.random(1, sound.chance) == 1 then
      return nodepos
   end

   return nil
end

local function step(dtime)
   local player_positions = {}

   for _, player in ipairs(minetest.get_connected_players()) do
      local pos = player:getpos()
      local name = player:get_player_name()


      for soundname, sound in pairs(ambiance.sounds) do
	 if lastsound[name][soundname] then
	    lastsound[name][soundname] = lastsound[name][soundname] + dtime
	 else
	    lastsound[name][soundname] = 0
	 end

	 if lastsound[name][soundname] > sound.length then
	    local sourcepos = ambient_node_near(sound, pos)

	    if sound.can_play and sourcepos ~= nil and (not sound.can_play(sourcepos)) then
	       sourcepos = nil
	    end
	    
	    if sourcepos == nil then
	       if soundspec[name][soundname] then
		  minetest.sound_stop(soundspec[name][soundname])

		  soundspec[name][soundname] = nil
		  lastsound[name][soundname] = 0
	       end
	    else
	       local ok = true
	       for _, p in pairs(player_positions) do
		  if (p.x * pos.x) + (p.y * pos.y) + (p.z * pos.z) < sound.dist*sound.dist then
		     ok = false
		  end
	       end

	       if ok then
		  soundspec[name][soundname] = minetest.sound_play(
		     sound.file,
		     {
			pos = sourcepos,
			max_hear_distance = sound.dist,
		     })
		  
		  lastsound[name][soundname] = 0
	       end
	    end
	 end
      end

      table.insert(player_positions, pos)
   end
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   soundspec[name] = {}
   lastsound[name] = {}
end

local function on_leaveplayer(player)
   local name = player:get_player_name()

   soundspec[name] = nil
   lastsound[name] = nil
end

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_leaveplayer(on_leaveplayer)
minetest.register_globalstep(step)

default.log("mod:ambiance", "loaded")