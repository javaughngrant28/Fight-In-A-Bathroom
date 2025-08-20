
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local Observers = require(game.ReplicatedStorage.Shared.Libraries.Observers)



local PunchConnector = {}
PunchConnector.__index = PunchConnector

export type PunchConnectorType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,

    PLAYER: Player,
    CHARACTER: Model?,
    HUMANOID: Humanoid?,

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

function PunchConnector.Fire(self: PunchConnectorType, target: Model)
    if not self.CHARACTER then return end
    if self.HUMANOID.Health <= 0 then return end

    print(target)
end

function PunchConnector.Destroy(self: PunchConnectorType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return PunchConnector

