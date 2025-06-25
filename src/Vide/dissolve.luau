local Epoch = script:FindFirstAncestor("Epoch")

local Types = require(Epoch.Vide.Types)
local Vide = require(Epoch.Packages.Vide)

local read = Vide.read

--- Dissolves a source into a constant value if it has no `read` dependencies.
local function dissolve<T>(source: (read: <T>(value: Types.As<T>) -> T) -> T): Types.As<T>
	local readsDependency = false

	local function mockRead(value: unknown)
		if typeof(value) == "function" then
			readsDependency = true
			error("used dependency")
		end
		return value
	end

	local initialSuccess, dissolvedOrError = pcall(source, mockRead :: any)

	if initialSuccess then
		return dissolvedOrError
	end

	if readsDependency then
		return function()
			return source(read :: any)
		end
	end

	error(`Dissolving source threw an error: {dissolvedOrError}`)
end

return dissolve
