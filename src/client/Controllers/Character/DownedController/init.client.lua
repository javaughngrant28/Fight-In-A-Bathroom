
local StateEnum = require(game.ReplicatedStorage.Shared.Data.Character.StateEnum)
local Binders = require(game.ReplicatedStorage.Shared.Libraries.Binder)
local DownedClient = require(script.DownedClinet)

local Binder = Binders.new(StateEnum.Downed,DownedClient)
Binder:Bind()


