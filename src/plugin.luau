local Epoch = script:FindFirstAncestor("Epoch")

local UILabs = require(Epoch.Packages.UILabs)

local plugin: Plugin = plugin or script:FindFirstAncestorWhichIsA("Plugin") or UILabs.Environment.Plugin

return plugin
