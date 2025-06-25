local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

local create = Vide.create

export type FlexPresetProps = {}

export type FlexItemProps = FlexPresetProps & {
	mode: Vide.As<Enum.UIFlexMode>?,
}

local function Item(props: FlexItemProps)
	return create "UIFlexItem" {
		FlexMode = props.mode,
	}
end

local function Fill(props: FlexPresetProps)
	return Item {
		mode = Enum.UIFlexMode.Fill,
	}
end

local function Grow(props: FlexPresetProps)
	return Item {
		mode = Enum.UIFlexMode.Grow,
	}
end

local function Shrink(props: FlexPresetProps)
	return Item {
		mode = Enum.UIFlexMode.Shrink,
	}
end

local Flex = table.freeze({
	Item = Item,
	Fill = Fill,
	Grow = Grow,
	Shrink = Shrink,
})

return Flex
