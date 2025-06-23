local LogService = game:GetService("LogService")
local Epoch = script:FindFirstAncestor("Epoch")
local plugin = require(Epoch.plugin)

assert(plugin, "Epoch must be ran as a plugin.")

local Logger = require(Epoch.Logger)
local Vide = require(Epoch.Vide)
local isDev = require(Epoch.Utils.isDev)
local pluginTrove = require(Epoch.pluginTrove)

local source = Vide.source

local PLACEHOLDER = "rbxassetid://132587080161296"

if isDev then
	LogService:ClearOutput()
end

local log = Logger("Epoch")
log:info("Loading!")
pluginTrove:Add(function()
	log:info("Unloading!")
end)

local toolbar = plugin:CreateToolbar(if isDev then "Epoch Indev" else "Epoch")

pluginTrove:Add(Vide.root(function()
	local function observeButtonToggle(button: PluginToolbarButton): Vide.Source<boolean>
		local toggled = source(false)
		button.Click:Connect(function()
			toggled(not toggled())
		end)

		return toggled
	end

	local _buildButton = toolbar:CreateButton("Epoch/Build", "TBA", PLACEHOLDER, "Build")

	task.wait()
	local _libraryToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Library", "TBA", PLACEHOLDER, "Library"))

	task.wait()
	local _inspectToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Inspect", "TBA", PLACEHOLDER, "Inspect"))

	task.wait()
	local _toolsToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Tools", "TBA", PLACEHOLDER, "Tools"))

	task.wait()
	local _projectToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Project", "TBA", PLACEHOLDER, "Project"))

	task.wait()
	local _settingsToggled = observeButtonToggle(toolbar:CreateButton("Epoch/Settings", "TBA", PLACEHOLDER, "Settings"))

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
