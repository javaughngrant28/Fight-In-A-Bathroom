
local State = require(script.Parent.State)
local FacingBehind = require(script.Parent.FackingBehind)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local Player = require(script.Parent.Player)

local MAX_BLOCK_HEALTH = 3
local BLOCK_DAMGE = 1
local BLOCK_HEALTH_ATTRIBUTE_NAME = 'BlockHealth'


local function GetBlackHealth(character: Model): number
    local value = character:GetAttribute(BLOCK_HEALTH_ATTRIBUTE_NAME)
    if value then
        return value
        else
            character:SetAttribute(BLOCK_HEALTH_ATTRIBUTE_NAME,MAX_BLOCK_HEALTH)
            return MAX_BLOCK_HEALTH
    end
end

local function SetBlackHealth(character: Model, amount: number)
    if not character then return end
    local amount = math.clamp(amount,0,MAX_BLOCK_HEALTH)
    character:SetAttribute(BLOCK_HEALTH_ATTRIBUTE_NAME,amount)
end

local function ActivateBlock(character: Model)
    local BlockHealth = GetBlackHealth(character)
    if BlockHealth <= 0 then return end
    if State.Get(character) ~= State.Enum.None then return end
    
    State.Set(character,State.Enum.Blocking)
end

local function DeactivateBlock(character: Model)
    if State.Get(character) ~= State.Enum.Blocking then return end
    State.Set(character,State.Enum.None)
    
    if GetBlackHealth(character) > 0 then
        SetBlackHealth(character,MAX_BLOCK_HEALTH)
    end
end

local function BlockCooldown(character: Model)
    local player: Player? = Player.Get(character)
    if not player then return end

    player:SetAttribute(CombatCooldowns.Block.ATTRIBUTE_NAME,true)

    task.delay(CombatCooldowns.Block.DURATION,function()
        SetBlackHealth(character,MAX_BLOCK_HEALTH)
        player:SetAttribute(CombatCooldowns.Block.ATTRIBUTE_NAME,false)
    end)
end

local function AttackBlocked(character: Model)
    local BlockHealth = GetBlackHealth(character)
    SetBlackHealth(character,BlockHealth - BLOCK_DAMGE)

    if GetBlackHealth(character) == 0 then
        DeactivateBlock(character)
        BlockCooldown(character)
    end
end

local function CheckForAttackBlocking(characterAttacking: Model, characterDefending: Model): boolean
    if State.Get(characterDefending) ~= State.Enum.Blocking then
        return false
    end
    
    if FacingBehind.Fire(characterAttacking,characterDefending) then
        return false
    end

    AttackBlocked(characterDefending)

    return true
end



return {
    BlockCheck = CheckForAttackBlocking,
    Activate = ActivateBlock,
    Deactivate = DeactivateBlock,
}