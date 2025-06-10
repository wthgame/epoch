local Epoch = script:FindFirstAncestor("Epoch")
local Contextual = require(Epoch.Utils.Contextual)
local Types = require(Epoch.Types)
local Vide = require(Epoch.Packages.Vide)

export type Theme = {
	name: string,
	background: Color3,
	text: Color3,

	library: {
		navBackground: Color3,
		navHoverBackground: Color3,
		navActiveBackground: Color3,
		navText: Color3,
		navActiveText: Color3,
	},
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

local Theme = {
	BUILTIN_THEMES = BuiltinThemes {
		dark = Theme {
			name = "Dark",
			background = Color3.fromRGB(40, 40, 40),
			text = Color3.fromRGB(255, 255, 255),

			library = {
				navBackground = Color3.fromHSV(150 / 360, 0.5, 0.35),
				navHoverBackground = Color3.fromHSV(150 / 360, 0.5, 0.3),
				navActiveBackground = Color3.fromHSV(150 / 360, 0.5, 1),
				navText = Color3.fromHSV(150 / 360, 0.5, 1),
				navActiveText = Color3.fromHSV(150 / 360, 0.5, 0.35),
			},
		},
		light = Theme {
			name = "Light",
			background = Color3.fromRGB(255, 255, 255),
			text = Color3.fromRGB(0, 0, 0),

			library = {
				navBackground = Color3.fromHSV(140, 0.5, 0.4),
				navHoverBackground = Color3.fromHSV(140, 0.5, 0.4),
				navActiveBackground = Color3.fromHSV(140, 0.5, 0.4),
				navText = Color3.fromHSV(140, 0.5, 0.4),
				navActiveText = Color3.fromHSV(150 / 360, 0.5, 0.65),
			},
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

Theme.name = createThemeIndexSource("name") :: () -> string
Theme.background = createThemeIndexSource("background") :: () -> Color3
Theme.text = createThemeIndexSource("text") :: () -> Color3

Theme.library = table.freeze({
	navBackground = createThemeIndexSource("library", "navBackground") :: () -> Color3,
	navHoverBackground = createThemeIndexSource("library", "navHoverBackground") :: () -> Color3,
	navActiveBackground = createThemeIndexSource("library", "navActiveBackground") :: () -> Color3,
	navText = createThemeIndexSource("library", "navText") :: () -> Color3,
	navActiveText = createThemeIndexSource("library", "navActiveText") :: () -> Color3,
})

return Theme
