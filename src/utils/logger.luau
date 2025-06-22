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
	max_level: number?,

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

local default_max_level = LogLevel.Trace
local max_level_per_thread: { [thread]: number } = setmetatable({} :: any, { __mode = "k" })

local function max_level()
	return max_level_per_thread[coroutine.running()] or default_max_level
end

local function set_default_max_level(level: number)
	default_max_level = level
end

local function set_max_level_for_thread(level: number?, thread: thread?)
	local thread = thread or coroutine.running()
	max_level_per_thread[thread] = level :: any
end

local function format_message(message: LoggerMessage): string
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

local function create_logger_function(level: number, output: (string) -> ())
	local function logLevel(self: Logger, ...: unknown): LoggerMessage
		local message: LoggerMessage = {
			when = os.time(),
			logger = self,
			level = level,
			args = table.pack(...),
		}
		table.insert(self.messages, message)
		if self.max_level or max_level() >= max_level() then
			output(format_message(message))
		end
		return message
	end
	return logLevel
end

local log_trace = create_logger_function(LogLevel.Trace, print)
local log_debug = create_logger_function(LogLevel.Debug, print)
local log_info = create_logger_function(LogLevel.Info, print)
local log_warn = create_logger_function(LogLevel.Warn, warn)
local log_error = create_logger_function(LogLevel.Error, function(msg)
	task.spawn(error, msg, 0)
end)

local function log_assert<T>(self: Logger, value: T, ...: unknown)
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
	error(format_message(message))
end

local function create(name: string, max_level: number?): Logger
	return {
		name = name,
		messages = {},
		max_level = max_level,

		trace = log_trace,
		debug = log_debug,
		info = log_info,
		warn = log_warn,
		error = log_error,

		assert = log_assert,
	}
end

return table.freeze({
	LogLevel = LogLevel,
	LOG_LEVEL_TO_EMOJI = LOG_LEVEL_TO_EMOJI,
	max_level = max_level,
	set_default_max_level = set_default_max_level,
	set_max_level_for_thread = set_max_level_for_thread,
	format_message = format_message,
	create = create,
})
