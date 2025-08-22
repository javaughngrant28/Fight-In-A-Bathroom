
local PlayerDataTemplate = require(game.ServerScriptService.Services.Data.PlayerDataTemplate)

type IsEquipped = boolean
type WeaponName = string

type StateType = {
    EquippedCount: number,
    Items: PlayerDataTemplate.WeaponType,
}

type InventoryStateType = {
    [Player]: StateType
}

local InventoryState: InventoryStateType = {}


return InventoryState