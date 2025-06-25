local Epoch = script:FindFirstAncestor("Epoch")

local LibraryView = require(script.Parent.LibraryView)
local Theme = require(Epoch.UI.Theme)
local UILabs = require(Epoch.Packages.UILabs)
local Vide = require(Epoch.Vide)

return UILabs.CreateVideStory({
	vide = Vide,
}, function(props: UILabs.VideProps)
	return Theme.ThemePreview {
		fillDirection = "horizontal",
		render = function()
			return LibraryView {}
		end,
	}
end)
