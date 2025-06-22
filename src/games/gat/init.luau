local game_utils = require("./game_utils")

return game_utils.Game({
	id = "gt",
	name = "Gawd's Awful Towers",
	logo = "",
	kits = {
		require("@self/v1.0"),
	},
})
