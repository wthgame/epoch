local UILabs = require("@pkgs/ui-labs")

local plugin: Plugin = plugin or script:FindFirstAncestorWhichIsA("Plugin") or UILabs.Environment.Plugin

return plugin
