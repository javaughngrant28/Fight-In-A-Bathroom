
local PlayerDataTemplate = require(script.Parent.PlayerDataTemplate)

local function GetLeaderstats(player: Player): Folder
	local folder = player:FindFirstChild('leaderstats')
	assert(folder,`{player} Has No Leaderstats Folder`)
	return folder
end

local function CreateLeaderStats(player: Player, Data: PlayerDataTemplate.DataType)
    local folder = Instance.new('Folder')
    folder.Name = 'leaderstats'
    folder.Parent = player

	local Coins = Instance.new('NumberValue')
	Coins.Name = 'Coins'
	Coins.Value = Data.Coins
	Coins.Parent = folder
end

local function SetCoinValue(player: Player, value: number)
	local leaderstats = GetLeaderstats(player)
	local coins = leaderstats:FindFirstChild('Coins') :: NumberValue
	coins.Value = value
end


return {
	Create = CreateLeaderStats,
	SetCoins = SetCoinValue
}