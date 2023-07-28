--
-- SellVehicleEventExtended
--
-- Extend the SellVehicleEvent to add the base cost return and repair costs
--
-- Copyright (c) Peppie84, 2023
-- https://github.com/Peppie84/FS22_ExtendedLeasing
--
SellVehicleEventExtended = {}

---Overwrites the base SellVehicleEvent:run and adds a repair and basecost return
---@param overwrittenFunc function
---@param connection table (Connection)
function SellVehicleEventExtended:run(overwrittenFunc, connection)
    overwrittenFunc(self, connection)

    if not connection:getIsServer() then
        if g_currentMission:getHasPlayerPermission(Farm.PERMISSION.SELL_VEHICLE, connection, self.vehicle:getOwnerFarmId()) then
            local farmId = self.vehicle:getOwnerFarmId()
            local farm = g_farmManager:getFarmById(farmId)

            if self.vehicle.propertyState ~= Vehicle.PROPERTY_STATE_OWNED then
                if farmId ~= nil and farmId ~= FarmManager.SPECTATOR_FARM_ID and farm ~= nil then
                    local vehiclePrice = self.vehicle:getPrice()
                    local depositReturn = vehiclePrice * EconomyManager.DEFAULT_LEASING_DEPOSIT_FACTOR

                    farm:changeBalance(depositReturn, MoneyType.OTHER)
                    g_currentMission:addMoneyChange(depositReturn, farmId, MoneyType.OTHER, true)

                    self.vehicle:repairVehicle(nil)
                end
            end
        end
    end
end
