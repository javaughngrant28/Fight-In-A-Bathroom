
local WeaponAPI = require(script.Parent.WeaponAPI)
local PlayerDataAPI = require(game.ServerScriptService.Services.Data.PlayerDataAPI)
local TableUtil = require(game.ReplicatedStorage.Shared.Utils.TableUtil)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local WeaponData = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponData)
local InventoryAPI = require(game.ServerScriptService.Services.Inventory.InventoryAPI)

local Maid = MaidModule.new()
local Weapon = require(script.Parent.Weapon)

local CreateAllEquippedSignal = WeaponAPI._GetCreateAllEquippedSignal()
local DestroyAllSignal = WeaponAPI._GetDestroyAllSignal()

local function CreateWeapwon(player: Player, weaponName: string)
    local data = WeaponData[weaponName]
    assert(data,`{player} {weaponName}: Weapon Data Not Found`)

    Maid[player.Name..weaponName] = Weapon.new(player,weaponName,data)
end

local function  CreateAllEquippedWeapons(player: Player)
    local InventoryData = PlayerDataAPI.GetInvetoryData(player)
    for weaponName: string, IsEquipped: boolean in InventoryData.Weapons do
        if not IsEquipped then continue end
        CreateWeapwon(player,weaponName)
    end
end

local function DestroyAllWeapons(playerName: string)
    local weaponIndexList = TableUtil.GetIndexListByFilter(playerName,Maid._tasks)
    for _, index: string in weaponIndexList do
        Maid[index] = nil
    end
end


local function DropWeapon(player: Player?, weaponName: string, position: string)
    WeaponData.Get(weaponName)
    if player then
        InventoryAPI.Weapon.Remove(weaponName)
    end
end

WeaponAPI.Drop:Connect(DropWeapon)
CreateAllEquippedSignal:Connect(CreateAllEquippedWeapons)
DestroyAllSignal:Connect(DestroyAllWeapons)
