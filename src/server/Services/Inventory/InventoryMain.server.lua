
local InventoryAPI = require(script.Parent.InventoryAPI)
local WeaponData = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponData)
local WeaponTypes = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponTypes)
local PlayerDataAPI = require(game.ServerScriptService.Services.Data.PlayerDataAPI)


local function GetWeaponList(player: Player): {string: boolean}
     local inventoryData = PlayerDataAPI.GetInvetoryData(player)
    return inventoryData.Weapons
end

local function RemoveWeapon(player: Player, weaponName: string)
    WeaponData.Get(weaponName)
    local weaponList = GetWeaponList(player)
    
    if weaponList[weaponName] == nil then
        warn(`{player} {weaponName} Not In Invenetory`)
        else
            weaponList[weaponName] = nil
    end
end

local function AddWeapon(player: Player, weaponName: string)
    WeaponData.Get(weaponName)
    local weaponList = GetWeaponList(player)
    
    if weaponList[weaponName] == nil then
        warn(`{player} {weaponName} Already In Not Invenetory`)
        else
            weaponList[weaponName] = false
    end
end



InventoryAPI.Weapon.Add:Connect(AddWeapon)
InventoryAPI.Weapon.Remove:Connect(RemoveWeapon)

