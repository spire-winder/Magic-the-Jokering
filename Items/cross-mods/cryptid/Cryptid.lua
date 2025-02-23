-- cryptid cross mod utility functions


function cat_lvl(lvl, tag)
    return {tag.ability.level}
end

--[[
local tag
for i = 1, #G.GAME.tags do
  if G.GAME.tags[i].key == 'tag_cry_cat' then
    tag = G.GAME.tags[i]
  end
end



if tag then
  tag.ability.level = cat_lvl
end
cat_lvl = G.cat_level
--]]