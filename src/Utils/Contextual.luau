--- Stores a value scoped in time.
export type Contextual<T> = {
	now: (self: Contextual<T>) -> T,
	provideDuring: <Args..., Returns...>(
		self: Contextual<T>,
		value: T,
		callback: (Args...) -> Returns...,
		Args...
	) -> Returns...,
}

local WEAK_KEYS_METATABLE = table.freeze({ __mode = "k" })

local function Contextual<T>(defaultValue: T): Contextual<T>
	local self = {} :: Contextual<T>

	-- if we held strong references to threads here, then if a thread was killed
	-- before this contextual had a chance to finish executing its callback, it
	-- would be held strongly in this table forever
	local valuesNow = setmetatable({} :: { [thread]: { value: T } }, WEAK_KEYS_METATABLE)

	function self:now()
		local thread = coroutine.running()
		local value = valuesNow[thread]
		if typeof(value) ~= "table" then
			return defaultValue
		else
			return value.value
		end
	end

	function self:provideDuring<Args..., Returns...>(value: T, callback: (Args...) -> Returns..., ...: Args...): Returns...
		local thread = coroutine.running()
		local prevValue = valuesNow[thread]
		-- Storing the value in this format allows us to distinguish storing
		-- `nil` from not calling `:during()` at all.
		valuesNow[thread] = { value = value }
		local packed = table.pack(pcall(callback, ...))
		valuesNow[thread] = prevValue
		if not packed[1] then
			error(packed[2])
		end
		return table.unpack(packed :: any, 2, packed.n)
	end

	return self
end

return Contextual
