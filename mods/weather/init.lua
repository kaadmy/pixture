--
-- Weather mod
-- By Kaadmy, for Pixture
--

weather = {}
weather.weather = "clear"
weather.types = {"storm", "snowstorm", "clear"}

local function addvec(v1, v2)
   return {x = v1.x + v2.x, y = v1.y + v2.y, z = v1.z + v2.z}
end

local snow_enable = minetest.setting_getbool("weather_snow_enable") or false

local weather_soundspec=nil
local weather_pr=PseudoRandom(minetest.get_mapgen_params().seed + 2387)

local function play_sound()
   if weather_soundspec ~= nil then
      minetest.sound_stop(weather_soundspec)
   end

   if weather.weather == "storm" then
      weather_soundspec=minetest.sound_play({name="weather_storm"})

      minetest.after(18, play_sound)
      return
   elseif weather.weather == "snowstorm" then
      weather_soundspec=minetest.sound_play({name="weather_snowstorm"})

      minetest.after(7, play_sound)
      return
   end

   minetest.after(3, play_sound)
end

function setweather_type(type)
   local valid = false
   for i = 1, #weather.types do
      if weather.types[i] == type then
	 valid = true
      end
   end
   if valid then
      weather.weather = type
      play_sound()
   end
end

minetest.register_globalstep(
   function(dtime)
      if minetest.setting_getbool("weather_enable") then
	 if weather_pr:next(0, 5000) < 1 then
	    local weathertype = weather_pr:next(0, 19)

	    -- on avg., every 1800 frames the weather.weather will change to one of:
	    -- 13/20 chance of clear weather
	    -- 6/20 chance or stormy weather
	    -- 1/20 chance of snowstorm weather

	    if weathertype < 13 then
	       weather.weather = "clear"
	    elseif weathertype < 19 then
	       weather.weather = "storm"
	    elseif weathertype < 20 and snow_enable then
	       weather.weather = "snowstorm"
	    end
	 end
      end

      local light = (minetest.get_timeofday()*2)

      if light > 1 then
	 light=1-(light-1)
      end
      light=(light*0.6)+0.1

      local skycol=math.floor(light*190)

      for _,player in ipairs(minetest.get_connected_players()) do
	 if weather.weather == "storm" or weather.weather == "snowstorm" then
	    player:set_sky({r = skycol, g = skycol, b = skycol*1.2}, "plain", {})
	    player:override_day_night_ratio(light)
	 else
	    player:set_sky(nil, "regular", {})
	    player:override_day_night_ratio(nil)
	 end

	 local p=player:getpos()

	 if weather.weather == "storm" then
	    if minetest.get_node_light({x=p.x, y=p.y+15, z=p.z}, 0.5) == 15 then
	       local minpos = addvec(player:getpos(), {x = -15, y = 15, z = -15})
	       local maxpos = addvec(player:getpos(), {x = 15, y = 10, z = 15})
	       minetest.add_particlespawner(
		  {
		     amount = 30,
		     time = 0.5,
		     minpos = minpos,
		     maxpos = maxpos,
		     minvel = {x = 0, y = -20, z = 0},
		     maxvel = {x = 0, y = -20, z = 0},
		     minexptime = 0.9,
		     maxexptime = 1.1,
		     minsize = 2,
		     maxsize = 3,
		     collisiondetection = true,
		     collision_removal = true,
		     vertical = true,
		     texture = "weather_rain.png",
		     playername = player:get_player_name()
		  }
	       )
	    end
	 elseif weather.weather == "snowstorm" then
	    if math.random(0, 6000*dtime) <= 1 then
	       local hp = player:get_hp()

	       if minetest.get_node_light(p) == 15 then
		  player:set_hp(hp-1)
	       end
	    end

	    if minetest.get_node_light({x=p.x, y=p.y+15, z=p.z}, 0.5) == 15 then
	       local minpos = addvec(player:getpos(), {x = -30, y = 20, z = -30})
	       local maxpos = addvec(player:getpos(), {x = 30, y = 15, z = 30})
	       local vel = {x = 16.0, y = -8, z = 13.0}
	       local acc = {x = -16.0, y = -8, z = -13.0}
	       minetest.add_particlespawner(
		  {
		     amount = 8,
		     time = 0.4,
		     minpos = minpos,
		     maxpos = maxpos,
		     minvel = {x=-vel.x, y=vel.y, z=-vel.z},
		     maxvel = vel,
		     minacc = acc,
		     maxacc = acc,
		     minexptime = 1.0,
		     maxexptime = 1.4,
		     minsize = 3,
		     maxsize = 4,
		     collisiondetection = true,
		     collision_removal = true,
		     vertical = false,
		     texture = "weather_snowflake.png",
		     playername = player:get_player_name()
		  }
	       )
	    end
	 end
      end
   end
)

minetest.register_privilege("weather", "Can use /weather command")

minetest.register_chatcommand(
   "weather",
   {
      params = "[storm|snowstorm|clear]",
      description = "Set the weather to either clear, storm, or snowstorm",
      privs = {weather= true},
      func = function(name, param)
         setweather_type(param)
      end
})

setweather_type("clear")

default.log("mod:weather", "loaded")
