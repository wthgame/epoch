local changed = require("@self/actions/changed")
local dissolve = require("@self/dissolve")
local types = require("@self/types")
local vide = require("@pkgs/vide")

export type Source<T> = vide.Source<T>
export type As<T> = types.As<T>
export type Child = types.Child

local vide_extended = {
	actions = table.freeze {
		changed = changed,
	},
	dissolve = dissolve,
}

return table.freeze(setmetatable(vide_extended, table.freeze { __index = vide }))
