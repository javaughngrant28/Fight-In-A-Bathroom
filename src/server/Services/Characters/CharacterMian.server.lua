local Binders = require(game.ReplicatedStorage.Shared.Libraries.Binder)
local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local WeaponAPI = require(game.ServerScriptService.Services.Weapons.WeaponAPI)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()

local function onCharacterRemoving(player: Player)
	WeaponAPI.DestroyAll(player.Name)
end

local function CharacterDied(character: Model)
	local humanoid = character:FindFirstChildWhichIsA("Humanoid", true) :: Humanoid
	Maid["Died"..character.Name] = humanoid.Died:Once(function()
		onCharacterRemoving(character)
	end)
end

local function onCharacterAdded(player: Player, Character: Model)
	WeaponAPI.CreateAllEquipped(player)

	pcall(CharacterDied,Character)

	return function()
		onCharacterRemoving(player)
	end
end

Observers.observeCharacter(onCharacterAdded)
