local Epoch = script:FindFirstAncestor("Epoch")
local Types = require(Epoch.Types)

type IconPlacement = "left" | "top"

export type NavOption = {
	label: Types.ReadAs<string>?,
	id: Types.ReadAs<string>?,
	icon: string?,
	active: Types.ReadAs<boolean>?,
	onActivated: (() -> ())?,
}

export type NavProps = {
	name: Types.ReadAs<string>?,

	colors: {
		background: Types.ReadAs<Color3>,
		hoverBackground: Types.ReadAs<Color3>,
		activeBackground: Types.ReadAs<Color3>,
		text: Types.ReadAs<Color3>,
		activeText: Types.ReadAs<Color3>,
	},

	iconPlacement: Types.ReadAs<IconPlacement>?,

	layout: Types.LayoutProps?,

	[number]: NavOption,
}

local NavTypes = {}

function NavTypes.NavOption(x: NavOption)
	return table.freeze(x)
end

return NavTypes
