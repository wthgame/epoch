local Epoch = script:FindFirstAncestor("Epoch")
local Option = require(Epoch.Packages.Option)
local UILabs = require(Epoch.Packages.UILabs)

local plugin = Option.from(script:FindFirstAncestorWhichIsA("Plugin") or UILabs.Environment.Plugin)

return plugin
