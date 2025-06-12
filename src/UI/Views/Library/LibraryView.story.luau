local LibraryView = require("./LibraryView")
local Theme = require("@ui/Theme")
local UILabs = require("@pkgs/UILabs")

return UILabs.CreateVideStory(
	{
		vide = require("@pkgs/Vide"),
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
