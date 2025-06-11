-- Don't export a storybook if this is required inside a plugin. Otherwise,
-- when this plugin reloads, Ui Labs crashes.

return not script:FindFirstAncestorWhichIsA("Plugin")
	and {
		name = "Epoch",
		storyRoots = {
			script.Parent,
		},
		groupRoots = true,
	}
