local Players = game:GetService "Players"
local StarterPlayer = game:GetService "StarterPlayer"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.producer)

local player = Players.LocalPlayer

require(StarterPlayer.StarterPlayerScripts.Client.reflexReceiver)

local function selectMoney(state: producer.RootState)
	return state.stats[player.Name].Money
end

producer:subscribe(selectMoney, function(money)
	print("Money:", money)
end)
