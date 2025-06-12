local Epoch = script:FindFirstAncestor("Epoch")
local Contextual = require(Epoch.Utils.Contextual)
local Oklab = require(Epoch.Packages.Oklab)
local Padding = require(Epoch.UI.Components.Padding)
local Types = require(Epoch.Types)
local Vide = require(Epoch.Packages.Vide)

local create = Vide.create

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

local function Theme(x: Theme)
	return table.freeze(x)
end

export type BuiltinThemeKey = "dark" | "light"
export type UserThemeKey = BuiltinThemeKey | "system"

type BuiltinThemes = { [BuiltinThemeKey]: Theme }

local function BuiltinThemes(x: BuiltinThemes)
	return table.freeze(x)
end

local function oklchToColor3(oklch: Vector3)
	return Oklab.linear_srgb_to_color3(Oklab.oklab_to_linear_srgb(Oklab.oklch_to_oklab(oklch)))
end

local Theme = {
	BUILTIN_THEMES = BuiltinThemes {
		dark = Theme {
			name = "Dark",

			text = oklchToColor3(Vector3.new(0.9, 0.002, 240 / 360)),
			subtext1 = oklchToColor3(Vector3.new(0.85, 0.002, 240 / 360)),
			subtext0 = oklchToColor3(Vector3.new(0.8, 0.002, 240 / 360)),
			overlay2 = oklchToColor3(Vector3.new(0.7, 0.002, 240 / 360)),
			overlay1 = oklchToColor3(Vector3.new(0.65, 0.002, 240 / 360)),
			overlay0 = oklchToColor3(Vector3.new(0.6, 0.002, 240 / 360)),
			surface2 = oklchToColor3(Vector3.new(0.5, 0.002, 240 / 360)),
			surface1 = oklchToColor3(Vector3.new(0.45, 0.002, 240 / 360)),
			surface0 = oklchToColor3(Vector3.new(0.4, 0.002, 240 / 360)),
			base = oklchToColor3(Vector3.new(0.3, 0.002, 240 / 360)),
			mantle = oklchToColor3(Vector3.new(0.25, 0.002, 240 / 360)),
			crust = oklchToColor3(Vector3.new(0.2, 0.002, 240 / 360)),
		},
		light = Theme {
			name = "Light",

			text = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			subtext1 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			subtext0 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			overlay2 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			overlay1 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			overlay0 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			surface2 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			surface1 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			surface0 = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			base = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			mantle = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
			crust = oklchToColor3(Vector3.new(0.0, 0.002, 240 / 360)),
		},
	},
}

function Theme.useStudioTheme(): "dark" | "light"
	local studioBG = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
	return if studioBG.R + studioBG.G + studioBG.B < 1.5 then "dark" else "light"
end

-- Theme.useStudioTheme = Vide.derive(Theme.useStudioTheme) :: any

Theme.userSelectedThemeKey = Vide.source("system") :: Vide.Source<UserThemeKey>

function Theme.useThemeKey(): BuiltinThemeKey
	local userTheme: UserThemeKey = Theme.userSelectedThemeKey()
	return if userTheme == "system" then Theme.useStudioTheme() else userTheme
end

-- Theme.useThemeKey = Vide.derive(Theme.useThemeKey) :: any

Theme.useTheme = Contextual(function(): Theme
	local themeKey: BuiltinThemeKey = Theme.useThemeKey()
	return Theme.BUILTIN_THEMES[themeKey]
end :: any) :: Contextual.Contextual<Types.ReadAs<Theme>>

local function createThemeIndexSource<T>(...: string): () -> T
	local len = select("#", ...)
	local indexes = { ... }

	local function source(): T
		local theme: Theme = Vide.read(Theme.useTheme:now())
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
Theme.name = createThemeIndexSource("name") :: () -> string
Theme.text = createThemeIndexSource("text") :: () -> Color3
Theme.subtext1 = createThemeIndexSource("subtext1") :: () -> Color3
Theme.subtext0 = createThemeIndexSource("subtext0") :: () -> Color3
Theme.overlay2 = createThemeIndexSource("overlay2") :: () -> Color3
Theme.overlay1 = createThemeIndexSource("overlay1") :: () -> Color3
Theme.overlay0 = createThemeIndexSource("overlay0") :: () -> Color3
Theme.surface2 = createThemeIndexSource("surface2") :: () -> Color3
Theme.surface1 = createThemeIndexSource("surface1") :: () -> Color3
Theme.surface0 = createThemeIndexSource("surface0") :: () -> Color3
Theme.base = createThemeIndexSource("base") :: () -> Color3
Theme.mantle = createThemeIndexSource("mantle") :: () -> Color3
Theme.crust = createThemeIndexSource("crust") :: () -> Color3

export type ThemePreviewProps = {
	fillDirection: "horizontal" | "vertical",
	render: () -> Types.Child,
}

function Theme.ThemePreview(props: ThemePreviewProps)
	local previews = {}

	for themeName, theme in Theme.BUILTIN_THEMES do
		table.insert(
			previews,
			create "Frame" {
				Name = themeName,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
				BackgroundColor3 = theme.base,

				create "UIListLayout" {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				},

				Padding { x = UDim.new(0, 32) },

				Theme.useTheme:provideDuring(theme, props.render),
			}
		)
	end

	return create "Frame" {
		Name = "ThemePreview",
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

return Theme
