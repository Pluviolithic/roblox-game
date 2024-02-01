local Players = game:GetService "Players"
local StarterPlayer = game:GetService "StarterPlayer"

local producer = require(StarterPlayer.StarterPlayerScripts.Client.producer)

local player = Players.LocalPlayer

local function selectPlayerStatsById(state: producer.RootState)
	return state.stats
end

local function getPlayerId(_, index: string)
	return index
end

local function selectMoney(state: producer.RootState)
	return state.stats[player.Name].Money
end

producer:observe(selectPlayerStatsById, getPlayerId, function()
	print "player added"
	producer:subscribe(selectMoney, function(money)
		print("Money:", money)
	end)
	return function()
		print "player removed"
	end
end)

require(StarterPlayer.StarterPlayerScripts.Client.reflexReceiver)
