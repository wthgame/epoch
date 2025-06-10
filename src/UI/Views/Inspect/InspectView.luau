local Epoch = script:FindFirstAncestor("Epoch")
local Theme = require(Epoch.UI.Theme)
local Vide = require(Epoch.Packages.Vide)

export type InspectViewProps = {}

local function InspectView(props: InspectViewProps)
	return Vide.create "Frame" {
		BackgroundColor3 = Theme.background,
		Size = UDim2.fromScale(1, 1),
	}
end

return InspectView
