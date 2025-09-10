
local Binders = require(game.ReplicatedStorage.Shared.Libraries.Binder)
local CharacterStateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local Downed = require(script.Parent.DownedServer)

local Binder = Binders.new(CharacterStateEnum.Downed,Downed)
Binder:Bind()

