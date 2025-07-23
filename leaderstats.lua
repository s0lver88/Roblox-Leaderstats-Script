--VARIABLES--
local dataStoreService = game:GetService("DataStoreService")
local savePlayerStats = dataStoreService:GetDataStore("SaveLeaderstats")

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = player
	leaderstats.Name  =  "leaderstats"
	
	local coins = Instance.new("IntValue")
	coins.Parent = leaderstats
	coins.Name = "Your Current"
	
	local success, result = pcall(function()
		return savePlayerStats:GetAsync(player.UserId)
	end)
	
	if success and result then
		coins.Value = result
	elseif success and not result then
		coins.Value = 750
	else
		print("ERROR LOADING PLAYER STATS")
		coins.Value = 750
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats:FindFirstChild("Your Currency")
	
	local success, errors = pcall(function()
		savePlayerStats:SetAsync(player.UserId, coins.Value)
	end)
	
	if success then
		print(player.Name.. " Stats were saved correctly !")
	end
end)
