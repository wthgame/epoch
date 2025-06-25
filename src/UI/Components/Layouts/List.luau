local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

local create = Vide.create

export type ListPresetProps = {
	name: Vide.As<string>?,

	sort: Vide.As<Enum.SortOrder>?,
	padding: Vide.As<UDim>?,
	wraps: Vide.As<boolean>?,
	flexX: Vide.As<Enum.UIFlexAlignment>?,
	flexY: Vide.As<Enum.UIFlexAlignment>?,
	itemLineAlignment: Vide.As<Enum.ItemLineAlignment>?,
}

export type ListProps = ListPresetProps & {
	direction: Vide.As<Enum.FillDirection>?,
}

local ZERO_UDIM = UDim.new()

local function Direction(props: ListProps)
	return create "UIListLayout" {
		Name = props.name or "List",
		FillDirection = props.direction,
		SortOrder = props.sort or Enum.SortOrder.LayoutOrder,
		Padding = props.padding or ZERO_UDIM,
		Wraps = props.wraps,
		HorizontalFlex = props.flexX,
		VerticalFlex = props.flexY,
		ItemLineAlignment = props.itemLineAlignment,
	}
end

local function X(props: ListPresetProps)
	return Direction {
		direction = Enum.FillDirection.Horizontal,

		name = props.name or "List.X",
		sort = props.sort,
		padding = props.padding,
		wraps = props.wraps,
		flexX = props.flexX,
		flexY = props.flexY,
		itemLineAlignment = props.itemLineAlignment,
	}
end

local function Y(props: ListPresetProps)
	return Direction {
		direction = Enum.FillDirection.Vertical,

		name = props.name or "List.Y",
		sort = props.sort,
		padding = props.padding,
		wraps = props.wraps,
		flexX = props.flexX,
		flexY = props.flexY,
		itemLineAlignment = props.itemLineAlignment,
	}
end

local List = table.freeze({
	Direction = Direction,
	X = X,
	Y = Y,
})

return List
