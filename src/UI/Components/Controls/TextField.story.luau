local Epoch = script:FindFirstAncestor("Epoch")
local TextField = require("./TextField")
local Theme = require(Epoch.UI.Theme)
local UILabs = require(Epoch.Packages.UILabs)
local Vide = require(Epoch.Packages.Vide)

return UILabs.CreateVideStory(
	{
		vide = require(Epoch.Packages.Vide),
		controls = {
			placeholder = "Type to search potential victims...",
			focusRing = Color3.fromRGB(60, 90, 210),
		},
	},
	function(props: UILabs.VideProps)
		return Theme.ThemePreview({
			fillDirection = "horizontal",
			render = function()
				local text = Vide.source("")

				return TextField {
					text = text,
					placeholderText = props.controls.placeholder,
					onInput = function(new)
						text(new)
					end,

					cornerRadius = UDim.new(0, 4),
					focusRing = props.controls.focusRing,

					colors = {},
				}
			end,
		})
	end :: any
)
