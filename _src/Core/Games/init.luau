local Epoch = script:FindFirstAncestor("Epoch")

local TimeContextual = require(Epoch.Utils.TimeContextual)
local Types = require(Epoch.Core.Games.Types)
local Vide = require(Epoch.Vide)

export type Game = Types.Game
export type Kit = Types.Kit
export type KitClientObject = Types.KitClientObject
export type KitClientObjectProperty = Types.KitClientObjectProperty

local source = Vide.source

local Games = {}
Games.defaultGames = TimeContextual({
	require(script.EToH),
} :: { Types.Game })

Games.knownGames = source(Games.defaultGames:now())

function Games.nameToGame()
	local result = {}
	for _, game in Games.knownGames() do
		if result[game.id] then
			error(`Conflicting game id: {game.id}`)
		else
			result[game.id] = game
		end
	end
	return result
end

return Games
