local vide = require("@pkgs/vide")

local action = vide.action
local cleanup = vide.cleanup

local function changed(property: string, output: (value: any) -> ())
	return action(function(instance)
		cleanup(instance:GetPropertyChangedSignal(property):Connect(function()
			output((instance :: any)[property])
		end))
	end)
end

return changed
