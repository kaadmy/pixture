--
-- Achivements mod
-- By Kaadmy, for Pixture
--

achievements = {}

achievements.achievements = {}
achievements.registered_achievements = {}
achievements.registered_achievements_list = {}

local achievements_file = minetest.get_worldpath() .. "/achievements"

function achievements.register_achievement(name, def)
   local rd = {
      title = def.title or name, -- good-looking name of the achievement
      description = def.description or "The " .. name .. " achievement", -- description of what the achievement is, and how to get it
      times = def.times or 1, -- how many times to trigger before getting the achievement
      dignode = def.dignode or nil, -- digging this node also triggers the achievement
      placenode = def.placenode or nil, -- placing this node also triggers the achievement
      craftitem = def.craftitem or nil, -- crafting this item also triggers the achievement
   }

   achievements.registered_achievements[name] = def
   table.insert(achievements.registered_achievements_list, name)
end

local function save_achievements()
   local f = io.open(achievements_file, "w")

   f:write(minetest.serialize(achievements.achievements))

   io.close(f)
end

local function load_achievements()
   local f = io.open(achievements_file, "r")

   if f then
      achievements.achievements = minetest.deserialize(f:read("*all"))

      io.close(f)
   else
      save_achievements()
   end
end

function achievements.trigger_achievement(player, aname, times)
   local name = player:get_player_name()

   if achievements.achievements[name] == nil then
      achievements.achievements[name] = {}
   end

   if achievements.achievements[name][aname] == nil then
      achievements.achievements[name][aname] = 0
   end

   if achievements.achievements[name][aname] == -1 then
      return
   end

   achievements.achievements[name][aname] = achievements.achievements[name][aname] + (times or 1)

   if not achievements.registered_achievements[aname] then
      default.log("[mod:achievements] Cannot find registered achievement " .. aname, "error")
      return
   end

   if achievements.achievements[name][aname] >= achievements.registered_achievements[aname].times then
      achievements.achievements[name][aname] = -1
      minetest.after(2.0, function()
			     minetest.chat_send_all(
				"*** " .. name .." has earned the achievement [" ..
				   achievements.registered_achievements[aname].title .. "]")
			  end)
   end

   save_achievements()
end

local function on_joinplayer(player)
   load_achievements()
   achievements.trigger_achievement(player, "like_clockwork")
end

local function on_craft(itemstack, player, craftgrid, craftinv)
   for aname, def in pairs(achievements.registered_achievements) do
      if def.craftitem ~= nil then
	 if def.craftitem == itemstack:get_name() then
	    achievements.trigger_achievement(player, aname)
	 else
	    local group = string.match(def.placenode, "group:(.*)")

	    if group and minetest.get_item_group(itemstack:get_name(), group) then
	       achievements.trigger_achievement(player, aname)
	    end
	 end
      end
   end
end

local function on_dig(pos, oldnode, player)
   for aname, def in pairs(achievements.registered_achievements) do
      if def.dignode ~= nil then
	 if def.dignode == oldnode.name then
	    achievements.trigger_achievement(player, aname)
	 else
	    local group = string.match(def.dignode, "group:(.*)")

	    if group and minetest.get_item_group(def.dignode, group) then
	       achievements.trigger_achievement(player, aname)
	    end
	 end
      end
   end
end

local function on_place(pos, newnode, player, oldnode, itemstack, pointed_thing)
   for aname, def in pairs(achievements.registered_achievements) do
      if def.placenode ~= nil then
	 if def.placenode == newnode.name then
	    achievements.trigger_achievement(player, aname)
	 else
	    local group = string.match(def.placenode, "group:(.*)")

	    if group and minetest.get_item_group(newnode.name, group) then
	       achievements.trigger_achievement(player, aname)
	    end
	 end
      end
   end
end

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_craft(on_craft)
minetest.register_on_dignode(on_dig)
minetest.register_on_placenode(on_place)

local form = default.ui.get_page("core")
form = form .. "tableoptions[background=#88888840]"
form = form .. "tablecolumns[text,align=left;text,align=left]"
default.ui.register_page("core_achievements", form)

function achievements.get_formspec(name, row)
   if not row then row = 1 end

   local achievement_list = ""

   for _, aname in ipairs(achievements.registered_achievements_list) do
      local def = achievements.registered_achievements[aname]

      local amt = ""
      if achievements.achievements[name][aname] then
	 if achievements.achievements[name][aname] == -1 then
	    amt = " (Gotten)"
	 else
	    amt = " (" .. achievements.achievements[name][aname] .. "/" .. def.times .. ")"
	 end
      end

      if achievement_list == "" then
	 achievement_list = achievement_list .. minetest.formspec_escape(def.title .. amt) .. "," .. minetest.formspec_escape(def.description)
      else
	 achievement_list = achievement_list .. "," .. minetest.formspec_escape(def.title .. amt) .. "," .. minetest.formspec_escape(def.description)
      end
   end

   local form = default.ui.get_page("core_achievements")

   form = form .. "table[0.25,3;7.75,5.5;achievement_list;" .. achievement_list .. ";" .. row .. "]"

   local aname = achievements.registered_achievements_list[row]
   local def = achievements.registered_achievements[aname]
   
   local amt = ""
   if achievements.achievements[name][aname] then
      if achievements.achievements[name][aname] == -1 then
	 amt = "Gotten"
      else
	 amt = achievements.achievements[name][aname] .. "/" .. def.times
      end
   else
      amt = "Missing"
   end

   form = form .. "label[0.25,0.25;" .. minetest.formspec_escape(def.title) .. "]"
   form = form .. "label[7.25,0.25;" .. minetest.formspec_escape(amt) .. "]"

   form = form .. "label[0.5,0.75;" .. minetest.formspec_escape(def.description) .. "]"

   return form
end

local function receive_fields(player, form_name, fields)
   local name = player:get_player_name()

   if form_name ~= "core_achievements" then return end

   if fields.quit then return end

   local selected = 1

   if fields.achievement_list then
      local selection = minetest.explode_table_event(fields.achievement_list)

      if selection.type == "CHG" or selection.type == "DCL" then
	 selected = selection.row
      end
   end

   minetest.show_formspec(name, "core_achievements", achievements.get_formspec(name, selected))
end

minetest.register_on_player_receive_fields(receive_fields)


-- below is the default achievements
achievements.register_achievement(
   "firstjoin",
   {
      title = "First join",
      description = "Join a game for the first time.",
      times = 1,
   })

achievements.register_achievement(
   "like_clockwork",
   {
      title = "Like clockwork",
      description = "Join the same game 100 times.",
      times = 100,
   })

achievements.register_achievement(
   "killathon",
   {
      title = "Killathon",
      description = "Die 10 times.",
      times = 10,
   })

achievements.register_achievement(
   "timber",
   {
      title = "Timber!",
      description = "Dig 10 tree trunks.",
      times = 10,
      dignode = "group:tree",
   })

achievements.register_achievement(
   "gardener",
   {
      title = "Gardener",
      description = "Place 10 flowers.",
      times = 10,
      placenode = "default:flower",
   })

achievements.register_achievement(
   "your_pick",
   {
      title = "Your pick",
      description = "Craft yourself a new wooden pickaxe.",
      times = 1,
      craftitem = "default:pick_wood",
   })

local function on_dieplayer(player)
   achievements.trigger_achievement(player, "killathon")
end

minetest.register_on_dieplayer(on_dieplayer)

minetest.register_on_newplayer(function(player) achievements.trigger_achievement(player, "firstjoin") end)

default.log("mod:achievements", "loaded")