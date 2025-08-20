
local Binders = require(game.ReplicatedStorage.Shared.Libraries.Binder)


for _, module: ModuleScript in script.Parent:GetChildren() do
    if not module:IsA('ModuleScript') then continue end

    local class = require(module)
    local Binder = Binders.new(module.Name,class)
    Binder:Bind()
end



