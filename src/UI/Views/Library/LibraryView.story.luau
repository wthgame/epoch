local Epoch = script:FindFirstAncestor("Epoch")
local LibraryView = require("./LibraryView")
local UILabs = require(Epoch.Packages.UILabs)

return UILabs.CreateVideStory(
	{
		vide = require(Epoch.Packages.Vide),
	},
	function(props: UILabs.VideProps)
		return LibraryView {}
	end :: any
)
