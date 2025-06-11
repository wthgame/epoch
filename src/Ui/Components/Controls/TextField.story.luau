local Epoch = script:FindFirstAncestor("Epoch")
local TextField = require("./TextField")
local Theme = require(Epoch.Ui.Theme)
local UILabs = require(Epoch.Packages.UILabs)
local Vide = require(Epoch.Packages.Vide)

return UILabs.CreateVideStory(
	{
		vide = require(Epoch.Packages.Vide),
		controls = {
			placeholder = "Type to search potential victims...",
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

					colors = {
						background = Theme.input.background,
						borderActive = Theme.input.borderActive,
						text = Theme.text,
						placeholder = Theme.input.placeholder,
					},
				}
			end,
		})
	end :: any
)
