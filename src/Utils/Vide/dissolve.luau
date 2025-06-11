local Epoch = script:FindFirstAncestor("Epoch")
local Types = require(Epoch.Types)
local Vide = require(Epoch.Packages.Vide)

--- Dissolves a source into a constant value if it has no `read` dependencies.
local function dissolve<T>(source: (read: <T>(value: Types.ReadAs<T>) -> T) -> T): Types.ReadAs<T>
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
			return source(Vide.read :: any)
		end
	end

	error(`Failed to initially call source: {dissolvedOrError}`)
end

return dissolve
