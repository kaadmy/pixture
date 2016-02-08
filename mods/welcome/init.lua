--
-- Welcome mod
-- By Kaadmy, for Pixture
--

welcome = {}

welcome.rules = {
   "Welcome!",
   "",
   "Rules:",
   "1. No swearing.",
   "2. No griefing.",
   "3. No spamming."
}

function welcome.get_formspec(name)
   if not minetest.setting_getbool("welcome_enable") then
      minetest.chat_send_player(name, "Welcoming is disabled")
      return ""
   end

   local form = default.ui.get_page("core_notabs")

   local rules = ""

   for _, t in ipairs(welcome.rules) do
      if rules ~= "" then rules = rules .. "," end

      rules = rules .. minetest.formspec_escape(t)
   end

   form = form .. "textlist[0.25,0.75;7.75,6.75;rules;" .. rules .. "]"

   if not minetest.check_player_privs(name, {interact = true}) then
      form = form .. default.ui.button_exit(1.25, 7.75, 3, 1, "decline_rules", "Nope")
      form = form .. default.ui.button_exit(4.25, 7.75, 3, 1, "accept_rules", "Okay")
   else
      form = form .. default.ui.button_exit(2.9, 7.75, 3, 1, "", "Okay")
   end

   return form
end

function welcome.show_rules(name)
   local f = welcome.get_formspec(name)

   if f ~= "" then
      minetest.show_formspec(name, "welcome:welcome", f)
   end
end

minetest.register_on_player_receive_fields(
   function(player, form_name, fields)
      local name = player:get_player_name()

      if minetest.check_player_privs(name, {interact = true}) or fields.rules then
	 return true
      end

      if fields.accept_rules then
	 minetest.set_player_privs(name, {interact = true})
	 minetest.chat_send_player(name, "You now have interact, follow the rules and have fun!")
      else
	 minetest.chat_send_player(name, "If you want to interact, please read and accept the rules. Type /welcome to show rules.")
      end
   end)

minetest.register_chatcommand(
   "welcome",
   {
      description = "Show rules",
      func = function(name, param)
		welcome.show_rules(name)
	     end
   })

minetest.register_on_joinplayer(
   function(player)
      local name = player:get_player_name()

      if not minetest.check_player_privs(name, {interact = true}) and minetest.setting_getbool("welcome_enable") then
	 welcome.show_rules(name)
      end
   end)

default.log("mod:welcome", "loaded")