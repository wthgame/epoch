local Workspace = game:GetService("Workspace")
local Epoch = script:FindFirstAncestor("Epoch")

local Games = require(Epoch.Core.Games)
local TimeContextual = require(Epoch.Utils.TimeContextual)
local Vide = require(Epoch.Vide)

export type Project = {
	kit: Games.Kit,
	kitInstance: Instance,
}

local ProjectManager = {}
ProjectManager.currentProject = TimeContextual({
	-- temporary
	kit = Games.nameToGame()["etoh"],
	kitInstance = Workspace,
} :: any) :: TimeContextual.TimeContextual<Vide.As<Project?>>

function ProjectManager.discoverProjects(_parent: Instance)
	error("not yet implemented")
end

return ProjectManager
