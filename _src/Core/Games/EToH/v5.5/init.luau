local Epoch = script:FindFirstAncestor("Epoch")

local Types = require(Epoch.Core.Games.Types)

local ClientObjects = script:WaitForChild("ClientObjects")

local function insertClientObject() end

local function insertKit()
	return {}
end

return Types.Kit({
	version = vector.create(5, 5),
	thumbnail = "",

	insertClientObject = insertClientObject,
	insertKit = insertKit,

	clientObjects = {
		Types.KitClientObject({
			name = "Speed Booster",
			model = ClientObjects:WaitForChild("SpeedBooster"),
		}),
	},
})
