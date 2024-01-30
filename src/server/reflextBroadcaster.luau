local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local slices = require(ReplicatedStorage.Common.slices)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)
local producer = require(ServerScriptService.Server.producer)

local start = require(ReplicatedStorage.Common.RedEvents.start):Server()
local dispatch = require(ReplicatedStorage.Common.RedEvents.dispatch):Server()

local broadcaster = Reflex.createBroadcaster {
	producers = slices,
	dispatch = function(player, actions)
		dispatch:Fire(player, actions)
	end,
}

start:On(function(player)
	broadcaster:start(player)
end)

producer:applyMiddleware(broadcaster.middleware)
