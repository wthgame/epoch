local game_utils = require("./game_utils")

return game_utils.Game({
	id = "otoh",
	name = "Obren's Towers of Hell",
	logo = "",
	kits = {
		require("@self/v0.3.1"),
	},
})
