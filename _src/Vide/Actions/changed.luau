local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Packages.Vide)

local action = Vide.action
local cleanup = Vide.cleanup

local function changed(property: string, output: (value: any) -> ())
	return action(function(instance)
		cleanup(instance:GetPropertyChangedSignal(property):Connect(function()
			output((instance :: any)[property])
		end))
	end)
end

return changed
