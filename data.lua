data:extend({
  {
    type = "tool",
    name = "coin-for-science",
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "science-pack",
    order = "a",
    stack_size = 500,
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value"
  }, {
    type = "recipe",
    name = "coin-for-science",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{type = "item", name = "coin", amount = 100}},
    results = {{type = "item", name = "coin-for-science", amount = 100}}
  }, {
    type = "recipe",
    name = "science-for-coin",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{type = "item", name = "coin-for-science", amount = 100}},
    results = {{type = "item", name = "coin", amount = 100}}
  }
})

local price_list = {
	["automation-science-pack"] = 6,
	["logistic-science-pack"]   = 12,
	["military-science-pack"]   = 40,
	["chemical-science-pack"]   = 95,
	["production-science-pack"] = 220,
	["utility-science-pack"]    = 440
}

for _, prototype in pairs(data.raw.technology) do
	if prototype.unit and prototype.unit.ingredients then
    local coins = 0
    local ingredients = prototype.unit.ingredients
    for i, ingredient in ipairs(ingredients) do
      local cost = price_list[ingredient[1]]
      -- TODO: improve
      if cost then
        coins = coins + cost * ingredient[2]
        table.remove(ingredients, i)
      end
    end

    if coins > 0 then
      table.insert(ingredients, {"coin-for-science", coins})
    end
  end
end


for _, prototype in pairs(data.raw.lab) do
  if prototype.inputs then
    table.insert(prototype.inputs, "coin-for-science")
  else
    prototype.inputs = {"coin-for-science"}
  end
end
