local types = require("./types")
local vide = require("@pkgs/vide")

local read = vide.read

--- Dissolves a source into a constant value if it has no `read` dependencies.
local function dissolve<T>(source: (read: <T>(value: types.As<T>) -> T) -> T): types.As<T>
	local reads_dependency = false

	local function mockRead(value: unknown)
		if typeof(value) == "function" then
			reads_dependency = true
			error("used dependency")
		end
		return value
	end

	local initial_success, dissolved_or_error = pcall(source, mockRead :: any)

	if initial_success then
		return dissolved_or_error
	end

	if reads_dependency then
		return function()
			return source(read :: any)
		end
	end

	error(`dissolving source threw an error: {dissolved_or_error}`)
end

return dissolve
