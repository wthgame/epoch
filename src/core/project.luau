local Workspace = game:GetService("Workspace")

local TimeContextual = require("@src/utils/time_contextual")
local games = require("@src/games")
local vide = require("@src/vide")

export type Project = {
	kit: games.Kit,
	kit_instance: Instance,
}

local current_project: TimeContextual.TimeContextual<vide.As<Project?>> = TimeContextual({
	-- temporary
	kit = require("@src/games/etoh/v5.5"),
	kit_instance = Workspace,
} :: any)

return table.freeze({
	current_project = current_project,
})
