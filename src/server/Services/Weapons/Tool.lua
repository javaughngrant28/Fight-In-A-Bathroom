
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WeaponData = require(game.ReplicatedStorage.Shared.Data.WeaponData)
local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)

local tool = Instance.new('Tool')
tool.RequiresHandle = false
tool.CanBeDropped = false

local AnimationFolder = Instance.new('Folder')
AnimationFolder.Name = 'Animations'
AnimationFolder.Parent = tool

local EventFolder = Instance.new('Folder')
EventFolder.Name = 'Events'
EventFolder.Parent = tool



local ToolControcter = {}
ToolControcter.__index = ToolControcter

ToolControcter.EQUIPPED = false

export type ToolControcterType = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    EQUIPPED: boolean,
    PLAYER: Player,
    TOOL: Tool,
}, ToolControcter))



function ToolControcter.new(player: Player, weaponName: string, weaponType: string): ToolControcterType
    local self = setmetatable({
        _MAID = MaidModule.new(),
        PLAYER = player,
        TOOL = tool:Clone()
    }, ToolControcter)

    self._MAID['Tool'] = self.TOOL
    self.TOOL.Name = weaponName

    self:ListenForAncestryChange()

    if weaponType == "Melee" then
        self:LoadMeleeEvents()
        else
            self:LoadRangedEvnets()
    end


    
    return self
end

function ToolControcter.LoadCustomAnimations()
    
end

function ToolControcter.LoadMeleeEvents(self: ToolControcterType)
    local events: Folder = self.TOOL.Events

    local punchEvent = Instance.new('RemoteEvent')
    punchEvent.Name = 'Punch'
    punchEvent.Parent = events

    local weaveEvent = Instance.new('RemoteEvent')
    weaveEvent.Name = 'Weave'
    weaveEvent.Parent = events

    local grabEvent = Instance.new('RemoteEvent')
    grabEvent.Name = 'Grab'
    grabEvent.Parent = events

    local kickEvent = Instance.new('RemoteEvent')
    kickEvent.Name = 'Kick'
    kickEvent.Parent = events

    local blockEvent = Instance.new('RemoteEvent')
    blockEvent.Name = 'Block'
    blockEvent.Parent = events
end

function ToolControcter.LoadRangedEvnets(self: ToolControcterType)
    local events: Folder = self.TOOL.Events

    local throwEvent = Instance.new('RemoteEvent')
    throwEvent.Name = 'Punch'
    throwEvent.Parent = events
end

function ToolControcter.ListenForAncestryChange(self: ToolControcterType)
    self._MAID['AncestryChanged'] = self.TOOL.AncestryChanged:Connect(function(_, parent: Instance)
        local Character: Model = self.PLAYER.Character

        if not parent then self.EQUIPPED = false return end
        if not Character then self.EQUIPPED = false return end

        if parent == Character then
            self.EQUIPPED = true
            else
                self.EQUIPPED = false
        end
    end)
end

function ToolControcter.Destroy(self: ToolControcterType)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return ToolControcter