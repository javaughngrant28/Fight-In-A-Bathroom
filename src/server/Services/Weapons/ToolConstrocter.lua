
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)


local ToolController = {}
ToolController.__index = ToolController


export type ToolControllerType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    NAME: string,
    TYPE: string,
    INSTANCE: Tool,
    EVENT: RemoteEvent,
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

function ToolController.OnEquipped(self: ToolControllerType, callBack: (value: boolean)-> ())
    local tool = self.INSTANCE

    local function FireCallback(value: boolean)
        callBack(value)
    end

    self._MAID['AncestryChanged'] = tool.AncestryChanged:Connect(function(_, parent)
        if not parent or parent == nil then
            FireCallback(false)
        end

        if parent:IsA('Model') then
            FireCallback(true)
            else
                FireCallback(false)
        end 
    end)

    FireCallback(false)
end

function ToolController.Destroy(self: ToolControllerType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return ToolController
