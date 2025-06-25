local Epoch = script:FindFirstAncestor("Epoch")

local Vide = require(Epoch.Vide)

local create = Vide.create

export type IgnoreProps = {
	[number]: Vide.Child,
}

--- Wraps children in a Folder to ignore UI layouts.
local function Ignore(props: IgnoreProps)
	return create "Folder" {
		Name = "Ignore",
		table.unpack(props),
	}
end

return Ignore
