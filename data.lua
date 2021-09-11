data:extend({
  {
    type = "tool",
    name = "coin-for-science",
    localised_name = {"item-name.coin"},
    localised_description = {"item-description.coin"},
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
    ingredients = {{"coin", 100}},
    result_count = 100,
    result = "coin-for-science"
  }, {
    type = "recipe",
    name = "science-for-coin",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{"coin-for-science", 100}},
    result_count = 100,
    result = "coin"
  }
})

local price_list = {
	["automation-science-pack"] = 6,
	["logistic-science-pack"] = 12,
	["military-science-pack"] = 40,
	["chemical-science-pack"] = 95,
	["production-science-pack"] = 220,
	["utility-science-pack"] = 440
}

for _, _data in pairs(data.raw.technology) do
	local coins = 0
	local ingredients = _data.unit.ingredients
	for i=#ingredients, 1, -1 do
		local ingredient = ingredients[i]
		local cost = price_list[ingredient[1]]
		if cost then
			coins = coins + cost * ingredient[2]
			ingredients[i] = nil
		end
	end

	if coins > 0 then
		table.insert(ingredients, {"coin-for-science", coins})
	end
end
