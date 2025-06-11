local Epoch = script:FindFirstAncestor("Epoch")
local Contextual = require(Epoch.Utils.Contextual)
local Padding = require(Epoch.Ui.Components.Padding)
local Types = require(Epoch.Types)
local Vide = require(Epoch.Packages.Vide)

local create = Vide.create

export type Theme = {
	name: string,
	background: Color3,
	text: Color3,

	input: {
		background: Color3,
		borderActive: Color3,
		placeholder: Color3,
		-- background = Theme.library.navBackground,
		-- border = Theme.library.navBackground,
		-- borderHover = Theme.library.navHoverBackground,
		-- borderActive = Theme.library.navActiveBackground,
		-- text = Theme.library.navText,
		-- placeholder = Theme.library.navActiveText,
	},

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
	BUiLTIN_THEMES = BuiltinThemes {
		dark = Theme {
			name = "Dark",
			background = Color3.fromRGB(40, 40, 40),
			text = Color3.fromRGB(255, 255, 255),

			input = {
				background = Color3.fromRGB(30, 30, 30),
				borderActive = Color3.fromRGB(60, 90, 210),
				placeholder = Color3.fromRGB(120, 120, 120),
			},

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

			input = {
				background = Color3.fromRGB(20, 20, 20),
				borderActive = Color3.fromRGB(60, 90, 210),
				placeholder = Color3.fromRGB(120, 120, 120),
			},

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
	return Theme.BUiLTIN_THEMES[themeKey]
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

Theme.input = table.freeze({
	background = createThemeIndexSource("input", "background") :: () -> Color3,
	borderActive = createThemeIndexSource("input", "borderActive") :: () -> Color3,
	placeholder = createThemeIndexSource("input", "placeholder") :: () -> Color3,
})

Theme.library = table.freeze({
	navBackground = createThemeIndexSource("library", "navBackground") :: () -> Color3,
	navHoverBackground = createThemeIndexSource("library", "navHoverBackground") :: () -> Color3,
	navActiveBackground = createThemeIndexSource("library", "navActiveBackground") :: () -> Color3,
	navText = createThemeIndexSource("library", "navText") :: () -> Color3,
	navActiveText = createThemeIndexSource("library", "navActiveText") :: () -> Color3,
})

export type ThemePreviewProps = {
	fillDirection: "horizontal" | "vertical",
	render: () -> Types.Child,
}

function Theme.ThemePreview(props: ThemePreviewProps)
	local previews = {}

	for themeName, theme in Theme.BUiLTIN_THEMES do
		table.insert(
			previews,
			create "Frame" {
				Name = themeName,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
				BackgroundColor3 = theme.background,

				create "UiListLayout" {
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

		create "UiGridLayout" {
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
