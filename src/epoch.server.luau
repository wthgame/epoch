local plugin = require("@src/plugin")
assert(plugin, "Epoch must be ran as a plugin")

local InspectView = require("@src/ui/views/inspect/InspectView")
local LibraryView = require("@src/ui/views/library/LibraryView")
local Logger = require("@src/utils/logger")
local ToolsView = require("@src/ui/views/tools/ToolsView")
local Widget = require("@src/ui/components/studio/Widget")
local plugin_trove = require("@src/plugin_trove")
local tiniest = require("@pkgs/tiniest")
local vide = require("@src/vide")

local PLACEHOLDER = "rbxassetid://132587080161296"

local logger = Logger.create("Epoch")
logger:info("Loading!")

plugin_trove:Add(function()
	logger:info("Unloading!")
end)

local toolbar = plugin:CreateToolbar("Epoch")

plugin_trove:Add(vide.mount(function()
	local function use_toggle_button(name: string, description: string, icon: string, tooltip: string)
		-- let the previous buttons register
		task.wait()

		local button = toolbar:CreateButton(name, description, icon, tooltip)
		local toggled = vide.source(false)
		button.Click:Connect(function()
			toggled(not toggled())
		end)

		return toggled, button
	end

	local _build_toggled = use_toggle_button("Epoch/Build", "TBA", PLACEHOLDER, "Build")

	local library_toggled = use_toggle_button("Epoch/Library", "TBA", PLACEHOLDER, "Library")

	Widget {
		id = "Epoch/Library",
		gui_info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Library",
		enabled = library_toggled,
		on_close = function()
			library_toggled(false)
		end,

		LibraryView {},
	}

	local inspect_toggled = use_toggle_button("Epoch/Inspect", "TBA", PLACEHOLDER, "Inspect")

	Widget {
		id = "Epoch/Inspect",
		gui_info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Inspect",
		enabled = inspect_toggled,
		on_close = function()
			inspect_toggled(false)
		end,

		InspectView {},
	}

	local tools_toggled = use_toggle_button("Epoch/Tools", "TBA", PLACEHOLDER, "Tools")

	Widget {
		id = "Epoch/Tools",
		gui_info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 400),
		title = "Epoch Tools",
		enabled = tools_toggled,
		on_close = function()
			tools_toggled(false)
		end,

		ToolsView {},
	}

	local project_toggled = use_toggle_button("Epoch/Project", "TBA", PLACEHOLDER, "Project")

	Widget {
		id = "Epoch/Project",
		gui_info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 400, 400),
		title = "Epoch Project",
		enabled = project_toggled,
		on_close = function()
			project_toggled(false)
		end,
	}

	local settings_toggled = use_toggle_button("Epoch/Settings", "TBA", PLACEHOLDER, "Settings")

	Widget {
		id = "Epoch/Settings",
		gui_info = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 400, 400),
		title = "Epoch Settings",
		enabled = settings_toggled,
		on_close = function()
			settings_toggled(false)
		end,
	}

	if _G.__DEV__ then
		logger:info("Running tests...")

		local tiniest = tiniest.configure({})
		local root = script.Parent
		local packages = root:WaitForChild("Packages")

		local tests = tiniest.collect_tests(function()
			for _, module in root:GetDescendants() do
				if
					not module:IsDescendantOf(packages)
					and module:IsA("ModuleScript")
					and module.Name:match("%.spec$")
				then
					local requireSuccess, testOrError = pcall(require, module)
					if not requireSuccess then
						logger:warn("Failed to require spec module", module:GetFullName(), "because:", testOrError)
					else
						tiniest.describe(module.Parent.Name, function()
							tiniest.describe(module.Name:gsub("%.spec$", ""), function()
								testOrError(tiniest)
							end)
						end)
					end
				end
			end
		end)

		tiniest.run_tests(tests, {})
	end
end))
