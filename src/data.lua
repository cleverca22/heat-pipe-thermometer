local thermometer = table.deepcopy(data.raw['constant-combinator']['constant-combinator'])

thermometer.name = "heat-pipe-thermometer"
thermometer.minable.result = "heat-pipe-thermometer"

local item = table.deepcopy(data.raw["item"]["constant-combinator"])
item.name = "heat-pipe-thermometer"
item.place_result = "heat-pipe-thermometer"

local recipe = table.deepcopy(data.raw["recipe"]["constant-combinator"])
recipe.name = "heat-pipe-thermometer"
recipe.enabled = true
recipe.ingredients = {
  {"constant-combinator",1},
  {"heat-pipe",1}
}
recipe.result = "heat-pipe-thermometer"

data:extend({thermometer,item,recipe})
