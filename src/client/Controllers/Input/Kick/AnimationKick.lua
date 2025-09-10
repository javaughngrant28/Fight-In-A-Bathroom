

local LoadAnimations = require(script.Parent.Parent.Parent.Parent.Components.LoadAnimations)
local ToolDetectore = require(script.Parent.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local Maid: MaidModule.Maid = MaidModule.new()
local KickAnimationTracks: {AnimationTrack}


local function UpdateAnimation(animation: Animation)
    local loadAnimations = LoadAnimations.new({animation})
    Maid['LoadedAnimations'] = loadAnimations
    KickAnimationTracks = loadAnimations.ANIMATIONTRACKS
end

ToolDetectore.EquippedSignal:Connect(function(tool: Tool)
    local toolType = tool:GetAttribute('Type')
    if toolType ~= WeaponEnum.Types.Melee then return end
    
    local Animation = tool:FindFirstChild('Kick',true)
    assert(Animation,`{tool} Has No Kick Animation`)

    UpdateAnimation(Animation)
end)


local function PlayAnimation()
    KickAnimationTracks[1]:Play()
end

return {
    Play = PlayAnimation,
}