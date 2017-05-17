--
-- Armor mod
-- By Kaadmy, for Pixture
--

armor = {}

-- Wear is wear per HP of damage taken

armor.materials = {
   -- material      craftitem                     description     %
   {"wood",         "group:planks",               "Wooden",       10},
   {"steel",        "default:ingot_steel",        "Steel",        20},
   {"chainmail",    "armor:chainmail_sheet",      "Chainmail",    30},
   {"carbon_steel", "default:ingot_carbon_steel", "Carbon Steel", 40},
   {"bronze",       "default:ingot_bronze",       "Bronze",       60},
}

-- Usable slots

armor.slots = {"helmet", "chestplate", "boots"}

-- Timer

local timer_interval = 1
local timer = 10

-- Formspec

local form_armor = default.ui.get_page("default:2part")

form_armor = form_armor .. "list[current_player;main;0.25,4.75;8,4;]"
form_armor = form_armor .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_armor = form_armor .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)
form_armor = form_armor .. "listring[current_player;main]"

form_armor = form_armor .. "label[3.25,1;Helmet]"
form_armor = form_armor .. "label[3.25,2;Chestplate]"
form_armor = form_armor .. "label[3.25,3;Boots]"

form_armor = form_armor .. "list[current_player;armor;2.25,0.75;1,3;]"
form_armor = form_armor .. "listring[current_player;armor]"
form_armor = form_armor .. default.ui.get_itemslot_bg(2.25, 0.75, 1, 3)

default.ui.register_page("armor:armor", form_armor)

function armor.is_armor(itemname)
   local item = minetest.registered_items[itemname]

   if item ~= nil and item.groups ~= nil then
      if item.groups.is_armor then
	 return true
      end
   end
end

function armor.is_slot(itemname, slot)
   local match = string.find(itemname, "armor:" .. slot .. "_")
   local matchbool = false
   if match ~= nil and match >= 1 then
      matchbool = true
   end
   return matchbool
end

function armor.get_base_skin(player)
   if minetest.get_modpath("player_skins") ~= nil then
      return player_skins.get_skin(player:get_player_name())
   else
      return armor.player_skin
   end
end

function armor.get_texture(player, base)
   local inv = player:get_inventory()

   local image = base

   for slot_index, slot in ipairs(armor.slots) do
      local itemstack = inv:get_stack("armor", slot_index)
      local itemname = itemstack:get_name()

      if armor.is_armor(itemname) and armor.is_slot(itemname, slot) then
	 local item = minetest.registered_items[itemname]
	 local mat = armor.materials[item.groups.armor_material][1]

	 image = image .. "^armor_" .. slot .. "_" .. mat ..".png"
      end
   end

   --   print("[armor] Got armor texture: " .. image)

   return image
end

function armor.get_groups(player)
   local groups = {fleshy = 100}

   local match_mat = nil
   local match_amt = 0

   local inv = player:get_inventory()

   for slot_index, slot in ipairs(armor.slots) do
      local itemstack = inv:get_stack("armor", slot_index)
      local itemname = itemstack:get_name()

      if armor.is_armor(itemname) then
	 local item = minetest.registered_items[itemname]

	 for mat_index, _ in ipairs(armor.materials) do
	    local mat = armor.materials[mat_index][1]

	    if mat_index == item.groups.armor_material then
	       groups.fleshy = groups.fleshy - item.groups.armor
	       if match_mat == nil then
		  match_mat = mat
	       end

	       if mat == match_mat then
		  match_amt = match_amt + 1
	       end

	       break
	    end
	 end

      end
   end

   -- If full set of same armor material, then boost armor by 10%

   if match_amt == #armor.slots then
      groups.fleshy = groups.fleshy - 10
   end

   --   print("[armor] Armor groups: " .. dump(groups))

   return groups
end

function armor.init(player)
   local inv = player:get_inventory()

   if inv:get_size("armor") ~= 3 then
      inv:set_size("armor", 3)
   end
end

function armor.update(player)
   local groups = armor.get_groups(player)
   player:set_armor_groups({fleshy = groups.fleshy})

   local image = armor.get_texture(player, armor.get_base_skin(player))
   if image ~= default.player_get_textures(player)[1] then
      default.player_set_textures(player, {image})
   end
end

local function on_newplayer(player)
   armor.init(player)
end

local function on_joinplayer(player)
   armor.init(player)
end

local function on_globalstep(dtime)
   timer = timer + dtime

   if timer < timer_interval then
      return
   end

   timer = 0

   for _, player in pairs(minetest.get_connected_players()) do
      armor.update(player)
   end
end

if minetest.get_modpath("drop_items_on_die") ~= nil then
   drop_items_on_die.register_listname("armor")
end

minetest.register_on_newplayer(on_newplayer)
minetest.register_on_joinplayer(on_joinplayer)

minetest.register_globalstep(on_globalstep)

-- Chainmail

minetest.register_craftitem(
   "armor:chainmail_sheet",
   {
      description = "Chainmail Sheet",

      inventory_image = "armor_chainmail.png",
      wield_image = "armor_chainmail.png",

      stack_max = 20,
})

crafting.register_craft(
   {
      output = "armor:chainmail_sheet 3",
      items = {
         "default:ingot_steel 5",
      }
})

-- Armor pieces

for mat_index, matdef in ipairs(armor.materials) do
   local mat = matdef[1]

   local armor_def = math.floor(matdef[4] / #armor.slots)
   --   print("Material " .. mat .. ": " .. armor_def)

   for _, slot in ipairs(armor.slots) do
      local prettystring = slot:gsub(
         "(%a)([%w_']*)",
         function(first, rest)
            return first:upper()..rest:lower()
      end)


      minetest.register_craftitem(
	 "armor:" .. slot .. "_" .. mat,
	 {
	    description = matdef[3] .. " " .. prettystring,

	    inventory_image = "armor_" .. slot .. "_" .. mat .. "_inventory.png",
	    wield_image = "armor_" .. slot .. "_" .. mat .. "_inventory.png",

	    groups = {
	       is_armor = 1,
	       armor = armor_def,
	       armor_material = mat_index
	    },

	    stack_max = 1,
      })
   end

   crafting.register_craft(
      {
	 output = "armor:helmet_" .. mat,
	 items = {
            matdef[2] .. " 5",
	 }
   })

   crafting.register_craft(
      {
	 output = "armor:chestplate_" .. mat,
	 items = {
            matdef[2] .. " 8",
	 }
   })

   crafting.register_craft(
      {
	 output = "armor:boots_" .. mat,
	 items = {
            matdef[2] .. " 6",
	 }
   })
end

-- Achievements

achievements.register_achievement(
   "armored",
   {
      title = "Armored",
      description = "Craft a piece of armor",
      times = 1,
      craftitem = "group:is_armor",
})

achievements.register_achievement(
   "warrior",
   {
      title = "Warrior",
      description = "Craft 10 pieces of armor",
      times = 10,
      craftitem = "group:is_armor",
})

default.log("mod:armor", "loaded")
