
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)

local Melee = {}
Melee.__index = Melee

export type MeleeType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    -- Add class fields here
}, Melee))

function Melee.new(player: Player): MeleeType
    local self = setmetatable({
        _MAID = MaidModule.new(),
        -- Initialize fields here
    }, Melee)
    
    return self
end

function Melee.Destroy(self: MeleeType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return Melee