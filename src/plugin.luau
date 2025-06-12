local Option = require("@pkgs/Option")
local UILabs = require("@pkgs/UILabs")

local plugin = Option.from(script:FindFirstAncestorWhichIsA("Plugin") or UILabs.Environment.Plugin)

return plugin
