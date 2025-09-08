
local LoadAnimations = require(script.Parent.Parent.Parent.Parent.Components.LoadAnimations)
local ToolDetectore = require(script.Parent.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()
local BlockAnimation: {AnimationTrack}

local function PlayBlockAnimation()
    BlockAnimation[1]:Play()
end

local function StopBlockAnimation()
    BlockAnimation[1]:Stop()
end

local function UpdateAnimations(animations: {Animation})
    local loadedAnimation = LoadAnimations.new(animations)
    Maid['LoadedAnimation'] = loadedAnimation
    BlockAnimation = loadedAnimation.ANIMATIONTRACKS
end

ToolDetectore.EquippedSignal:Connect(function(tool: Tool)
    if tool:GetAttribute('Type') == nil or tool:GetAttribute('Type') ~= WeaponEnum.Types.Melee then return end
    local Animation = tool:FindFirstChild('Block',true)
    if not Animation then warn(`{tool} Has No Block Animation`) return end

    UpdateAnimations({Animation})
end)


return {
    Play = PlayBlockAnimation,
    Stop = StopBlockAnimation,
}