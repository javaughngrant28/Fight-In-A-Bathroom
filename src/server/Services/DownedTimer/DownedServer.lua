local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MaidModule = require(ReplicatedStorage.Shared.Libraries.Maid)
local Downed = require(game.ServerScriptService.Modules.Downed)


local DURATION = 4

local DownedServer = {}
DownedServer.__index = DownedServer

export type DownedServerInterface = typeof(setmetatable({} :: {
    _MAID: MaidModule.Maid,
    MODEL: Model,
}, DownedServer))

function DownedServer.new(character: Model): DownedServerInterface
    local self = setmetatable({
        _MAID = MaidModule.new(),
        MODEL = character,
    }, DownedServer)
    
    self:TimerStart()

    return self
end

function DownedServer.TimerStart(self: DownedServerInterface)
    task.wait(DURATION)
    Downed.Diabled(self.MODEL)
end

function DownedServer.Destroy(self: DownedServerInterface)
    self._MAID:Destroy()
    for index, _ in pairs(self) do
        self[index] = nil
    end
end

return DownedServer