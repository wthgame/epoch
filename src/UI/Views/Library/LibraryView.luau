local Epoch = script:FindFirstAncestor("Epoch")
local Assets = require(Epoch.Assets)
local NavTypes = require(Epoch.UI.Components.Nav.NavTypes)
local Theme = require(Epoch.UI.Theme)
local TopNav = require(Epoch.UI.Components.Nav.TopNav)
local Vide = require(Epoch.Packages.Vide)

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	local currentPage = Vide.source("COs")

	return Vide.create "Frame" {
		Name = "LibraryView",
		BackgroundColor3 = Theme.background,
		Size = UDim2.fromScale(1, 1),

		TopNav {
			colors = {
				background = Theme.library.navBackground,
				hoverBackground = Theme.library.navHoverBackground,
				activeBackground = Theme.library.navActiveBackground,
				text = Theme.library.navText,
				activeText = Theme.library.navActiveText,
			},

			NavTypes.NavOption {
				label = "COs",
				icon = Assets.material.settings,
				active = function()
					return currentPage() == "COs"
				end,
				onActivated = function()
					currentPage("COs")
				end,
			},

			NavTypes.NavOption {
				label = "Images",
				icon = Assets.material.image,
				active = function()
					return currentPage() == "Images"
				end,
				onActivated = function()
					currentPage("Images")
				end,
			},

			NavTypes.NavOption {
				label = "Sounds",
				icon = Assets.material.graphicEq,
				active = function()
					return currentPage() == "Sounds"
				end,
				onActivated = function()
					currentPage("Sounds")
				end,
			},

			NavTypes.NavOption {
				label = "Particles",
				icon = Assets.material.flare,
				active = function()
					return currentPage() == "Particles"
				end,
				onActivated = function()
					currentPage("Particles")
				end,
			},

			NavTypes.NavOption {
				label = "Beams",
				icon = Assets.material.fluorescent,
				active = function()
					return currentPage() == "Beams"
				end,
				onActivated = function()
					currentPage("Beams")
				end,
			},
		},
	}
end

return LibraryView
