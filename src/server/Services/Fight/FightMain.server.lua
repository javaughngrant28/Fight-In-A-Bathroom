local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local FightAttributes = require(script.Parent.FightAttributes)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local PunchConnector = require(script.Parent.PunchConnector)

local Maid: MaidModule.Maid = MaidModule.new()
local FightEvents = ReplicatedStorage.Events.Fight


local function CombatAttributeToggle(player: Player, value: boolean)
    if value then
        Maid[player.Name..'PunchConnector'] = PunchConnector.new(player)
    else
        Maid[player.Name..'PunchConnector'] = nil
    end
end

local function Punch(player: Player,target: Model)
    local punchConnector: PunchConnector.PunchConnectorType = Maid[player.Name..'PunchConnector']
    if not punchConnector then return end
    punchConnector:Fire(target)
end

local function onPlayeradded(player: Player)
    FightAttributes.Create(player)

    local StopCombatAttributeObserver = Observers.observeAttribute(player,'CombatEnabled',function(value)
        CombatAttributeToggle(player,value)
    end)

    return function ()
        StopCombatAttributeObserver()
    end
end

FightEvents.Punch.OnServerEvent:Connect(Punch)
Observers.observePlayer(onPlayeradded)
