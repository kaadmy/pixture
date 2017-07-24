--
-- Vignette mod
-- By KaadmY, for Pixture
--

local vignette_definition = {
   hud_elem_type = "image",
   position = {x = 0.5, y = 0.5},
   scale = {x = -100, y = -100},
   alignment = 0,
   text = "vignette_vignette.png",
}

local function on_joinplayer(player)
   if not player:is_player() then
      return
   end

   player:hud_add(vignette_definition)
end

minetest.register_on_joinplayer(on_joinplayer)

default.log("mod:vignette", "loaded")
