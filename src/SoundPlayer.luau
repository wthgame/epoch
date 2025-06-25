local Epoch = script:FindFirstAncestor("Epoch")

local Lazy = require(Epoch.Utils.Lazy)
local plugin = require(Epoch.plugin)

-- Sounds only play in Edit mode when parented to a plugin widget, for some reason
local widget = Lazy(function()
	assert(plugin, "Plugin required")
	return plugin:CreateDockWidgetPluginGui(
		"Epoch/SoundPlayer",
		DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 10, 10, 10, 10)
	)
end)

local function parentToWidget(sound: Sound)
	sound.Parent = widget:tryGet():expect("Failed to get SoundPlayer widget")
end

local function consumeSound(sound: Sound)
	parentToWidget(sound)
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
	sound:Play()
end

local function playId(id: string)
	local sound = Instance.new("Sound")
	sound.SoundId = id
	consumeSound(sound)
end

local SoundPlayer = table.freeze({
	playId = playId,
	consumeSound = consumeSound,
	parentToWidget = parentToWidget,
})

return SoundPlayer
