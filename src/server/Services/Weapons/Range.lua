

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)

local Rang = {}
Rang.__index = Rang

export type RangType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    -- Add class fields here
}, Rang))

function Rang.new(player: Player): RangType
    local self = setmetatable({
        _MAID = MaidModule.new(),
        -- Initialize fields here
    }, Rang)
    
    return self
end

function Rang.Destroy(self: RangType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return Rang