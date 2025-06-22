-- local Types = require("@src/Types")

-- type IconPlacement = "left" | "top"

-- export type NavOption = {
-- 	label: vide.As<string>?,
-- 	id: vide.As<string>?,
-- 	icon: string?,
-- 	active: vide.As<boolean>?,
-- 	on_activated: (() -> ())?,
-- }

-- export type NavProps = {
-- 	name: vide.As<string>?,

-- 	colors: {
-- 		background: vide.As<Color3>,
-- 		hoverBackground: vide.As<Color3>,
-- 		activeBackground: vide.As<Color3>,
-- 		text: vide.As<Color3>,
-- 		activeText: vide.As<Color3>,
-- 	},

-- 	iconPlacement: vide.As<IconPlacement>?,

-- 	layout: Types.LayoutProps?,

-- 	[number]: NavOption,
-- }

-- local NavTypes = {}

-- function NavTypes.NavOption(x: NavOption)
-- 	return table.freeze(x)
-- end

-- return NavTypes
