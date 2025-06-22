local game_utils = require("@src/games/game_utils")

return game_utils.Kit({
	version = vector.create(1, 0, 0),
	thumbnail = "",
	client_objects_config_behavior = "value_objects",
	client_objects = {},
})
