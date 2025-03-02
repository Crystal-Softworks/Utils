local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local VirtualUser = game:GetService("VirtualUser")

local function onPromptTriggered()
    task.delay(8, function()
        HumanoidRootPart.CFrame = CFrame.new(209.696411, 75.8847351, -381.904602)
        task.delay(1, function()
            VirtualUser:SetKeyDown("0x20")
            task.wait(0.3)
            VirtualUser:SetKeyUp("0x20")
        end)
    end)
end

local function forceInteraction(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        VirtualUser:SetKeyDown("0x65")
        task.wait(0.35)
        VirtualUser:SetKeyUp("0x65")

    end
end

for _, v in next, workspace.Entities:GetChildren() do
    if v.Name == "WagonLoot" and v:FindFirstChild("LootGiver") then
        HumanoidRootPart.CFrame = v.WorldPivot
        v.LootGiver.RequiresLineOfSight = false
        v.LootGiver.Triggered:Connect(onPromptTriggered)
        task.wait(2)
        forceInteraction(v.LootGiver)
    end
end

workspace.Entities.ChildAdded:Connect(function(child)
    if child.Name == "WagonLoot" and child:FindFirstChild("LootGiver") then
        HumanoidRootPart.CFrame = child.WorldPivot
        child.LootGiver.RequiresLineOfSight = false
        child.LootGiver.Triggered:Connect(onPromptTriggered)
        task.wait(2)
        forceInteraction(child.LootGiver)
    end
end)

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

Players.LocalPlayer.OnTeleport:Connect(function(State)
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Crystal-Softworks/Utils/refs/heads/main/Moderation.luau'))()")
end)

httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local function serverHop()
	if httprequest then
		local servers = {}
		local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
		local body = HttpService:JSONDecode(req.Body)

		if body and body.data then
			for _, server in pairs(body.data) do
				if type(server) == "table" and tonumber(server.playing) and tonumber(server.maxPlayers) and server.playing < server.maxPlayers and server.id ~= JobId then
					table.insert(servers, 1, server.id)
				end
			end
		end

		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
		else
			--warn("Couldn't find a server.")
		end
	else
		--warn("Your exploit does not support this command (missing HTTP request)")
	end
end

task.delay(1200, function()

    serverHop()

end)
