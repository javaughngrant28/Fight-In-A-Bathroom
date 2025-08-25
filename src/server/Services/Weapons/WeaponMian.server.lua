
local WeaponData = require(game.ReplicatedStorage.Shared.Data.WeaponData)
local WeaponAPI = require(script.Parent.WeaponAPI)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local Range = require(script.Parent.Range)
local Melee = require(script.Parent.Melee)

local Maid: MaidModule.Maid = MaidModule.new()


local CreateSignal = WeaponAPI._GetCreateSignal()
local DestroySignal = WeaponAPI._GetDestroySignal()


local function Create(player: Player, weaponName: string)
    local data = WeaponData[weaponName]
    assert(data,`{player} {weaponName} No Found In Weapon Data`)

    if data.Type == "Melee" then
        Maid[player.Name..weaponName] = Melee.new(player,weaponName,data)
        else
            Maid[player.Name..weaponName] = Range.new(player,weaponName,data)
    end
end

local function Destroy(playerName: string, weaponName: string)
    Maid[playerName..weaponName] = nil
end


CreateSignal:Connect(Create)
DestroySignal:Connect(Destroy)


