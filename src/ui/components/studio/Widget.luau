local plugin = require("@src/plugin")
local vide = require("@src/vide")

local read = vide.read

export type WidgetProps = {
	id: vide.As<string>,
	gui_info: DockWidgetPluginGuiInfo,
	title: vide.As<string>?,
	enabled: vide.As<boolean>?,

	on_close: (() -> ())?,

	on_drag_dropped: (() -> ())?,
	on_drag_entered: (() -> ())?,
	on_drag_left: (() -> ())?,
	on_drag_moved: (() -> ())?,
	on_focused: (() -> ())?,
	on_unfocused: (() -> ())?,

	[number]: vide.Child,
}

local function Widget(props: WidgetProps): DockWidgetPluginGui
	local widget = plugin:CreateDockWidgetPluginGui(read(props.id), props.gui_info)

	if props.on_close then
		widget:BindToClose(props.on_close)
	end

	return vide.apply(widget) {
		Name = props.id,
		Title = props.title or props.id,
		Enabled = props.enabled,

		PluginDragDropped = props.on_drag_dropped,
		PluginDragEntered = props.on_drag_entered,
		PluginDragLeft = props.on_drag_left,
		PluginDragMoved = props.on_drag_moved,

		WindowFocused = props.on_focused,
		WindowFocusReleased = props.on_unfocused,

		table.unpack(props),
	}
end

return Widget
