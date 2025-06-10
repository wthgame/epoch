-- Adapted from Welcome To Hell

type Pack = { [number]: unknown, n: number }

export type LoggerMessage = {
	when: number,
	logger: Logger,
	level: number,
	args: Pack,
}

export type Logger = {
	name: string,
	messages: { LoggerMessage },
	maxLevel: number?,

	trace: (self: Logger, ...unknown) -> LoggerMessage,
	debug: (self: Logger, ...unknown) -> LoggerMessage,
	info: (self: Logger, ...unknown) -> LoggerMessage,
	warn: (self: Logger, ...unknown) -> LoggerMessage,
	error: (self: Logger, ...unknown) -> LoggerMessage,

	assert: typeof(function<T>(self: Logger, value: T, ...: unknown)
		return assert(value)
	end),
}

local LogLevel = table.freeze({
	Trace = 0,
	Debug = 1,
	Info = 2,
	Warn = 3,
	Error = 4,
})

local LOG_LEVEL_TO_EMOJI = table.freeze({
	[LogLevel.Trace] = "📝",
	[LogLevel.Debug] = "🐛",
	[LogLevel.Info] = "🔎",
	[LogLevel.Warn] = "⚠️",
	[LogLevel.Error] = "🔥",
})

local defaultMaxLevel = LogLevel.Trace
local maxLevelPerThread: { [thread]: number } = setmetatable({} :: any, { __mode = "k" })

local function maxLevel()
	return maxLevelPerThread[coroutine.running()] or defaultMaxLevel
end

local function setDefaultMaxLevel(level: number)
	defaultMaxLevel = level
end

local function setMaxLevelForThread(level: number?, thread: thread?)
	local thread = thread or coroutine.running()
	maxLevelPerThread[thread] = level :: any
end

local function formatMessage(message: LoggerMessage): string
	local stringifiedArgs = {}
	for index = 1, message.args.n do
		local stringified = tostring(message.args[index])
		if stringified then
			table.insert(stringifiedArgs, stringified)
		end
	end
	local formattedTime = os.date("%Y/%m/%d %H:%M:%S", message.when)
	local formatted = `{formattedTime} {LOG_LEVEL_TO_EMOJI[message.level]} {message.logger.name}: {table.concat(
		stringifiedArgs,
		" "
	)}`
	return (formatted:gsub("\n", "\n    "))
end

local function createLoggerFunction(level: number, outputFunction: (string) -> ())
	local function logLevel(self: Logger, ...: unknown): LoggerMessage
		local message: LoggerMessage = {
			when = os.time(),
			logger = self,
			level = level,
			args = table.pack(...),
		}
		table.insert(self.messages, message)
		if self.maxLevel or maxLevel() >= maxLevel() then
			outputFunction(formatMessage(message))
		end
		return message
	end
	return logLevel
end

local logTrace = createLoggerFunction(LogLevel.Trace, print)
local logDebug = createLoggerFunction(LogLevel.Debug, print)
local logInfo = createLoggerFunction(LogLevel.Info, print)
local logWarn = createLoggerFunction(LogLevel.Warn, warn)
local logError = createLoggerFunction(LogLevel.Error, function(msg)
	task.spawn(error, msg, 0)
end)

local function logAssert<T>(self: Logger, value: T, ...: unknown)
	if value then
		return value
	end
	local message: LoggerMessage = {
		when = os.time(),
		logger = self,
		level = LogLevel.Error,
		args = table.pack(if select("#", ...) > 0 then ... else `Cannot assert {value} is truthy`),
	}
	table.insert(self.messages, message)
	error(formatMessage(message))
end

local function new(name: string, maxLevel: number?): Logger
	return {
		name = name,
		messages = {},
		maxLevel = maxLevel,

		trace = logTrace,
		debug = logDebug,
		info = logInfo,
		warn = logWarn,
		error = logError,

		assert = logAssert,
	}
end

return table.freeze({
	LogLevel = LogLevel,
	LOG_LEVEL_TO_EMOJI = LOG_LEVEL_TO_EMOJI,
	maxLevel = maxLevel,
	setDefaultMaxLevel = setDefaultMaxLevel,
	setMaxLevelForThread = setMaxLevelForThread,
	formatMessage = formatMessage,
	new = new,
})
