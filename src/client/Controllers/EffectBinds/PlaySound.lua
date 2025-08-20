
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)

local SoundFolder = ReplicatedStorage.Assets.Sounds


local PlaySound = {}
PlaySound.__index = PlaySound

export type PlaySoundType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,

    SOUND_NAME: string,
    PART: string,

}, PlaySound))

function PlaySound.new(part: Part): PlaySoundType
    local self = setmetatable({
        _MAID = MaidModule.new(),

        SOUND_NAME = part:GetAttribute('SoundName'),
        PART = part,

    }, PlaySound)
    
    self:Fire()

    return self
end

function PlaySound.Fire(self: PlaySoundType)
    local SoundName = self.SOUND_NAME
    local sound = SoundFolder:FindFirstChild(SoundName,true) :: Sound
    
    assert(sound,`{SoundName} Sound Not Found In Sound Folder`)
    local soundClone: Sound = sound:Clone()

    soundClone.Parent = self.PART
    soundClone:Play()
end

function PlaySound.Destroy(self: PlaySoundType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return PlaySound