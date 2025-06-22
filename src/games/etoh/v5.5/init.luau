local game_utils = require("../game_utils")

return game_utils.Kit({
	version = vector.create(5, 5, 0),
	thumbnail = "",
	client_objects_config_behavior = "value_objects",
	client_objects = {
		game_utils.KitClientObject({
			name = "Speed Booster",
			model = script:WaitForChild("SpeedBooster"),
		}),
	},
})
