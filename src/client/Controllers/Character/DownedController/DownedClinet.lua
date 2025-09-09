local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerModuleScript = Player:WaitForChild('PlayerScripts'):WaitForChild('PlayerModule')

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local PlayerModule = require(PlayerModuleScript)

local Controls = PlayerModule:GetControls()



local function EnableRagdollState(humanoid: Humanoid)
    if humanoid:GetState() == Enum.HumanoidStateType.Ragdoll then return end
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
    humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
end

local function DisableRagdollState(humanoid: Humanoid)
    if humanoid:GetState() ~= Enum.HumanoidStateType.Ragdoll then return end
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
    humanoid:ChangeState(Enum.HumanoidStateType.Landed)
end


local DownedClient = {}
DownedClient.__index = DownedClient

export type DownedClientInterface = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    CHARACTER: Model
}, DownedClient))

function DownedClient.new(character: Model): DownedClientInterface
    local self = setmetatable({
        _MAID = MaidModule.new(),
        CHARACTER = character,
    }, DownedClient)
    
    self:CharacterDowned()

    return self
end

function DownedClient.SetRagdollState(self: DownedClientInterface ,value: boolean)
    local humanoid = self.CHARACTER:FindFirstChild('Humanoid') :: Humanoid
    if not humanoid or humanoid.Health <= 0 then return end
    if value then
        EnableRagdollState(humanoid)
        else
            DisableRagdollState(humanoid)
    end
end

function DownedClient.CharacterDowned(self: DownedClientInterface)
    if self.CHARACTER ~= Player.Character then return end
    Controls:Disable()
    self:SetRagdollState(true)
end

function DownedClient.Destroy(self: DownedClientInterface)
    Controls:Enable(false)
    self:SetRagdollState(false)

    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return DownedClient