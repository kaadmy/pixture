--
-- Achivements mod
-- By Kaadmy, for Pixture
--

achievements = {}

achievements.achievements = {}
achievements.registered_achievements = {}
achievements.registered_achievements_list = {}

local achievements_file = minetest.get_worldpath() .. "/achievements.dat"
local saving = false

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

   saving = false
end

local function delayed_save()
   if not saving then
      saving = true

      minetest.after(40, save_achievements)
   end
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
                           minetest.colorize("#0f0", "*** " .. name .." has earned the achievement [" ..
                                                achievements.registered_achievements[aname].title .. "]"))
      end)
   end

   delayed_save()
end

-- Load achievements table

local function on_load()
   load_achievements()
end

-- Save achievements table

local function on_shutdown()
   save_achievements()
end

-- New player

local function on_newplayer(player)
   achievements.achievements[player:get_player_name()] = {}
end

-- Interaction callbacks

local function on_craft(itemstack, player, craftgrid, craftinv)
   for aname, def in pairs(achievements.registered_achievements) do
      if def.craftitem ~= nil then
	 if def.craftitem == itemstack:get_name() then
	    achievements.trigger_achievement(player, aname)
	 else
	    local group = string.match(def.craftitem, "group:(.*)")

	    if group and minetest.get_item_group(itemstack:get_name(), group) ~= 0 then
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

	    if group and minetest.get_item_group(oldnode.name, group) ~= 0 then
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

	    if group and minetest.get_item_group(newnode.name, group) ~= 0 then
	       achievements.trigger_achievement(player, aname)
	    end
	 end
      end
   end
end

-- Add callback functions

minetest.after(0, on_load)

minetest.register_on_shutdown(on_shutdown)

minetest.register_on_newplayer(on_newplayer)

minetest.register_on_craft(on_craft)
minetest.register_on_dignode(on_dig)
minetest.register_on_placenode(on_place)

-- Formspecs

local form = default.ui.get_page("core")
form = form .. "tableoptions[background=#DDDDDD30]"
form = form .. "tablecolumns[text,align=left,width=11;text,align=left,width=28;text,align=left,width=5]"
default.ui.register_page("core_achievements", form)

function achievements.get_formspec(name, row)
   if not row then row = 1 end

   local achievement_list = ""

   local amt_gotten = 0
   local amt_progress = 0

   for _, aname in ipairs(achievements.registered_achievements_list) do
      local def = achievements.registered_achievements[aname]

      local progress = ""
      if achievements.achievements[name][aname] then
	 if achievements.achievements[name][aname] == -1 then
	    progress = "Gotten"
	    amt_gotten = amt_gotten + 1
	 else
	    progress = achievements.achievements[name][aname] .. "/" .. def.times
	    amt_progress = amt_progress + 1
	 end
      else
	 progress = "Missing"
      end

      if achievement_list ~= "" then
	 achievement_list = achievement_list .. ","
      end

      achievement_list = achievement_list .. minetest.formspec_escape(def.title) .. ","
      achievement_list = achievement_list .. minetest.formspec_escape(def.description) .. ","
      achievement_list = achievement_list .. progress
   end

   local form = default.ui.get_page("core_achievements")

   form = form .. "table[0.25,2.5;7.75,5.5;achievement_list;" .. achievement_list .. ";" .. row .. "]"

   local aname = achievements.registered_achievements_list[row]
   local def = achievements.registered_achievements[aname]

   local progress = ""
   if achievements.achievements[name][aname] then
      if achievements.achievements[name][aname] == -1 then
	 progress = "Gotten"
      else
	 progress = achievements.achievements[name][aname] .. "/" .. def.times
      end
   else
      progress = "Missing"
   end

   form = form .. "label[0.25,8.15;" .. minetest.formspec_escape(amt_gotten .. " of " .. #achievements.registered_achievements_list .. " achievements gotten, " .. amt_progress .. " in progress") .. "]"

   form = form .. "label[0.25,0.25;" .. minetest.formspec_escape(def.title) .. "]"
   form = form .. "label[7.25,0.25;" .. minetest.formspec_escape(progress) .. "]"

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

--
-- Below are the default achievements
--

-- Tools

achievements.register_achievement(
   "off_to_battle",
   {
      title = "Off to Battle",
      description = "Craft a Broadsword",
      times = 1,
      craftitem = "default:broadsword",
})

achievements.register_achievement(
   "hardened_miner",
   {
      title = "Hardened Miner",
      description = "Craft 3 carbon steel pickaxes.",
      times = 3,
      craftitem = "default:pick_carbonsteel",
})

-- Dirt/soil

achievements.register_achievement(
   "drain_the_swamp",
   {
      title = "Drain the Swamp",
      description = "Dig 30 swamp dirt.",
      times = 30,
      dignode = "default:swamp_dirt",
})

-- Placing planks

achievements.register_achievement(
   "plunks",
   {
      title = "Plunks",
      description = "Place 10 planks",
      times = 10,
      placenode = "group:planks",
})

achievements.register_achievement(
   "carpenter",
   {
      title = "Carpenter",
      description = "Place 100 planks",
      times = 100,
      placenode = "group:planks",
})

achievements.register_achievement(
   "master_carpenter",
   {
      title = "Master Carpenter",
      description = "Place 500 planks",
      times = 500,
      placenode = "group:planks",
})

-- Stone

achievements.register_achievement(
   "mineority",
   {
      title = "Mineority",
      description = "Mine 20 stone",
      times = 20,
      dignode = "group:stone",
})

achievements.register_achievement(
   "rockin'",
   {
      title = "Rockin'",
      description = "Mine 200 stone",
      times = 200,
      dignode = "group:stone",
})

achievements.register_achievement(
   "rocksolid",
   {
      title = "Rock Solid",
      description = "Mine 1000 stone",
      times = 1000,
      dignode = "group:stone",
})

achievements.register_achievement(
   "cave_builder",
   {
      title = "Cave Builder",
      description = "Place 60 stone.",
      times = 60,
      placenode = "default:stone",
})

-- Digging wood

achievements.register_achievement(
   "timber",
   {
      title = "Timber",
      description = "Dig 10 tree trunks.",
      times = 10,
      dignode = "group:tree",
})

achievements.register_achievement(
   "timberer",
   {
      title = "Timberer",
      description = "Dig 100 tree trunks.",
      times = 100,
      dignode = "group:tree",
})

achievements.register_achievement(
   "timbererest",
   {
      title = "Timbererest",
      description = "Dig 500 tree trunks.",
      times = 500,
      dignode = "group:tree",
})

-- Crafting bricks

achievements.register_achievement(
   "builder",
   {
      title = "Builder",
      description = "Craft 180 bricks.",
      times = 180,
      craftitem = "default:brick",
})


-- Plants/farming

achievements.register_achievement(
   "gardener",
   {
      title = "Gardener",
      description = "Plant 10 flowers.",
      times = 10,
      placenode = "default:flower",
})

achievements.register_achievement(
   "master_gardener",
   {
      title = "Master Gardener",
      description = "Plant 100 flowers.",
      times = 100,
      placenode = "default:flower",
})

achievements.register_achievement(
   "welcome_to_the_mountains",
   {
      title = "Welcome to the Mountains",
      description = "Collect dry grass.",
      times = 1,
      dignode = "default:dry_grass",
})

achievements.register_achievement(
   "fertile",
   {
      title = "Fertile",
      description = "Craft 100 bags of fertilizer.",
      times = 100,
      craftitem = "default:fertilizer",
})

-- Crafting reinforced blocks

achievements.register_achievement(
   "master_carpenter",
   {
      title = "Master Carpenter",
      description = "Craft 200 reinforced frames.",
      times = 200,
      craftitem = "default:reinforced_frame",
})

achievements.register_achievement(
   "master_stonemason",
   {
      title = "Master Stonemason",
      description = "Craft 200 reinforced cobble.",
      times = 200,
      craftitem = "default:reinforced_cobble",
})

-- Crafting sand-related materials

achievements.register_achievement(
   "sandman",
   {
      title = "Sandman",
      description = "Craft 60 compressed sandstone.",
      times = 60,
      craftitem = "default:compressed_sandstone",
})

-- Literature

achievements.register_achievement(
   "librarian",
   {
      title = "Librarian",
      description = "Craft 10 bookshelves.",
      times = 10,
      craftitem = "default:bookshelf",
})

-- Misc.

achievements.register_achievement(
   "smelting_room",
   {
      title = "Smelting Room",
      description = "Craft 20 furnaces.",
      times = 200,
      craftitem = "default:furnace",
})

default.log("mod:achievements", "loaded")
