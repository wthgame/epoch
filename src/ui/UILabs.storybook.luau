local Epoch = script:FindFirstAncestor("Epoch")

local UILabs = require(Epoch.Packages.UILabs)
local plugin = require(Epoch.plugin)

-- Don't export a storybook if this is required inside a plugin. Otherwise,
-- when this plugin reloads, UI Labs crashes.
return if plugin
	then nil
	else {
		name = "Epoch",
		storyRoots = {
			script.Parent,
		},
	} :: UILabs.Storybook
