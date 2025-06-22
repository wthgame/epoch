local Trove = require("@pkgs/trove")
local plugin = require("@src/plugin")

local plugin_trove = Trove.new()
plugin_trove:Add(plugin.Unloading:Once(function()
	plugin_trove:Clean()
end))

return plugin_trove
