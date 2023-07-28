--
-- Main
--
-- Initialize SellVehicleEventExtended
--
-- Copyright (c) Peppie84, 2023
-- https://github.com/Peppie84/FS22_DepositAndRepairCostsForLeasing
--
---@type string directory of the mod.
local modDirectory = g_currentModDirectory or ''
---@type string name of the mod.
local modName = g_currentModName or 'unknown'

source(modDirectory .. 'src/SellVehicleEventExtended.lua')

---Mission00 is loading
---@param mission table (Mission00)
local function preLoad(mission)
    SellVehicleEvent.run = Utils.overwrittenFunction(SellVehicleEvent.run, SellVehicleEventExtended.run)
end

--- Initialize the mod
local function init()
    Mission00.load = Utils.prependedFunction(Mission00.load, preLoad)
end

init()
