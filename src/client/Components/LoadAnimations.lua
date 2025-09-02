local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AnimationLoader = {}
AnimationLoader.__index = AnimationLoader

export type AnimationLoaderType = typeof(setmetatable({} :: {
    CHARACTER_CONNECTION: RBXScriptConnection,
    ANIMATIONS : {Animation},
    ANIMATIONTRACKS: {AnimationTrack?},
    ANIMATION_CONNECTIONS: {RBXScriptConnection}
}, AnimationLoader))

local function LoadAnimations(character: Model, animations: {Animation}): {AnimationTrack}
    local animationTracks = {}
    local Humanoid = character:FindFirstChildOfClass('Humanoid') :: Humanoid
    if not Humanoid then 
        warn(`{character.Name} has no Humanoid`) 
        return animationTracks 
    end
    
    local Animator = Humanoid:FindFirstChildWhichIsA('Animator') :: Animator
    if not Animator then 
        warn(`{character.Name} has no Animator`) 
        return animationTracks 
    end
    
    for index, animation: Animation in pairs(animations) do
        local track = Animator:LoadAnimation(animation)
        animationTracks[index] = track
    end
    
    return animationTracks
end

function AnimationLoader.new(animations: {Animation}): AnimationLoaderType
    local self = setmetatable({
        ANIMATIONS = animations,
        ANIMATIONTRACKS = {},
        ANIMATION_CONNECTIONS = {},
        CHARACTER_CONNECTION = nil
    }, AnimationLoader)
    
    self:_CharacterAddedConnection()
    return self
end

function AnimationLoader:_CharacterAddedConnection()
    local function UpdateAnimationTracks(character: Model)
        if not character then 
            warn("Character Model is nil") 
            return 
        end
        
        -- Clean up old tracks and connections
        self.ANIMATIONTRACKS = {}
        for _, conn in pairs(self.ANIMATION_CONNECTIONS) do
            if conn then
                conn:Disconnect()
            end
        end
        self.ANIMATION_CONNECTIONS = {}
        
        -- Load animations
        self.ANIMATIONTRACKS = LoadAnimations(character, self.ANIMATIONS)
        
        -- Listen for AnimationId changes
        for index, anim in pairs(self.ANIMATIONS) do
            local conn = anim:GetPropertyChangedSignal("AnimationId"):Connect(function()
                local humanoid = character:FindFirstChildOfClass("Humanoid") :: Humanoid
                if humanoid then
                    local animator = humanoid:FindFirstChildWhichIsA("Animator") :: Animator
                    if animator then
                        local newTrack = animator:LoadAnimation(anim)
                        self.ANIMATIONTRACKS[index] = newTrack
                    end
                end
            end)
            table.insert(self.ANIMATION_CONNECTIONS, conn)
        end
    end
    
    self.CHARACTER_CONNECTION = LocalPlayer.CharacterAdded:Connect(UpdateAnimationTracks)
    
    if LocalPlayer.Character then
        UpdateAnimationTracks(LocalPlayer.Character)
    end
end

function AnimationLoader:Destroy()
    if self.CHARACTER_CONNECTION then
        self.CHARACTER_CONNECTION:Disconnect()
    end
    
    for _, conn in pairs(self.ANIMATION_CONNECTIONS) do
        if conn then
            conn:Disconnect()
        end
    end
    
    -- Clean up arrays
    table.clear(self.ANIMATIONTRACKS)
    table.clear(self.ANIMATION_CONNECTIONS)
    table.clear(self.ANIMATIONS)
end

return AnimationLoader