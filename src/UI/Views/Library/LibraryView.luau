local Epoch = script:FindFirstAncestor("Epoch")
local Assets = require(Epoch.Assets)
local NavTypes = require(Epoch.Ui.Components.Nav.NavTypes)
local TextField = require(Epoch.Ui.Components.Controls.TextField)
local Theme = require(Epoch.Ui.Theme)
local TopNav = require(Epoch.Ui.Components.Nav.TopNav)
local Vide = require(Epoch.Packages.Vide)

local create, source = Vide.create, Vide.source

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	local currentPage = source("COs")
	local searchInput = source("")

	return create "Frame" {
		Name = "LibraryView",
		BackgroundColor3 = Theme.background,
		Size = UDim2.fromScale(1, 1),

		create "UiListLayout" {
			Padding = UDim.new(0, 8),
		},

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

		TextField {
			text = searchInput,
			placeholderText = "Type to search",
			onInput = function(new)
				searchInput(new)
			end,

			colors = {
				background = Theme.input.background,
				borderActive = Theme.library.navActiveBackground,
				text = Theme.text,
				placeholder = Theme.input.placeholder,
			},
		},
	}
end

return LibraryView
