local Players = game:GetService "Players"
local StarterPlayer = game:GetService "StarterPlayer"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.producer)

local player = Players.LocalPlayer

local function playerExists(state: producer.RootState)
	return state.stats[player.Name]
end

local function selectMoney(state: producer.RootState)
	if state.stats[player.Name] then
		return state.stats[player.Name].Money
	else
		return 0
	end
end

producer:subscribe(selectMoney, function(money)
	print("Money:", money)
end)

require(StarterPlayer.StarterPlayerScripts.Client.reflexReceiver)
