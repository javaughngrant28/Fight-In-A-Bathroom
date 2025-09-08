
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)


local Character = {}
Character.__index = Character

export type CharacterInterface = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    MODEL: Model,
}, Character))

function Character.new(model: Model): CharacterInterface
    local self = setmetatable({
        _MAID = MaidModule.new(),
        MODEL = model,
    }, Character)
    
    self:Spawn()

    return self
end

function Character.Spawn(self: CharacterInterface)
    self.MODEL:SetAttribute(StateEnum.ATTRIBUTE_NAME,StateEnum.None)
end



function Character.Destroy(self: CharacterInterface)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return Character
