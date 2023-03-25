--- Initialization of Log4g on server and client.
-- @script Log4g
-- @license Apache License 2.0
-- @copyright GrayWolf64
local Core = "log4g/core/Core.lua"
local API = "log4g/api/API.lua"
local MMC = "log4g/mmc-gui/MMC.lua"
local CoreTest = "log4g/core-test/CoreTest.lua"
file.CreateDir("log4g")

if SERVER then
    --- The global table for the logging system.
    -- It provides easy access to some functions for other components of the logging system that require them.
    -- @table Log4g
    -- @field Core
    -- @field Level
    Log4g = Log4g or {}
    LOG4G_SPACE = " "
    LOG4G_ROOT = "root"
    LOG4G_CONFIGURATION_DEFAULT_NAME = "default"
    LOG4G_CONFIGURATION_DEFAULT_LEVEL = "DEBUG"

    if file.Exists(Core, "lsv") then
        include(Core)
    end

    if file.Exists(API, "lsv") then
        include(API)
    end

    if file.Exists(MMC, "lsv") then
        include(MMC)
        AddCSLuaFile(MMC)
    end

    if file.Exists(CoreTest, "lsv") then
        include(CoreTest)
    end
elseif CLIENT then
    if file.Exists(MMC, "lcl") then
        include(MMC)
    end
end