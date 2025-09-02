
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)

local ToolController = {}
ToolController.__index = ToolController

export type ToolControllerType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    NAME: string,
    TYPE: string,
    INSTANCE: Tool,
}, ToolController))

function ToolController.new(name: string, type: string): ToolControllerType
    local self = setmetatable({
        _MAID = MaidModule.new(),
        NAME = name,
        TYPE = type,
    }, ToolController)
    
    self:_CreatInstance()

    return self
end

function ToolController._CreatInstance(self: ToolControllerType)
    local Tool = Instance.new('Tool')
    Tool.Name = self.NAME
    Tool.RequiresHandle = false

    self._MAID['Tool'] = Tool
    self.INSTANCE = Tool
end

function ToolController.Destroy(self: ToolControllerType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return ToolController
