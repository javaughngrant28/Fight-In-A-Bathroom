
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local WeaponTypes = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponTypes)
local ToolConstrocter = require(script.Parent.ToolConstrocter)

local Weapon = {}
Weapon.__index = Weapon

export type WeaponInterface = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    PLAYER: Player,
    WEAPON_DATA: WeaponTypes.Data,
    WEAPON_NAME: string,
    TOOL: ToolConstrocter.ToolControllerType, 
}, Weapon))

function Weapon.new(player: Player, weaponName: string, weaponData: WeaponTypes.Data): WeaponInterface
    local self = setmetatable({
        _MAID = MaidModule.new(),
        PLAYER = player,
        WEAPON_NAME = weaponName,
        WEAPON_DATA = weaponData,
        TOOL = ToolConstrocter.new(weaponName,weaponData.Type)
    }, Weapon)

     self._MAID['Tool'] = self.TOOL

    self.TOOL.INSTANCE.Parent = player.Backpack
    return self
end


function Weapon.Destroy(self: WeaponInterface)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return Weapon

