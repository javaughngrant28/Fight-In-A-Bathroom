
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local State = require(script.Parent.State)
local Player = require(script.Parent.Player)

local function CharacterAlive(character: Model): boolean
    if not character then return false end

    local humanoid = character:FindFirstChildWhichIsA('Humanoid') :: Humanoid
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end

    return true
end

local function GetCooldownValues(type: string): CombatCooldowns.Values
    local values: CombatCooldowns.Values = CombatCooldowns[type]
    assert(type,`{type} Not Found In Combat Cooldowns`)
    return values
end

local function SetNewState(player: Player,newState: string?)
    if not newState then return end
    if not player.Character then return end
    if State.Get(player.Character) == newState then return end
    State.Set(player.Character,newState)
end

local function StartCooldown(player: Player, humanoid: Humanoid, values: CombatCooldowns.Values, newState: string?)
    local connection: RBXScriptConnection
    player:SetAttribute(values.ATTRIBUTE_NAME,true)

    local Thread = task.delay(CombatCooldowns.Throw.DURATION,function()
        player:SetAttribute(values.ATTRIBUTE_NAME,false)
        connection:Disconnect()
        connection = nil
        SetNewState(player,newState)
    end)

    connection = humanoid.Died:Once(function()
        task.cancel(Thread)
        player:SetAttribute(values.ATTRIBUTE_NAME,false)
        connection:Disconnect()
        connection = nil
        SetNewState(player,newState)
    end)
end


local function RequestCooldown(character: Model, type: string, newState: string?)
    if not CharacterAlive(character) then return end

    local values = GetCooldownValues(type)
    local player = Player.Get(character)
    local humanoid = character:FindFirstChildWhichIsA('Humanoid') :: Humanoid

    if not player then return end
    if not humanoid then return end

    local success, err = pcall(StartCooldown,player,humanoid,values,newState)
    if not success then warn(err) end
end

local function IsCooldownActive(character: Model, type: string): boolean
     local player = Player.Get(character)
     if not player then return false end

    local values = GetCooldownValues(type)
    local Attribute = player:GetAttribute(values.ATTRIBUTE_NAME)

    if not Attribute then return false end
    return true
end

return {
    Start = RequestCooldown,
    Active = IsCooldownActive,
}