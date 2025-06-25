local Epoch = script:FindFirstAncestor("Epoch")

local Types = require(Epoch.Core.Games.Types)

return Types.Game({
	id = "etoh",
	name = "Eternal Towers of Hell",
	logo = "",
	kits = {
		require(script:WaitForChild("v5.5")),
	},
})
