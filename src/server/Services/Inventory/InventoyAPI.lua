

local Signal = require(game.ReplicatedStorage.Shared.Libraries.Signal)

local CreateWeaponSignal = Signal.new()
local RemoveWeaponSignal = Signal.new()

local API = {}

function API._GetCreateWeaponSignal(): Signal.SignalType
    return CreateWeaponSignal
end

function API._GetRemoveWeaponSignal(): Signal.SignalType
    return RemoveWeaponSignal
end

function API.CreateWeapon(player: Player, weaponName: string)
    CreateWeaponSignal:Fire(player,weaponName)
end

function API.RemoveWeapon(...: any?)
    RemoveWeaponSignal:Fire(...)
end

return API

