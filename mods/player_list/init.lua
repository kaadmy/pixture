--
-- Player listing mod
-- By Kaadmy, for Pixture
--

player_list = {}

-- current players format:
-- {<playername> = <last connect(if connected, or nil)>}
player_list.players = {}

local function divmod(f, d)
   return {math.floor(f / d), f % d}
end

local function prettytime(time)
   local a = divmod(time, 60)
   local seconds = a[2]
   local minutes = a[1]

   local b = divmod(minutes, 60)
   local hours = b[1]
   minutes = b[2]

   local c = divmod(hours, 24)
   local days = c[1]
   hours = c[2]

   local str = ""
   if days ~= 0 then str = str .. days .. "d " end
   if hours ~= 0 then str = str .. hours .. "h " end
   if minutes ~= 0 then str = str .. minutes .. "m " end
   str = str .. seconds .. "s"

   return str
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   player_list.players[name] = minetest.get_gametime()
end

local function on_leaveplayer(player)
   local name = player:get_player_name()

   player_list.players[name] = minetest.get_gametime()
end

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_leaveplayer(on_leaveplayer)

minetest.register_chatcommand(
   "plist",
   {
      params = "[all|recent]",
      description = "List current, recent, or all players since the last server restart",
      func = function(player_name, param)
		local time = minetest.get_gametime()

		local str = ""

		if param == "all" then
		   minetest.chat_send_player(player_name, "Players:")
		elseif param == "recent" then
		   str = str .. "Recent players: "
		else
		   str = str .. "Connected players: "
		end

		local player_count = 0
		for name, jointime in pairs(player_list.players) do
		   local plyr = minetest.get_player_by_name(name)

		   if param == "all" then
		      if plyr ~= nil then
			 player_count = player_count + 1
			 minetest.chat_send_player(player_name, "  " .. name .. ": connected for " .. prettytime(time - jointime))
		      else
			 minetest.chat_send_player(player_name, "  " .. name .. ": last seen " .. prettytime(time - jointime) .. " ago")
		      end
		   elseif param == "recent" then
                      if plyr == nil then -- Only show players that were connected but are currently disconnected
                         player_count = player_count + 1

                         if player_count == 1 then
                            str = str .. name
                         else
                            str = str .. ", " .. name
                         end
                      end
                   elseif plyr ~= nil then
                      player_count = player_count + 1

                      if player_count == 1 then
                         str = str .. name
                      else
                         str = str .. ", " .. name
                      end
                   end
                end

		minetest.chat_send_player(player_name, str)

		if param == "recent" then
		   minetest.chat_send_player(player_name, player_count .. " recent players")
		else
		   minetest.chat_send_player(player_name, player_count .. " connected players")
		end
	     end
   })

default.log("mod:player_list", "loaded")
