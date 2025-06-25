local LogService = game:GetService("LogService")
local Epoch = script:FindFirstAncestor("Epoch")
local plugin = require(Epoch.plugin)

assert(plugin, "Epoch must be ran as a plugin.")

local LibraryView = require(Epoch.UI.Views.Library.LibraryView)
local Logger = require(Epoch.Logger)
local Vide = require(Epoch.Vide)
local Widget = require(Epoch.UI.Components.Studio.Widget)
local formatShortVersion = require(Epoch.Utils.Versions.formatShortVersion)
local isDev = require(Epoch.Utils.isDev)
local pluginTrove = require(Epoch.pluginTrove)
local version = require(Epoch.Constants.version)

local effect = Vide.effect
local source = Vide.source
local root = Vide.root

local PLACEHOLDER = "rbxassetid://76509713405825"

if isDev then
	LogService:ClearOutput()
end

local log = Logger("Epoch")
log:info("Loading!")
pluginTrove:Add(function()
	log:info("Unloading!")
end)

local toolbar = plugin:CreateToolbar(`Epoch v{formatShortVersion(version)}`)

pluginTrove:Add(root(function()
	local function observeButtonToggle(button: PluginToolbarButton): Vide.Source<boolean>
		local toggled = source(false)
		button.Click:Connect(function()
			toggled(not toggled())
		end)
		effect(function()
			button:SetActive(toggled())
		end)
		return toggled
	end

	local _buildButton = toolbar:CreateButton("Epoch/Build", "Epoch Build", PLACEHOLDER, "Build")

	task.wait()
	local libraryToggled =
		observeButtonToggle(toolbar:CreateButton("Epoch/Library", "Epoch Library", PLACEHOLDER, "Library"))

	Widget {
		id = "Epoch/Library",
		title = "Epoch Library",
		enabled = libraryToggled,

		onClose = function()
			libraryToggled(false)
		end,

		initDockState = Enum.InitialDockState.Right,

		LibraryView {},
	}

	task.wait()
	local inspectToggled =
		observeButtonToggle(toolbar:CreateButton("Epoch/Inspect", "Epoch Inspect", PLACEHOLDER, "Inspect"))

	Widget {
		id = "Epoch/Inspect",
		title = "Epoch Inspect",
		enabled = inspectToggled,

		onClose = function()
			inspectToggled(false)
		end,

		initDockState = Enum.InitialDockState.Right,
	}

	task.wait()
	local toolsToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Tools", "Epoch Tools", PLACEHOLDER, "Tools"))

	Widget {
		id = "Epoch/Tools",
		title = "Epoch Tools",
		enabled = toolsToggled,

		initDockState = Enum.InitialDockState.Right,
	}

	task.wait()
	local projectToggled =
		observeButtonToggle(toolbar:CreateButton("Epoch/Project", "Epoch Project", PLACEHOLDER, "Project"))

	Widget {
		id = "Epoch/Project",
		title = "Epoch Project",
		enabled = projectToggled,

		onClose = function()
			projectToggled(false)
		end,

		initDockState = Enum.InitialDockState.Float,
	}

	task.wait()
	local settingsToggled =
		observeButtonToggle(toolbar:CreateButton("Epoch/Settings", "Epoch Settings", PLACEHOLDER, "Settings"))

	Widget {
		id = "Epoch/Settings",
		title = "Epoch Settings",
		enabled = settingsToggled,

		onClose = function()
			settingsToggled(false)
		end,

		initDockState = Enum.InitialDockState.Float,
	}

	if isDev then
		log:info("Preparing to run tests...")

		local Tiniest = require(Epoch.Packages.Tiniest)

		local configured = Tiniest.configure({})
		local root = script.Parent
		local packages = root:WaitForChild("Packages")

		log:info("Collecting tests")
		local tests = configured.collect_tests(function()
			for _, module in root:GetDescendants() do
				if
					not module:IsDescendantOf(packages)
					and module:IsA("ModuleScript")
					and module.Name:match("%.spec$")
				then
					log:info("Got test module:", module:GetFullName())
					local requireSuccess, testOrError = pcall(require, module)
					if not requireSuccess then
						log:warn("Failed to require spec module", module:GetFullName(), "because:", testOrError)
					else
						configured.describe(module.Parent.Name, function()
							configured.describe(module.Name:gsub("%.spec$", ""), function()
								testOrError(configured)
							end)
						end)
					end
				end
			end
		end)

		log:info("Running tests")
		configured.run_tests(tests, {})
	end
end))
