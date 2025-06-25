local Epoch = script:FindFirstAncestor("Epoch")

local plugin = require(Epoch.plugin)

export type MouseIcon = {
	asset: string,
	push: (self: MouseIcon) -> (),
	pop: (self: MouseIcon) -> (),
	destroy: (self: MouseIcon) -> (),
}

local Icons = table.freeze({
	--- Default clicking and selection.
	Arrow = "rbxasset://SystemCursors/Arrow",
	--- Hovering over an active link/button.
	PointingHand = "rbxasset://SystemCursors/PointingHand",
	--- Hovering over a draggable item.
	OpenHand = "rbxasset://SystemCursors/OpenHand",
	--- Dragging an item.
	ClosedHand = "rbxasset://SystemCursors/ClosedHand",
	--- Hovering in a text field.
	IBeam = "rbxasset://SystemCursors/IBeam",
	--- Hovering over a vertical resize handle.
	SizeNS = "rbxasset://SystemCursors/SizeNS",
	--- Hovering over a horizontal resize handle.
	SizeEW = "rbxasset://SystemCursors/SizeEW",
	--- Hovering over a corner resize handle.
	SizeNESW = "rbxasset://SystemCursors/SizeNESW",
	--- Hovering over a corner resize handle.
	SizeNWSE = "rbxasset://SystemCursors/SizeNWSE",
	--- Hovering over a multi-direction resize handle.
	SizeAll = "rbxasset://SystemCursors/SizeAll",
	--- Hovering over a vertical "split" handle.
	SplitNS = "rbxasset://SystemCursors/SplitNS",
	--- Hovering over a horizontal "split" handle.
	SplitEW = "rbxasset://SystemCursors/SplitEW",
	--- Hovering over a locked/forbidden item.
	Forbidden = "rbxasset://SystemCursors/Forbidden",
	--- Indicating an action is in progress.
	Wait = "rbxasset://SystemCursors/Wait",
	--- Indicating the system is busy.
	Busy = "rbxasset://SystemCursors/Busy",
	--- Hovering over a pinpoint selection area.
	Cross = "rbxasset://SystemCursors/Cross",
})

local iconStack: { MouseIcon } = {}

local function getMouse(): PluginMouse
	if not plugin:IsActivatedWithExclusiveMouse() then
		plugin:Activate(true)
	end
	return plugin:GetMouse()
end

local function updateMouse()
	local newestIcon = iconStack[#iconStack]
	local asset = Icons.Arrow
	if newestIcon then
		asset = newestIcon.asset
	end
	getMouse().Icon = asset
end

local function MouseIcon(asset: string)
	local self = {} :: MouseIcon
	self.asset = asset

	function self:push()
		table.insert(iconStack, self)
		updateMouse()
	end

	function self:pop()
		table.remove(iconStack, table.find(iconStack, self))
		updateMouse()
	end

	self.destroy = self.pop

	return self
end

local mt = {}

function mt:__call(asset: string): MouseIcon
	return MouseIcon(asset)
end

table.freeze(mt)

return table.freeze(setmetatable({
	MouseIcon = MouseIcon,
	Icons = Icons,
}, mt))
