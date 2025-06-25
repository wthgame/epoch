local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)
local plugin = require(Epoch.plugin)

local apply = Vide.apply
local read = Vide.read

export type WidgetProps = {
	id: Vide.As<string>,
	title: Vide.As<string>?,
	enabled: Vide.As<boolean>?,

	initDockState: Enum.InitialDockState?,
	initEnabled: boolean?,
	overrideEnabledRestore: boolean?,
	floatXSize: number?,
	floatYSize: number?,
	minWidth: number?,
	minHeight: number?,

	onClose: (() -> ())?,

	onDragDropped: (() -> ())?,
	onDragEntered: (() -> ())?,
	onDragLeft: (() -> ())?,
	onDragMoved: (() -> ())?,
	onFocused: (() -> ())?,
	onUnfocused: (() -> ())?,

	[number]: Vide.Child,
}

local function Widget(props: WidgetProps): DockWidgetPluginGui
	DockWidgetPluginGuiInfo.new()
	local widget = plugin:CreateDockWidgetPluginGui(
		read(props.id),
		DockWidgetPluginGuiInfo.new(
			props.initDockState or Enum.InitialDockState.Float,
			props.initEnabled or false,
			props.overrideEnabledRestore or false,
			props.floatXSize or 400,
			props.floatYSize or 400,
			props.minWidth or 300,
			props.minHeight or 300
		)
	)

	if props.onClose then
		widget:BindToClose(props.onClose)
	end

	return apply(widget) {
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
