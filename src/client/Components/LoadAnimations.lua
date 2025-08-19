local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local AnimationLoader = {}
AnimationLoader.__index = AnimationLoader

export type AnimationLoaderType = typeof(setmetatable({} :: {
    CHARACTR_CONNECTION: RBXScriptConnection,
    ANIMATIONS : {Animation},
    ANIMATIONTRACKS: {AnimationTrack?}

}, AnimationLoader))


local function LoadAnimations(character: Model, animations: {Animation}): {AnimationTrack}
    local animationTracks = {}

    local Humanoid = character:WaitForChild('Humanoid',30) :: Humanoid
    if not Humanoid then warn(`{character} Has No Humanoid`) return end

    local Animator = Humanoid:FindFirstChildWhichIsA('Animator') :: Animator
     if not Animator then warn(`{character} Has No Animator`) return end


    for index, value: Animation in pairs(animations) do
        local track = Animator:LoadAnimation(value)
        animationTracks[index] = track
    end

    return animationTracks
end

function AnimationLoader.new(animations: {Animation}): AnimationLoaderType
    local self = setmetatable({
        ANIMATIONS = animations,
        ANIMATIONTRACKS = {},

    }, AnimationLoader)

    self:_CharacterAddedConenction()
    
    return self
end

function AnimationLoader._CharacterAddedConenction(self: AnimationLoaderType)
    local function UpdateAnimationTracks(character: Model)
        if not character then warn(`Character Model Is Nil`) return end
        self.ANIMATIONTRACKS = {}
        self.ANIMATIONTRACKS = LoadAnimations(character,self.ANIMATIONS)
    end
    
    self.CHARACTR_CONNECTION = LocalPlayer.CharacterAdded:Connect(UpdateAnimationTracks)
    if  LocalPlayer.Character then
        UpdateAnimationTracks(LocalPlayer.Character)
    end
end


function AnimationLoader.Destroy(self: AnimationLoaderType)
    self.CHARACTR_CONNECTION:Disconnect()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return AnimationLoader