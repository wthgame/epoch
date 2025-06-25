local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

export type LayoutProps = {
	position: Vide.As<UDim2>?,
	anchorPoint: Vide.As<Vector2>?,
	automaticSize: Vide.As<Enum.AutomaticSize>?,
	size: Vide.As<UDim2>?,
	layoutOrder: Vide.As<number>?,
	zIndex: Vide.As<number>?,
	visible: Vide.As<boolean>?,
}

return nil
