--
-- local NavTypes = require("./NavTypes")
-- local Text = require("@components/Text")
-- local Vide = require("@pkgs/Vide")
-- local dissolve = require("@utils/Vide/dissolve")
-- local iterArray = require(Epoch.Utils.Collections.iterArray)

-- local function TopNavOption(props: NavTypes.NavOption, navProps: NavTypes.NavProps)
-- 	local hover = Vide.source(false)

-- 	local textColor = Vide.spring(function()
-- 		return if Vide.read(props.active)
-- 			then Vide.read(navProps.colors.activeText)
-- 			else Vide.read(navProps.colors.text)
-- 	end, 0.2)

-- 	return Vide.create "ImageButton" {
-- 		BackgroundColor3 = Vide.spring(function()
-- 			return if Vide.read(props.active)
-- 				then Vide.read(navProps.colors.activeBackground)
-- 				else hover() and Vide.read(navProps.colors.hoverBackground) or Vide.read(
-- 					navProps.colors.background
-- 				)
-- 		end, 0.2),

-- 		Activated = props.on_activated,
-- 		MouseEnter = function()
-- 			hover(true)
-- 		end,
-- 		MouseLeave = function()
-- 			hover(false)
-- 		end,

-- 		Vide.create "UIListLayout" {
-- 			FillDirection = dissolve(function(read)
-- 				return if read(navProps.iconPlacement) == "horizontal"
-- 					then Enum.FillDirection.Horizontal
-- 					else Enum.FillDirection.Vertical
-- 			end),
-- 			HorizontalAlignment = Enum.HorizontalAlignment.Center,
-- 			VerticalAlignment = Enum.VerticalAlignment.Center,
-- 		},

-- 		props.icon and Vide.create "ImageLabel" {
-- 			BackgroundTransparency = 1,
-- 			Image = props.icon,
-- 			ImageTransparency = 1 / 3,
-- 			ImageColor3 = textColor,
-- 			Size = UDim2.fromOffset(20, 20),
-- 		},

-- 		Text {
-- 			text = props.label,
-- 			color = textColor,
-- 			size = 16,

-- 			layout = {
-- 				position = UDim2.new(0.5, 0, 0.5, 0),
-- 				anchorPoint = Vector2.new(0.5, 0.5),
-- 			},
-- 		},

-- 		Vide.create "UIGradient" {
-- 			Color = ColorSequence.new({
-- 				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
-- 				ColorSequenceKeypoint.new(0.02, Color3.new(1, 1, 1)),
-- 				ColorSequenceKeypoint.new(0.025, Color3.new(0.8, 0.8, 0.8)),
-- 				ColorSequenceKeypoint.new(0.98, Color3.new(0.7, 0.7, 0.7)),
-- 				ColorSequenceKeypoint.new(0.985, Color3.new(0.5, 0.5, 0.5)),
-- 				ColorSequenceKeypoint.new(1, Color3.new(0.5, 0.5, 0.5)),
-- 			}),
-- 			Rotation = 90,
-- 		},
-- 	}
-- end

-- local function TopNav(props: NavTypes.NavProps)
-- 	local layout = props.layout or {} :: never

-- 	return Vide.create "Frame" {
-- 		Name = props.name or "TopNav",

-- 		BackgroundColor3 = props.colors.background,

-- 		Position = layout.position,
-- 		AnchorPoint = layout.anchorPoint,
-- 		AutomaticSize = layout.automaticSize,
-- 		Size = layout.size or dissolve(function(read)
-- 			return if read(props.iconPlacement) ~= "horizontal"
-- 				then UDim2.new(1, 0, 0, 32 + 16)
-- 				else UDim2.new(1, 0, 0, 32)
-- 		end),
-- 		LayoutOrder = layout.layoutOrder,
-- 		ZIndex = layout.zIndex,
-- 		Visible = layout.visible,

-- 		Vide.create "UIGridLayout" {
-- 			CellPadding = UDim2.new(),
-- 			CellSize = UDim2.fromScale(1 / #props, 1),
-- 		},

-- 		iterArray({ table.unpack(props) }, function(option)
-- 			return TopNavOption(option, props)
-- 		end),
-- 	}
-- end

-- return TopNav
