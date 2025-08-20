
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)
local GetDistance = require(script.Parent.GetDistance)
local EffectAPI = require(game.ServerScriptService.Services.Effects.EffectAPI)



local PunchConnector = {}
PunchConnector.__index = PunchConnector

PunchConnector.MAX_DISTANCE = 7
PunchConnector.DAMAGE = 5


export type PunchConnectorType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,

    PLAYER: Player,
    CHARACTER: Model?,
    HUMANOID: Humanoid?,
    MAX_DISTANCE: number,
    DAMAGE: number,

    StopCharacterAddedObserver: ()->(),
}, PunchConnector))

function PunchConnector.new(player: Player): PunchConnectorType
    local self = setmetatable({
        _MAID = MaidModule.new(),
       PLAYER = player
    }, PunchConnector)
    
    self:ObserveCharacterAdded()

    return self
end

function PunchConnector.ObserveCharacterAdded(self: PunchConnectorType)
    self.StopCharacterAddedObserver = Observers.observeCharacter(function(playerIndex: Player, character: Model)
        if playerIndex ~= self.PLAYER then return end
        self.CHARACTER = character
        self.HUMANOID = character:FindFirstChild('Humanoid') :: Humanoid
        return function ()
            self.CHARACTER = nil
            self.HUMANOID = nil
        end
    end)
end

function PunchConnector.DealDamage(self: PunchConnectorType, target: Model)
    local targetHumanoid = target:FindFirstChildWhichIsA('Humanoid') :: Humanoid
    targetHumanoid:TakeDamage(self.DAMAGE)
end


function PunchConnector.Fire(self: PunchConnectorType, target: Model)
    if not self.CHARACTER then return end
    local targetRootPart = target:FindFirstChild('HumanoidRootPart') or target.PrimaryPart :: BasePart
    
    local Distance = GetDistance.BetweenModels(self.CHARACTER,target)
    if Distance > self.MAX_DISTANCE then return end
    if self.HUMANOID.Health <= 0 then return end

    self:DealDamage(target)
    EffectAPI.Create('Hit',targetRootPart.CFrame.Position)
end

function PunchConnector.Destroy(self: PunchConnectorType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return PunchConnector

