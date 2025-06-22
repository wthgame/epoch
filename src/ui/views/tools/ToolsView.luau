local Bevel = require("@src/ui/components/fx/Bevel")
local Button = require("@src/ui/components/controls/Button")
local TextField = require("@src/ui/components/controls/TextField")
local theme = require("@src/ui/theme")
local vide = require("@src/vide")

local create = vide.create
local source = vide.source

export type LibraryViewProps = {}

local function ToolsView(props: LibraryViewProps)
	local searchInput = source("")

	return create "Frame" {
		Name = "ToolsView",
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

			Button {
				label = "COs",

				colors = {
					base = theme.surface1,
				},

				layout = {
					size = UDim2.fromOffset(64, 32),
				},

				Bevel {},
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

return ToolsView
