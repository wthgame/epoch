local Vide = require("@pkgs/Vide")

local action, cleanup = Vide.action, Vide.cleanup

local function changed(property: string, output: (value: any) -> ())
	return action(function(instance)
		cleanup(instance:GetPropertyChangedSignal(property):Connect(function()
			output((instance :: any)[property])
		end))
	end)
end

return changed
