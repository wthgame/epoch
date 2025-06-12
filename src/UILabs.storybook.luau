-- Don't export a storybook if this is required inside a plugin. Otherwise,
-- when this plugin reloads, UI Labs crashes.

local UILabs = require("@pkgs/UILabs")
local plugin = require("@src/plugin")

return if plugin
	then nil
	else {
		name = "Epoch",
		storyRoots = {
			script.Parent,
		},
		groupRoots = true,
	} :: UILabs.Storybook
