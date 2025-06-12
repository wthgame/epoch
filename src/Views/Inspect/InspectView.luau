local Theme = require("@src/Theme")
local Vide = require("@pkgs/Vide")

export type InspectViewProps = {}

local function InspectView(props: InspectViewProps)
	return Vide.create "Frame" {
		BackgroundColor3 = Theme.base,
		Size = UDim2.fromScale(1, 1),
	}
end

return InspectView
