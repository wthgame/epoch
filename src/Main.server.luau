local plugin = script:FindFirstAncestorWhichIsA("Plugin")
assert(plugin, "Epoch must be ran as a plugin")

local Epoch = script:FindFirstAncestor("Epoch")
local InspectView = require("./UI/Views/Inspect/InspectView")
local LibraryView = require("./UI/Views/Library/LibraryView")
local Logger = require("./Utils/Logger")
local Trove = require(Epoch.Packages.Trove)
local Vide = require(Epoch.Packages.Vide)
local Widget = require("./UI/Components/Studio/Widget")

local PLACEHOLDER = "rbxassetid://132587080161296"

local logger = Logger.new("Epoch")
local pluginTrove = Trove.new()
logger:info("Loading!")

pluginTrove:Add(plugin.Unloading:Connect(function()
	logger:info("Unloading!")
	pluginTrove:Clean()
end))

local toolbar = plugin:CreateToolbar("Epoch")

pluginTrove:Add(Vide.mount(function()
	local function useToolbarToggleButton(name: string, description: string, icon: string, tooltip: string)
		-- let the previous buttons register
		task.wait()

		local button = toolbar:CreateButton(name, description, icon, tooltip)
		local toggled = Vide.source(false)
		button.Click:Connect(function()
			toggled(not toggled())
		end)

		return toggled, button
	end

	local _buildToggled = useToolbarToggleButton("Epoch/Build", "TBA", PLACEHOLDER, "Build")

	local libraryToggled = useToolbarToggleButton("Epoch/Library", "TBA", PLACEHOLDER, "Library")

	Widget {
		id = "Epoch/Library",
		guiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Library",
		enabled = libraryToggled,
		onClose = function()
			libraryToggled(false)
		end,

		LibraryView {},
	}

	local inspectToggled = useToolbarToggleButton("Epoch/Inspect", "TBA", PLACEHOLDER, "Inspect")

	Widget {
		id = "Epoch/Inspect",
		guiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Inspect",
		enabled = inspectToggled,
		onClose = function()
			inspectToggled(false)
		end,

		InspectView {},
	}

	local toolsToggled = useToolbarToggleButton("Epoch/Tools", "TBA", PLACEHOLDER, "Tools")

	Widget {
		id = "Epoch/Tools",
		guiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Tools",
		enabled = toolsToggled,
		onClose = function()
			toolsToggled(false)
		end,
	}

	local projectToggled = useToolbarToggleButton("Epoch/Project", "TBA", PLACEHOLDER, "Project")

	Widget {
		id = "Epoch/Project",
		guiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 400, 400),
		title = "Epoch Project",
		enabled = projectToggled,
		onClose = function()
			projectToggled(false)
		end,
	}

	local settingsToggled = useToolbarToggleButton("Epoch/Settings", "TBA", PLACEHOLDER, "Settings")

	Widget {
		id = "Epoch/Settings",
		guiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 400, 400),
		title = "Epoch Settings",
		enabled = settingsToggled,
		onClose = function()
			settingsToggled(false)
		end,
	}
end))
