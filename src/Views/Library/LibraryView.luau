-- local Assets = require(Epoch.Assets)
-- local NavTypes = require(Epoch.UI.Components.Nav.NavTypes)
local Button = require("@components/Controls/Button")
local TextField = require("@components/Controls/TextField")
local Theme = require("@src/Theme")
local Vide = require("@pkgs/Vide")

local create, source = Vide.create, Vide.source

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	-- local currentPage = source("COs")
	local searchInput = source("")

	return create "Frame" {
		Name = "LibraryView",
		BackgroundColor3 = Theme.base,
		Size = UDim2.fromScale(1, 1),

		create "UIListLayout" {},

		create "Frame" {
			Name = "LibraryNav",
			BackgroundColor3 = Theme.surface0,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				-- HorizontalFlex = Enum.UIFlexAlignment.Fill,
			},

			Button {
				label = "COs",

				colors = {
					base = Theme.surface1,
				},

				layout = {
					size = UDim2.fromOffset(64, 32),
				},
			},

			TextField {
				text = searchInput,
				placeholderText = "Type to search...",
				onInput = function(new)
					searchInput(new)
				end,

				layout = {
					size = UDim2.fromOffset(0, 32),
				},

				create "UIFlexItem" {
					FlexMode = Enum.UIFlexMode.Fill,
				},
			},
		},
	}
end

return LibraryView
