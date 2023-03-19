--- The Logger.
-- @classmod Logger
Log4g.Core.Logger = Log4g.Core.Logger or {}
local Logger = include("log4g/core/impl/MiddleClass.lua")("Logger")
local CreateLoggerConfig = Log4g.Core.Config.LoggerConfig.Create
local GetCtx = Log4g.Core.LoggerContext.Get
local QualifyName = Log4g.Util.QualifyName
local istable = istable

local PRIVATE = PRIVATE or setmetatable({}, {
    __mode = "k"
})

function Logger:Initialize(name, context, level)
    PRIVATE[self] = {}
    PRIVATE[self].ctx = context.name
    PRIVATE[self].lc = name
    self.name = name
    context:GetConfiguration():AddLogger(name, CreateLoggerConfig(name, context:GetConfiguration(), level))
end

--- Get the LoggerConfig of the Logger.
-- @return object loggerconfig
function Logger:GetLoggerConfig()
    local lc = GetCtx(PRIVATE[self].ctx):GetConfiguration():GetLoggerConfig(PRIVATE[self].lc)
    if lc then return lc end
end

function Log4g.Core.Logger.Create(name, context, level)
    if not istable(context) then return end
    if context:HasLogger(name) or not QualifyName(name) then return end
    context:GetLoggers()[name] = Logger(name, context, level)
end