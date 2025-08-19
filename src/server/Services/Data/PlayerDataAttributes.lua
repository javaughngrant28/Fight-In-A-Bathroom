
local PlayerProfiles = require(script.Parent.PlayerProfiles)


export type Attribues = {
	Coins: number,
	XboxKeybind: string,
	PCKeybind: string,
	Loaded: boolean,
}

local function CreateAttributes(player: Player)
	local Data = PlayerProfiles[player].Data
	player:SetAttribute('Coins', Data.Coins)
	player:SetAttribute('XboxKeybind',Data.Keybinds.Punch.Xbox)
	player:SetAttribute('PCKeybind',Data.Keybinds.Punch.PC)
	player:SetAttribute('MouseKeybind',Data.Keybinds.MosueLock.Xbox)
	player:SetAttribute('Loaded',true)
end

local function GetAttribues(player: Player): Attribues
	return player:GetAttributes()
end

return {
	Create = CreateAttributes,
	Update = CreateAttributes,
	Get = GetAttribues,
}