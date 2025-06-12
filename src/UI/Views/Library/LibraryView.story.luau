local Epoch = script:FindFirstAncestor("Epoch")
local LibraryView = require("./LibraryView")
local Theme = require(Epoch.UI.Theme)
local UILabs = require(Epoch.Packages.UILabs)

return UILabs.CreateVideStory(
	{
		vide = require(Epoch.Packages.Vide),
	},
	function(props: UILabs.VideProps)
		return Theme.ThemePreview {
			fillDirection = "horizontal",
			render = function()
				return LibraryView {}
			end,
		}
	end :: any
)
