
local Players = game:GetService("Players")

local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)

local InventoryState = require(script.Parent.InventoryState)
local PlayerDataAPI = require(game.ServerScriptService.Services.Data.PlayerDataAPI)
local WeaponData = require(game.ReplicatedStorage.Shared.Data.WeaponData)
local InventoryHelper = require(script.Parent.InventoryHelper)


local MAX_EQUIP_AMOUNT = 5


local function EquipWeapon(player: Player,WeaponName: string)
    
end

local function onPlayerDataLoaded(player: Player)
    local inventoryData = PlayerDataAPI.GetInvetoryData(player)

    InventoryState[player] = {
        EquippedCount = 0,
        Items = inventoryData
    }

    for WeaponName, value in inventoryData.Weapons do
        if value.Equipped and InventoryState[player] 
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