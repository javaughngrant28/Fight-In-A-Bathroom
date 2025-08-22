local PlayerDataTemplate = require(game.ServerScriptService.Services.Data.PlayerDataTemplate)


local function GetEquippedWeaponCount(data: PlayerDataTemplate.InventoryType)
    local count = 0

	for _, weaponData in data.Weapons do
		if weaponData.Equipped then
			count += 1
		end
	end

	return count
end

return {
    GetEquippedWeaponCount = GetEquippedWeaponCount,
}