local Players = game:GetService("Players")
local MaidModule = require(game.ReplicatedStorage.Shared.Libraries.Maid)

local player = Players.LocalPlayer

local InputTable = {} ::{
    string: {Fire: (RemoteEvent)->()}
}


local function ConnectToInputAction(Maid: MaidModule.Maid, inputContext: InputAction, remoteEvent: RemoteEvent)
    if not inputContext:IsA('InputAction') then return end
    local InputModule = InputTable[inputContext.Name]
    if not InputModule then warn(`{inputContext.Name} Is Not In InputTable`) return end

    Maid[inputContext.Name] = inputContext.Pressed:Connect(function()
        InputModule.Fire(remoteEvent)
    end)
end

local function GetAllInputActions(Maid: MaidModule.Maid, inputContext: InputContext, remoteEvent: RemoteEvent)
    for _, inputAction in inputContext:GetChildren() do
        ConnectToInputAction(Maid,inputAction,remoteEvent)
    end

    Maid['InputActionAdded'] = inputContext.ChildAdded:Connect(function(child)
        ConnectToInputAction(Maid,child,remoteEvent)
    end)
end


local function DestroyMaidOnAncestryChanged(Maid: MaidModule.Maid, inputContext: InputContext)
     Maid['AncestryChanged'] = inputContext.AncestryChanged:Connect(function(_, parent)
        if not parent or parent == nil then
            Maid:Destroy()
        end
    end)
end

local function InputContextAdded(instance: InputContext)
    if not instance:IsA('InputContext') then return end
    local remoteEvent = instance:FindFirstChildWhichIsA('RemoteEvent')
    assert(remoteEvent,`{instance} Has No Remote Event`)

    local Maid: MaidModule.Maid = MaidModule.new()
    GetAllInputActions(Maid,instance,remoteEvent)
    DestroyMaidOnAncestryChanged(Maid,instance)
end

player.DescendantAdded:Connect(InputContextAdded)

for _, module: ModuleScript in script.Parent:GetChildren() do
    if not module:IsA('ModuleScript') then continue end
    local requiredModule = require(module)
    if requiredModule["Fire"] then 
        InputTable[module.Name] = requiredModule
        else
            warn(`{module} Has No Fire Function`)
    end
end