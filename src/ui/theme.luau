local Oklab = require("@pkgs/oklab")
local Padding = require("@src/ui/components/Padding")
local TimeContextual = require("@src/utils/time_contextual")
local vide = require("@src/vide")

local create = vide.create
local source = vide.source

export type Theme = {
	name: string,

	text: Color3,
	subtext1: Color3,
	subtext0: Color3,
	overlay2: Color3,
	overlay1: Color3,
	overlay0: Color3,
	surface2: Color3,
	surface1: Color3,
	surface0: Color3,
	base: Color3,
	mantle: Color3,
	crust: Color3,
}

local function theme(x: Theme)
	return table.freeze(x)
end

export type BuiltinThemeKey = "dark" | "light"
export type UserThemeKey = BuiltinThemeKey | "system"

type BuiltinThemes = { [BuiltinThemeKey]: Theme }

local function BuiltinThemes(x: BuiltinThemes)
	return table.freeze(x)
end

local function oklch_to_color3(oklch: Vector3)
	return Oklab.linear_srgb_to_color3(Oklab.oklab_to_linear_srgb(Oklab.oklch_to_oklab(oklch)))
end

local theme = {
	BUILTIN_THEMES = BuiltinThemes {
		dark = theme {
			name = "Dark",

			text = oklch_to_color3(Vector3.new(0.9, 0.002, 240 / 360)),
			subtext1 = oklch_to_color3(Vector3.new(0.85, 0.002, 240 / 360)),
			subtext0 = oklch_to_color3(Vector3.new(0.8, 0.002, 240 / 360)),
			overlay2 = oklch_to_color3(Vector3.new(0.7, 0.002, 240 / 360)),
			overlay1 = oklch_to_color3(Vector3.new(0.65, 0.002, 240 / 360)),
			overlay0 = oklch_to_color3(Vector3.new(0.6, 0.002, 240 / 360)),
			surface2 = oklch_to_color3(Vector3.new(0.5, 0.002, 240 / 360)),
			surface1 = oklch_to_color3(Vector3.new(0.45, 0.002, 240 / 360)),
			surface0 = oklch_to_color3(Vector3.new(0.4, 0.002, 240 / 360)),
			base = oklch_to_color3(Vector3.new(0.3, 0.002, 240 / 360)),
			mantle = oklch_to_color3(Vector3.new(0.25, 0.002, 240 / 360)),
			crust = oklch_to_color3(Vector3.new(0.2, 0.002, 240 / 360)),
		},
		light = theme {
			name = "Light",

			text = oklch_to_color3(Vector3.new(0.2, 0.002, 240 / 360)),
			subtext1 = oklch_to_color3(Vector3.new(0.25, 0.002, 240 / 360)),
			subtext0 = oklch_to_color3(Vector3.new(0.3, 0.002, 240 / 360)),
			overlay2 = oklch_to_color3(Vector3.new(0.4, 0.002, 240 / 360)),
			overlay1 = oklch_to_color3(Vector3.new(0.45, 0.002, 240 / 360)),
			overlay0 = oklch_to_color3(Vector3.new(0.5, 0.002, 240 / 360)),
			surface2 = oklch_to_color3(Vector3.new(0.6, 0.002, 240 / 360)),
			surface1 = oklch_to_color3(Vector3.new(0.65, 0.002, 240 / 360)),
			surface0 = oklch_to_color3(Vector3.new(0.7, 0.002, 240 / 360)),
			base = oklch_to_color3(Vector3.new(0.8, 0.002, 240 / 360)),
			mantle = oklch_to_color3(Vector3.new(0.85, 0.002, 240 / 360)),
			crust = oklch_to_color3(Vector3.new(0.9, 0.002, 240 / 360)),
		},
	},
}

function theme.useStudiotheme(): "dark" | "light"
	local studioBG = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	return if studioBG.R + studioBG.G + studioBG.B < 1.5 then "dark" else "light"
end

-- theme.useStudiotheme = Vide.derive(theme.useStudiotheme) :: any

theme.user_selected_theme_key = source("system") :: vide.Source<UserThemeKey>

function theme.use_theme_key(): BuiltinThemeKey
	local user_theme: UserThemeKey = theme.user_selected_theme_key()
	return if user_theme == "system" then theme.useStudiotheme() else user_theme
end

theme.use_theme = TimeContextual(function(): Theme
	local theme_key: BuiltinThemeKey = theme.use_theme_key()
	return theme.BUILTIN_THEMES[theme_key]
end :: any) :: TimeContextual.TimeContextual<vide.As<Theme>>

local function create_theme_index_source<T>(...: string): () -> T
	local len = select("#", ...)
	local indexes = { ... }

	local function source(): T
		local theme: Theme = vide.read(theme.use_theme:now())
		local value = theme
		for i = 1, len do
			value = value[indexes[i]]
		end
		return value :: any
	end

	return source
end

-- new luau solver why must you be so ass
-- with no keyof i have to do this </3
theme.name = create_theme_index_source("name") :: () -> string
theme.text = create_theme_index_source("text") :: () -> Color3
theme.subtext1 = create_theme_index_source("subtext1") :: () -> Color3
theme.subtext0 = create_theme_index_source("subtext0") :: () -> Color3
theme.overlay2 = create_theme_index_source("overlay2") :: () -> Color3
theme.overlay1 = create_theme_index_source("overlay1") :: () -> Color3
theme.overlay0 = create_theme_index_source("overlay0") :: () -> Color3
theme.surface2 = create_theme_index_source("surface2") :: () -> Color3
theme.surface1 = create_theme_index_source("surface1") :: () -> Color3
theme.surface0 = create_theme_index_source("surface0") :: () -> Color3
theme.base = create_theme_index_source("base") :: () -> Color3
theme.mantle = create_theme_index_source("mantle") :: () -> Color3
theme.crust = create_theme_index_source("crust") :: () -> Color3

export type ThemePreviewProps = {
	fillDirection: "horizontal" | "vertical",
	render: () -> vide.Child,
}

function theme.ThemePreview(props: ThemePreviewProps)
	local previews = {}

	for theme_name, theme_data in theme.BUILTIN_THEMES do
		table.insert(
			previews,
			create "Frame" {
				Name = theme_name,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
				BackgroundColor3 = theme_data.base,

				create "UIListLayout" {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				},

				Padding { x = UDim.new(0, 32) },

				theme.use_theme:provide_during(theme_data, props.render),
			}
		)
	end

	return create "Frame" {
		Name = "themePreview",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,

		create "UIGridLayout" {
			CellPadding = UDim2.new(),
			CellSize = if props.fillDirection == "horizontal"
				then UDim2.fromScale(1 / #previews, 1)
				else UDim2.fromScale(1, 1 / #previews),
			FillDirection = if props.fillDirection == "horizontal"
				then Enum.FillDirection.Horizontal
				else Enum.FillDirection.Vertical,
		},

		previews,
	}
end

return theme
