local Bevel = require("@src/ui/components/fx/Bevel")
local TextField = require("@src/ui/components/controls/TextField")
local theme = require("@src/ui/theme")
local vide = require("@src/vide")

local create = vide.create
local source = vide.source

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	-- local currentPage = source("COs")
	local searchInput = source("")

	return create "Frame" {
		Name = "InspectView",
		BackgroundColor3 = theme.base,
		Size = UDim2.fromScale(1, 1),

		create "UIListLayout" {},

		create "Frame" {
			Name = "Nav",
			BackgroundColor3 = theme.surface0,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
			},

			TextField {
				text = searchInput,
				placeholder_text = "Type to search...",
				on_input = function(new)
					searchInput(new)
				end,

				layout = {
					size = UDim2.fromOffset(0, 32),
				},

				create "UIFlexItem" {
					FlexMode = Enum.UIFlexMode.Fill,
				},

				Bevel {},
			},
		},
	}
end

return LibraryView
