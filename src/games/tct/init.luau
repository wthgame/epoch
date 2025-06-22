local game_utils = require("@src/games/game_utils")

return game_utils.Game({
	id = "tct",
	name = "Thai's Crazy Towers",
	logo = "",
	kits = {
		require("@self/v1.12"),
	},
})
