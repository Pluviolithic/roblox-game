local ReplicatedStorage = game:GetService "ReplicatedStorage"

local Net = require(ReplicatedStorage.Common.lib.Net)
local t = require(ReplicatedStorage.Common.lib.t)

local Remotes = Net.CreateDefinitions {
	GetState = Net.Definitions.ServerFunction {
		Net.Middleware.RateLimit {
			MaxRequestsPerMinute = 60,
		},
	},
	SendRoduxAction = Net.Definitions.ServerToClientEvent(),
}

return Remotes
