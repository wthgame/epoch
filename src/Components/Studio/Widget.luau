local plugin = script:FindFirstAncestorWhichIsA("Plugin")
assert(plugin, "Epoch must be ran as a plugin")

local Types = require("@src/Types")
local Vide = require("@pkgs/Vide")

local read = Vide.read

export type WidgetProps = Types.UnpackableProps & {
	id: Types.ReadAs<string>,
	guiInfo: DockWidgetPluginGuiInfo,
	title: Types.ReadAs<string>?,
	enabled: Types.ReadAs<boolean>?,

	onClose: (() -> ())?,

	onDragDropped: (() -> ())?,
	onDragEntered: (() -> ())?,
	onDragLeft: (() -> ())?,
	onDragMoved: (() -> ())?,
	onFocused: (() -> ())?,
	onUnfocused: (() -> ())?,
}

local function Widget(props: WidgetProps): DockWidgetPluginGui
	local widget = plugin:CreateDockWidgetPluginGui(read(props.id), props.guiInfo)

	if props.onClose then
		widget:BindToClose(props.onClose)
	end

	return Vide.apply(widget) {
		Name = props.id,
		Title = props.title or props.id,
		Enabled = props.enabled,

		PluginDragDropped = props.onDragDropped,
		PluginDragEntered = props.onDragEntered,
		PluginDragLeft = props.onDragLeft,
		PluginDragMoved = props.onDragMoved,

		WindowFocused = props.onFocused,
		WindowFocusReleased = props.onUnfocused,

		table.unpack(props),
	}
end

return Widget
