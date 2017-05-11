--
-- Player skins mod
-- By Kaadmy, for Pixture
--

player_skins = {}

player_skins.skin_names = {"male", "female"}

if core.setting_get("player_skins_names") then
   player_skins.skin_names = util.split(core.setting_get("player_skins_names"), ",")
end

player_skins.old_skins = {}
player_skins.skins = {}

local update_time = 1
local timer = 10
local skins_file = core.get_worldpath() .. "/player_skins"

local function save_skins()
   local f = io.open(skins_file, "w")

   for name, tex in pairs(player_skins.skins) do
      f:write(name .. " " .. tex .. "\n")
   end

   io.close(f)
end

local function load_skins()
   local f = io.open(skins_file, "r")

   if f then
      repeat
	 local l = f:read("*l")
	 if l == nil then break end

	 for name, tex in string.gfind(l, "(.+) (.+)") do
	    player_skins.skins[name] = tex
	 end
      until f:read(0) == nil

      io.close(f)
   else
      save_skins()
   end
end

local function is_valid_skin(tex)
   for _, n in pairs(player_skins.skin_names) do
      if n == tex then
	 return true
      end
   end

   return false
end

function player_skins.get_skin(name)
   return "player_skins_" .. player_skins.skins[name] .. ".png"
end
 
function player_skins.set_skin(name, tex)
   if core.check_player_privs(name, {player_skin = true}) then
      if is_valid_skin(tex) then
	 player_skins.skins[name] = tex
	 save_skins()
      else
	 core.chat_send_player(name, "Invalid skin")
      end
   else
      core.chat_send_player(name, "You do not have the privilege to change your skin.")
   end
end

local function step(dtime)
   timer = timer + dtime
   if timer > update_time then
      for _, player in pairs(core.get_connected_players()) do
	 local name = player:get_player_name()

	 if player_skins.skins[name] ~= player_skins.old_skins[name] then
	    default.player_set_textures(player, {"player_skins_" .. player_skins.skins[name] .. ".png"})
	    player_skins.old_skins[name] = player_skins.skins[name]
	 end
      end
      timer = 0
   end
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   if player_skins.skins[name] == nil then
      player_skins.skins[name] = "male"
   end
end

core.register_globalstep(step)
core.register_on_joinplayer(on_joinplayer)

local function get_chatparams()
   local s = "["

   for _, n in pairs(player_skins.skin_names) do
      if s == "[" then
	 s = s .. n
      else
	 s = s .. "|" .. n
      end
   end

   return s .. "]"
end

function player_skins.get_formspec(playername)
   local form = default.ui.get_page("core")

   form = form .. "image[4,0;0.5,10.05;ui_vertical_divider.png]"

   for i, name in ipairs(player_skins.skin_names) do
      local x = 0.25
      local y = i - 0.5

      if i > 8 then
	 x = 4.5
	 y = y - 8
      end

      form = form .. default.ui.button(x, y, 2, 1, "skin_select_" .. name, player_skins.skin_names[i])
      form = form .. "image[" .. (x + 2.25) .. "," .. y.. ";1,1;player_skins_icon_" .. name .. ".png]"      
      if player_skins.skins[playername] == name then
	 form = form .. "image[" .. (x + 3.25) .. "," .. (y + 0.25).. ";0.5,0.5;ui_checkmark.png]"
      end
   end

   return form
end

core.register_on_player_receive_fields(
   function(player, form_name, fields)
      local name = player:get_player_name()

      for fieldname, val in pairs(fields) do
	 local skinname = string.match(fieldname, "skin_select_(.*)")

	 if skinname ~= nil then
	    player_skins.set_skin(name, skinname)

	    core.show_formspec(name, "core_player_skins", player_skins.get_formspec(name))
	 end
      end
   end)

core.register_privilege("player_skin", "Can change player skin")
core.register_chatcommand(
   "player_skin",
   {
      params = get_chatparams(),
      description = "Set your player skin",
      privs = {player_skin = true},
      func = function(name, param)
		if is_valid_skin(param) then
		   player_skins.set_skin(name, param)
		elseif param == "" then
		   core.chat_send_player(name, "Current player skin: " .. player_skins.skins[name])		   
		else
		   core.chat_send_player(name, "Bad param for /player_skin; type /help player_skin")
		end
	     end
   })

core.after(1.0, load_skins)

default.log("mod:player_skins", "loaded")