local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local slices = require(ReplicatedStorage.Common.slices)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)
local producer = require(ServerScriptService.Server.producer)

local start = require(ReplicatedStorage.Common.RedEvents.start):Server()
local dispatch = require(ReplicatedStorage.Common.RedEvents.dispatch):Server()

local sharedActions = {}

for _, slice in slices do
	for actionName in slice:getActions() do
		sharedActions[actionName] = true
	end
end

local broadcaster = Reflex.createBroadcaster {
	producers = slices,
	dispatch = function(player, actions)
		dispatch:Fire(player, actions)
	end,
	beforeDispatch = function(player, action)
		if not sharedActions[action.name] or action.arguments[1] ~= player.Name then
			return
		end
		return action
	end,
	beforeHydrate = function(player, state)
		local newState = {}
		for sliceName, sliceState in state do
			if slices[sliceName] then
				newState[sliceName] = {
					[player.Name] = sliceState[player.Name],
				}
			end
		end
		return newState
	end,
}

start:On(function(player)
	broadcaster:start(player)
end)

producer:applyMiddleware(broadcaster.middleware)

return 0
