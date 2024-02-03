local Players = game:GetService "Players"
local ReplicatedStorage = game:GetService "ReplicatedStorage"
local ServerScriptService = game:GetService "ServerScriptService"

local Lapis = require(ServerScriptService.Server.lib.lapis)
local producer = require(ServerScriptService.Server.producer)
local defaultPlayerSaveData = require(ReplicatedStorage.Common.defaultPlayerSaveData)

local documents = {}
local collection = Lapis.createCollection("PlayerData", {
	defaultData = defaultPlayerSaveData.data,
	validate = defaultPlayerSaveData.validate,
})

local function onPlayerAdded(player: Player)
	collection
		:load(`Player_{player.UserId}`, { player.UserId })
		:andThen(function(document)
			if player.Parent then
				documents[player.Name] = document
				producer.addPlayerData(player.Name, document:read())
			else
				document:close():catch(warn)
			end
		end)
		:catch(function(message)
			warn(`Player {player.Name}'s data failed to load: {message}`)
			player:Kick "Data failed to load."
		end)
end

local function OnPlayerRemoving(player: Player)
	local document = documents[player.Name]
	if document ~= nil then
		documents[player.Name] = nil
		document:close():catch(warn)
	end
	producer.removePlayerData(player.Name)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(OnPlayerRemoving)

for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

return documents
