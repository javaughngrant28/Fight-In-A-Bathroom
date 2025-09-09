
local ToolDetectore = require(script.Parent.Parent.Parent.Modules.ToolDetectore)
local WeaponEnum = require(game.ReplicatedStorage.Shared.Data.Weapons.WeaponEnum)
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)
local Throttle = require(game.ReplicatedStorage.Shared.Libraries.Throttle)
local CombatCooldowns = require(game.ReplicatedStorage.Shared.Data.Combat.CombatCooldowns)
local CombatEnum = require(game.ReplicatedStorage.Shared.Data.Combat.CombatEnum)

local Maid: MaidModule.Maid = MaidModule.new()
local INDEX = CombatEnum.Throw

local function onToolActivaed(event: RemoteEvent)
    event:FireServer(INDEX)
end

local function ValidateTool(tool: Tool)
    assert(tool:FindFirstChildWhichIsA('RemoteEvent'),`{tool} Has No Remote Event`)
    assert(tool:FindFirstChildWhichIsA('Model'),`{tool} Has No Model To Throw`)
end

ToolDetectore.AddedSignal:Connect(function(tool: Tool)
    local toolType = tool:GetAttribute('Type')
    if toolType ~= WeaponEnum.Types.Range then return end

    ValidateTool(tool)
    local event = tool:FindFirstChildWhichIsA('RemoteEvent')
    
    Maid[tool.Name] = tool.Activated:Connect(function()
        Throttle('Throw',CombatCooldowns.Throw,onToolActivaed,tool,event)
    end)    
end)

