local game_utils = require("@src/games/game_utils")

return game_utils.Game({
	id = "wth",
	name = "Welcome To Hell",
	logo = "",
	kits = {
		require("@self/v1.0"),
	},
})
