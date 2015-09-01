--
-- Sounds
--

function default.node_sound_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="", gain=1.0}
   table.dig = table.dig or
      {name="default_dig_hard", gain=0.3}
   table.dug = table.dug or
      {name="default_dug_node", gain=0.1}
   table.place = table.place or
      {name="default_place_node", gain=0.8}
   return table
end

function default.node_sound_stone_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_hard_footstep", gain=0.6}
   table.dig = table.dig or
      {name="default_dig_hard", gain=0.3}
   table.dug = table.dug or
      {name="default_hard_footstep", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_dirt_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_crunch_footstep", gain=1.0}
   table.dug = table.dug or
      {name="default_crunch_footstep", gain=1.0}
   table.dig = table.dig or
      {name="default_dig_soft", gain=0.3}
   table.place = table.place or
      {name="default_place_node", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_sand_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_soft_footstep", gain=0.2}
   table.dug = table.dug or
      {name="default_soft_footstep", gain=0.4}
   table.dig = table.dig or
      {name="default_dig_soft", gain=0.2}
   table.place = table.place or
      {name="default_place_node", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_wood_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_hard_footstep", gain=0.5}
   table.dig = table.dig or
      {name="default_dig_hard", gain=0.2}
   table.dug = table.dug or
      {name="default_hard_footstep", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_leaves_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_soft_footstep", gain=0.35}
   table.dug = table.dug or
      {name="default_soft_footstep", gain=0.7}
   table.dig = table.dig or
      {name="default_dig_soft", gain=0.3}
   table.place = table.place or
      {name="default_place_node", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_glass_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_hard_footstep", gain=0.5}
   table.dig = table.dig or
      {name="default_dig_hard", gain=0.5}
   table.dug = table.dug or
      {name="default_dug_node", gain=1.0}
   default.node_sound_defaults(table)
   return table
end

function default.node_sound_snow_defaults(table)
   table = table or {}
   table.footstep = table.footstep or
      {name="default_crunch_footstep", gain=0.3}
   table.dig = table.dig or
      {name="default_dig_soft", gain=0.2}
   table.dug = table.dug or
      {name="default_dig_soft", gain=0.8}
   default.node_sound_defaults(table)
   return table
end