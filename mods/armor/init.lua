--
-- Armor mod
-- By Kaadmy, for Pixture
--

armor = {}

armor.update_time = 1

armor.materials = {
--   material       craftitem                   %   description
   {"wood",        "group:planks",              15, "Wooden"},
   {"steel",       "default:ingot_steel",       30, "Steel"},
   {"chainmail",   "armor:chainmail_sheet",     45, "Chainmail"},
   {"carbonsteel", "default:ingot_carbonsteel", 60, "Carbonsteel"},
}

armor.slots = {"helmet", "chestplate", "boots"}

local form_armor = default.ui.get_page("core_2part")
default.ui.register_page("core_armor", form_armor)

local armor_timer = 10

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

function armor.get_texture(player, base)
   local inv = player:get_inventory()

   local image = base

   for _, slot in ipairs(armor.slots) do
      local itemstack = inv:get_stack("armor_"..slot, 1)
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

   for _, slot in ipairs(armor.slots) do
      local itemstack = inv:get_stack("armor_"..slot, 1)
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

   if match_amt == #armor.slots then -- if full set of same armor material, then boost armor by 10%
      groups.fleshy = groups.fleshy - 10
   end

   --   print("[armor] Armor groups: " .. dump(groups))

   return groups
end

function armor.init(player)
   local inv = player:get_inventory()

   for _, slot in ipairs(armor.slots) do
      if inv:get_size("armor_"..slot) ~= 1 then
	 inv:set_size("armor_"..slot, 1)
      end
   end
end

function armor.update(player)
   local groups = armor.get_groups(player)
   player:set_armor_groups({fleshy = groups.fleshy})

   local image = armor.get_texture(player, "character.png")
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

local function on_die(player)
   local pos = player:getpos()

   local inv = player:get_inventory()

   for _, slot in ipairs(armor.slots) do
      local item = inv:get_stack("armor_"..slot, 1)

      local rpos = {
	 x = pos.x + math.random(-0.2, 0.2),
	 y = pos.y,
	 z = pos.z + math.random(-0.2, 0.2)
      }

      drop = minetest.add_item(rpos, item)
      
      if drop then
	 drop:setvelocity(
	    {
	       x = math.random(-0.3, 0.3),
	       y = 3,
	       z = math.random(-0.3, 0.3),
	    })
      end
   end
end

local function step(dtime)
   armor_timer = armor_timer + dtime

   if armor_timer > armor.update_time then
      for _, player in pairs(minetest.get_connected_players()) do
	 armor.update(player)
      end
      armor_timer = 0
   end
end

minetest.register_craftitem(
   "armor:chainmail_sheet",
   {
      description = "Chainmail sheet",

      inventory_image = "armor_chainmail.png",
      wield_image = "armor_chainmail.png",      

      stack_max = 20,
   })

minetest.register_craft(
   {
      output = "armor:chainmail_sheet 3",
      recipe = {
	 {"default:ingot_steel", "", "default:ingot_steel"},
	 {"", "default:ingot_steel", ""},
	 {"default:ingot_steel", "", "default:ingot_steel"},
      }
   })

for mat_index, _ in ipairs(armor.materials) do
   local def = armor.materials[mat_index]
   local mat = def[1]

   local armor_def = math.floor(def[3] / #armor.slots)
--   print("Material " .. mat .. ": " .. armor_def)

   for _, slot in ipairs(armor.slots) do
      minetest.register_craftitem(
	 "armor:"..slot.."_"..mat,
	 {
	    description = def[4].." "..slot,

	    inventory_image = "armor_"..slot.."_"..mat.."_inventory.png",
	    wield_image = "armor_"..slot.."_"..mat.."_inventory.png",

	    groups = {
	       is_armor = 1,
	       armor = armor_def,
	       armor_material = mat_index
	    },

	    stack_max = 1,
	 })
   end

   local n = def[2]

   minetest.register_craft(
      {
	 output = "armor:helmet_"..mat,
	 recipe = {
	    {n,  n,  n},
	    {n,  "", n},
	    {"", "", ""},
	 }
      })
   minetest.register_craft(
      {
	 output = "armor:chestplate_"..mat,
	 recipe = {
	    {n,  "", n},
	    {n,  n,  n},
	    {n,  n,  n},
	 }
      })
   minetest.register_craft(
      {
	 output = "armor:boots_"..mat,
	 recipe = {
	    {"", "", ""},
	    {n,  "", n},
	    {n,  "", n},
	 }
      })
end

minetest.register_on_newplayer(on_newplayer)
minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_dieplayer(on_die)
minetest.register_globalstep(step)

local form_armor = default.ui.get_page("core_2part")
form_armor = form_armor .. "list[current_player;main;0.25,4.75;8,4;]"
form_armor = form_armor .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_armor = form_armor .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)
form_armor = form_armor .. "listring[current_player;main]"

form_armor = form_armor .. "label[3.25,3;Boots]"
form_armor = form_armor .. "list[current_player;armor_boots;2.25,2.75;1,1;]"
form_armor = form_armor .. "listring[current_player;armor_boots]"
form_armor = form_armor .. default.ui.get_itemslot_bg(2.25, 2.75, 1, 1)

form_armor = form_armor .. "label[3.25,2;Chestplate]"
form_armor = form_armor .. "list[current_player;armor_chestplate;2.25,1.75;1,1;]"
form_armor = form_armor .. "listring[current_player;armor_chestplate]"
form_armor = form_armor .. default.ui.get_itemslot_bg(2.25, 1.75, 1, 1)

form_armor = form_armor .. "label[3.25,1;Helmet]"
form_armor = form_armor .. "list[current_player;armor_helmet;2.25,0.75;1,1;]"
form_armor = form_armor .. "listring[current_player;armor_helmet]"
form_armor = form_armor .. default.ui.get_itemslot_bg(2.25, 0.75, 1, 1)

default.ui.register_page("core_armor", form_armor)