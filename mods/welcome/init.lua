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
   if not core.setting_getbool("welcome_enable") then
      core.chat_send_player(name, "Welcoming is disabled")
      return ""
   end

   local form = default.ui.get_page("core_notabs")

   local rules = ""

   for _, t in ipairs(welcome.rules) do
      if rules ~= "" then rules = rules .. "," end

      rules = rules .. core.formspec_escape(t)
   end

   form = form .. "textlist[0.25,0.75;7.75,6.75;rules;" .. rules .. "]"

   if not core.check_player_privs(name, {interact = true}) then
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
      core.show_formspec(name, "welcome:welcome", f)
   end
end

core.register_on_player_receive_fields(
   function(player, form_name, fields)
      local name = player:get_player_name()
      local privs = core.get_player_privs(name)

      if privs.interact or fields.rules then
	 return
      end

      if fields.accept_rules then
	 privs.interact = true
	 core.set_player_privs(name, privs)
	 core.chat_send_player(name, "You now have interact, follow the rules and have fun!")
      else
	 core.chat_send_player(name, "If you want to interact, please read and accept the rules. Type /welcome to show rules.")
      end
   end)

core.register_chatcommand(
   "welcome",
   {
      description = "Show rules",
      func = function(name, param)
		welcome.show_rules(name)
	     end
   })

core.register_on_joinplayer(
   function(player)
      local name = player:get_player_name()

      if not core.check_player_privs(name, {interact = true}) and core.setting_getbool("welcome_enable") then
	 welcome.show_rules(name)
      end
   end)

default.log("mod:welcome", "loaded")
