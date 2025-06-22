local game_utils = require("@src/games/game_utils")

return game_utils.Game({
	id = "etoh",
	name = "Eternal Towers of Hell",
	logo = "",
	kits = {
		-- require("@self/v6.0"),
		require("@self/v5.5"),
	},
})
