local PluginDebugService = game:GetService("PluginDebugService")

local isDev = script:IsDescendantOf(PluginDebugService)

return isDev
