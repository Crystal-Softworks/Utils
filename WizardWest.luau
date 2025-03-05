-- Kill existing aimlock scripts
if getgenv().AimlockRunning then
    getgenv().AimlockRunning:Disconnect()
end

-- Global flag to prevent duplicate execution
getgenv().AimlockRunning = game:GetService("RunService").RenderStepped:Connect(function() end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = game:GetService("Workspace").CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local Aimlock = false
local Target = nil
local Highlight = Instance.new("Highlight")
Highlight.FillColor = Color3.new(1, 0, 0)
Highlight.OutlineColor = Color3.new(1, 0, 0)
Highlight.FillTransparency = 0.5
Highlight.OutlineTransparency = 0

local function IsVisible(target)
    local origin = Camera.CFrame.Position
    local direction = (target.Position - origin).unit * (target.Position - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = Workspace:Raycast(origin, direction, raycastParams)
    return result == nil or result.Instance:IsDescendantOf(target.Parent)
end

local function IsValidPlayer(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local player = Players:GetPlayerFromCharacter(model)
    if player then
        if player == LocalPlayer then return false end
        local teamName = LocalPlayer.Team and LocalPlayer.Team.Name
        local targetTeam = player.Team and player.Team.Name
        if teamName == "Shadow Wizards" then
            return true
        elseif teamName == "Royal Wizards" or teamName == "Wizards" then
            return targetTeam == "Shadow Wizards"
        else
            return targetTeam and targetTeam ~= teamName
        end
    else
        return true
    end
end

local function GetNearestTarget()
    local closestTarget = nil
    local closestDistance = math.huge

    local function CheckModels(folder)
        if folder then
            for _, model in pairs(folder:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and IsValidPlayer(model) then
                    local root = model:FindFirstChild("HumanoidRootPart")
                    if root and IsVisible(root) then
                        local distance = (root.Position - Camera.CFrame.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestTarget = root
                        end
                    end
                end
            end
        end
    end

    CheckModels(Workspace:FindFirstChild("Characters"))
    
    local MissionsFolder = Workspace:FindFirstChild("Missions")
    if MissionsFolder then
        for _, missionModel in pairs(MissionsFolder:GetChildren()) do
            if missionModel:IsA("Model") then
                local AISpawners = missionModel:FindFirstChild("AISpawners")
                if AISpawners then
                    CheckModels(AISpawners)
                end
            end
        end
    end
    
    local SpiderCave = Workspace:FindFirstChild("MapProps") and Workspace.MapProps:FindFirstChild("SpiderCave")
    if SpiderCave then
        for _, spawner in pairs(SpiderCave:GetChildren()) do
            if spawner:IsA("BasePart") and (spawner.Name == "AISpawnerCave" or spawner.Name == "AISpawnerCaveDeep") then
                for _, enemyModel in pairs(spawner:GetChildren()) do
                    if enemyModel:IsA("Model") and enemyModel:FindFirstChildOfClass("Humanoid") and IsValidPlayer(enemyModel) then
                        local root = enemyModel:FindFirstChild("HumanoidRootPart")
                        if root and IsVisible(root) then
                            local distance = (root.Position - Camera.CFrame.Position).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestTarget = root
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestTarget
end

local function AdjustAimForDistance(target)
    if not target then return Camera.CFrame end
    local distance = (target.Position - Camera.CFrame.Position).Magnitude
    local dropCompensation = distance * 0.03
    local aimPosition = target.Position - Vector3.new(0, dropCompensation + 1.25, 0)
    return CFrame.new(Camera.CFrame.Position, aimPosition)
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.E then
        Aimlock = not Aimlock
        if Aimlock then
            Target = GetNearestTarget()
            if Target then
                Highlight.Parent = Target.Parent
            end
        else
            Target = nil
            Highlight.Parent = nil
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        mouse1click()
    end
end)

RunService.RenderStepped:Connect(function()
    if Aimlock and Target then
        Camera.CFrame = AdjustAimForDistance(Target)
    end
end)

for i, v in next, LocalPlayer.Backpack:GetChildren() do
    if v:IsA("Tool") and v:FindFirstChild("PistolConfig") then
        v.PistolConfig:SetAttribute("Recoil", Vector3.new(0, 0, 0))
    end
end

for i, v in next, LocalPlayer.Character:GetChildren() do
    if v:IsA("Tool") and v:FindFirstChild("PistolConfig") then
        v.PistolConfig:SetAttribute("Recoil", Vector3.new(0, 0, 0))
    end
end

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Crystal-Softworks/Utils/refs/heads/main/WizardWest.luau'))()")

warn("[ CLIENT ] : Script Loaded!")
