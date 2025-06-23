local Epoch = script:FindFirstAncestor("Epoch")

local Trove = require(Epoch.Packages.Trove)
local plugin = require(Epoch.plugin)

local pluginTrove = Trove.new()
pluginTrove:Add(plugin.Unloading:Once(function()
	pluginTrove:Clean()
end))

return pluginTrove
