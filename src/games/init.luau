local game_utils = require("@self/game_utils")

export type Game = game_utils.Game
export type Kit = game_utils.Kit
export type KitClientObject = game_utils.KitClientObject

return table.freeze {
	games = table.freeze {
		require("@self/etoh"),
		-- require("@self/otoh"),
		-- require("@self/tct"),
		-- require("@self/wth"),
		-- require("@self/gat"),
	},
}
