local Workspace = game:GetService("Workspace")
local Epoch = script:FindFirstAncestor("Epoch")

local Games = require(Epoch.Core.Games)
local Vide = require(Epoch.Vide)

local context = Vide.context

export type Project = {
	kit: Games.Kit,
	kitInstance: Instance,
}

local ProjectManager = {}
ProjectManager.currentProject = context({
	-- temporary
	kit = Games.nameToGame()["etoh"].kits[1],
	kitInstance = Workspace,
} :: Vide.As<Project>?)

function ProjectManager.discoverProjects(_parent: Instance)
	error("not yet implemented")
end

return ProjectManager
