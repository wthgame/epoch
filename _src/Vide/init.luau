local Epoch = script:FindFirstAncestor("Epoch")

local Types = require(Epoch.Vide.Types)
local Vide = require(Epoch.Packages.Vide)
local changed = require(Epoch.Vide.Actions.changed)
local dissolve = require(Epoch.Vide.dissolve)

export type Source<T> = Vide.Source<T>
export type Context<T> = Vide.Context<T>
export type As<T> = Types.As<T>
export type Child = Types.Child

local extension = {
	actions = table.freeze {
		changed = changed,
	},
	dissolve = dissolve,
}

return table.freeze(setmetatable(extension, table.freeze { __index = Vide }))
