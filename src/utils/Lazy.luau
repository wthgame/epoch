local Epoch = script:FindFirstAncestor("Epoch")

local Option = require(Epoch.Packages.Option)
local Result = require(Epoch.Packages.Result)

--- Lazy-loading wrapper
export type Lazy<T, Args...> = {
	get: (self: Lazy<T, Args...>, Args...) -> T,
	tryGet: (self: Lazy<T, Args...>, Args...) -> Result.Result<T, unknown>,
	peek: (self: Lazy<T, Args...>) -> Option.Option<T>,
	isLoaded: (self: Lazy<T, Args...>) -> boolean,
}

local values: { [Lazy<any, ...any>]: any } = {}
local isLoaded: { [Lazy<any, ...any>]: true } = {}

local function Lazy<T, Args...>(loadCallback: (Args...) -> T): Lazy<T, Args...>
	local self = {} :: Lazy<T, Args...>

	function self:get(...)
		if isLoaded[self] then
			return values[self]
		end
		local returns = loadCallback(...)
		values[self] = returns
		isLoaded[self] = true
		return returns
	end

	function self:tryGet(...)
		if isLoaded[self] then
			return Result.Ok(values[self])
		end
		local result = Result.try(loadCallback, ...)
		if result:isOk() then
			values[self] = result:unwrap()
			isLoaded[self] = true
		end
		return result
	end

	function self:peek()
		return Option.from(values[self])
	end

	function self:isLoaded()
		return isLoaded[self]
	end

	return table.freeze(self)
end

return Lazy
