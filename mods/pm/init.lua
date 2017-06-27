--
-- Private messages mod
-- By Kaadmy, for Pixture
--

local enable_saving = minetest.settings:get_bool("pm_enable_saving")
if enable_saving == nil then enable_saving = true end
if minetest.is_singleplayer() then
   enable_saving = false
end

local messages = {}

minetest.register_chatcommand(
   "pm",
   {
      params = "<player> <message>",
      description = "Send somebody a private message",
      privs = {shout=true},
      func = function(name, param)
         local sendto, message = param:match("^(%S+)%s(.+)$")

         if not sendto then return false, "Invalid usage, see /help pm." end

         if not minetest.get_player_by_name(sendto) then
            if enable_saving then
               if messages[sendto] == nil then messages[sendto] = {} end
               table.insert(messages[sendto], name .. ": " .. message)

               return false, "The player " .. sendto
                  .. " is not online, saving message instead."
            else
               return false, "The player " .. sendto
                  .. " is not online, and PM saving is disabled."
            end
         end

         minetest.log("action", "PM from " .. name .. " to " .. sendto
                         .. ": " .. message)
         minetest.chat_send_player(sendto, "PM from " .. name .. ": "
                                      .. message)
         return true, "PM sent."
      end
})

minetest.register_chatcommand(
   "pms",
   {
      description = "Show saved private messages",
      func = function(name, param)
         if not enable_saving then return false, "PM saving is disabled." end
         if messages[name] == nil then return false, "No saved PMs." end

         minetest.chat_send_player(name, "Saved PMs:")

         local str = ""
         local amt_pms = 0
         for _, msg in pairs(messages[name]) do
            amt_pms = amt_pms + 1
            str = str .. "  " .. msg .. "\n"
         end

         minetest.chat_send_player(name, str)

         messages[name] = nil

         return true, amt_pms .. " saved PMs"
      end
})

if enable_saving then
   minetest.register_on_joinplayer(
      function(player)
	 local name = player:get_player_name()

         if messages[name] ~= nil and #messages[name] >= 1 then
            minetest.chat_send_player(name, minetest.colorize("#0ff", "You have " .. #messages[name] .. " saved PMs. Type /pms to view."))
            return false
         else
            minetest.chat_send_player(name, minetest.colorize("#0ff", "You have no saved PMs. Send PMs with the /pm command."))
            return true
         end
   end)
end

default.log("mod:pm", "loaded")
