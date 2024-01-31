local Players = game:GetService "Players"
local ServerScriptService = game:GetService "ServerScriptService"

local producer = require(ServerScriptService.Server.producer)

require(ServerScriptService.Server.reflextBroadcaster)

Players.PlayerAdded:Connect(function(player)
	producer.addPlayerData(player.Name, {
		stats = {
			Money = 0,
			Gems = 0,
		},
		inventory = {
			thing = 1,
		},
	})

	while true do
		task.wait(10)
		producer.incrementStat(player.Name, "Cash", 5)
	end
end)
