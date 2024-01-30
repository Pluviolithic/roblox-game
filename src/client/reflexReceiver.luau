local StarterPlayer = game:GetService "StarterPlayer"
local ReplicatedStorage = game:GetService "ReplicatedStorage"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.producer)
local Reflex = require(ReplicatedStorage.Common.lib.reflex)

local start = require(ReplicatedStorage.Common.RedEvents.start):Client()
local dispatch = require(ReplicatedStorage.Common.RedEvents.dispatch):Client()

local receiver = Reflex.createBroadcastReceiver {
	start = function()
		start:Fire()
	end,
}

dispatch:On(function(actions)
	receiver:dispatch(actions)
end)

producer:applyMiddleware(receiver.middleware)
