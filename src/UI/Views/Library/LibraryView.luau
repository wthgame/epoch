local Epoch = script:FindFirstAncestor("Epoch")

local Bevel = require(Epoch.UI.Components.Effects.Bevel)
local Button = require(Epoch.UI.Components.Controls.Button)
local Flex = require(Epoch.UI.Components.Layouts.Flex)
local List = require(Epoch.UI.Components.Layouts.List)
local TextField = require(Epoch.UI.Components.Controls.TextField)
local Theme = require(Epoch.UI.Theme)
local Vide = require(Epoch.Vide)

local create = Vide.create
local source = Vide.source

export type LibraryViewProps = {}

local function LibraryView(props: LibraryViewProps)
	local searchInput = source("")

	return create "Frame" {
		Name = "LibraryView",
		BackgroundColor3 = Theme.base,
		Size = UDim2.fromScale(1, 1),

		List.Y {},

		create "Frame" {
			Name = "LibraryNav",
			BackgroundColor3 = Theme.surface0,
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			List.X {},

			Button {
				label = "COs",

				colors = {
					base = Theme.surface1,
					hover = Theme.surface2,
				},

				layout = {
					size = UDim2.fromOffset(64, 32),
				},

				Bevel {},
			},

			TextField {
				text = searchInput,
				placeholderText = "Type to search...",
				onInput = function(new)
					searchInput(new)
				end,

				layout = {
					size = UDim2.fromOffset(0, 32),
					automaticSize = Enum.AutomaticSize.X,
				},

				Flex.Fill {},

				Bevel { invert = true },
			},
		},
	}
end

return LibraryView
