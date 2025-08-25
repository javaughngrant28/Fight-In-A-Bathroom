
local Players = game:GetService("Players")

local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)

local PlayerDataAPI = require(game.ServerScriptService.Services.Data.PlayerDataAPI)
local WeaponAPI = require(game.ServerScriptService.Services.Weapons.WeaponAPI)
local InventoryHelper = require(script.Parent.InventoryHelper)



local MAX_EQUIP_AMOUNT = 5


local function EquipWeapon(player: Player,weaponName: string)
    WeaponAPI.Create(player,weaponName)
end

local function onPlayerDataLoaded(player: Player)
    local inventoryData = PlayerDataAPI.GetInvetoryData(player)
    for weaponName, value in inventoryData.Weapons do
        if value.Equipped then
            EquipWeapon(player,weaponName)
        end
    end
end

local function onPlayerAdded(player: Player)
    local StopAttributeObserver: ()->()

    local function Garud(value: any)
        return typeof(value) =="boolean" and value == true 
    end

    local function CallBack()
        onPlayerDataLoaded(player)
        StopAttributeObserver()
    end

    StopAttributeObserver = Observers.observeAttribute(player,'Loaded',CallBack,Garud)
end



Players.PlayerAdded:Connect(onPlayerAdded)