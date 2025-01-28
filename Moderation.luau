if game.CoreGui:FindFirstChild("ModerationMenu") then game.CoreGui.ModerationMenu:Destroy() end
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ModerationMenu") then game.Players.LocalPlayer.PlayerGui.ModerationMenu:Destroy() end

if not game:IsLoaded() then

	game.Loaded:Wait()

end

local MainModeration = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Next = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Gradient = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Button = Instance.new("TextButton")
local Text = Instance.new("TextLabel")
local Back = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Gradient_2 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local Button_2 = Instance.new("TextButton")
local Text_2 = Instance.new("TextLabel")
local Exit = Instance.new("Frame")
local SHop = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local Gradient_3 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local Button_3 = Instance.new("TextButton")
local Text_3 = Instance.new("TextLabel")
local UICorner_9 = Instance.new("UICorner")
local User = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local Gradient_4 = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local Button_4 = Instance.new("TextButton")
local Profile = Instance.new("ImageLabel")
local DisplayName = Instance.new("TextLabel")
local Gradient_5 = Instance.new("Frame")
local Username = Instance.new("TextLabel")

local function AddGradient(thing)

	local new = Instance.new("UIGradient")
	new.Rotation = 90
	new.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))})
	new.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.95, 0), NumberSequenceKeypoint.new(1, 0.5, 0)})
	new.Parent = thing

end

function Hover(Frame)
	local TweenService = game:GetService("TweenService")

	local function AddStroke()
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Thickness = 1.5
		UIStroke.Transparency = 1
		UIStroke.Color = Color3.new(1, 1, 1)
		UIStroke.Parent = Frame

		local Info = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
		local Properties = { Transparency = 0 }
		TweenService:Create(UIStroke, Info, Properties):Play()
	end

	local function RemoveStroke()
		local UIStroke = Frame:FindFirstChildOfClass("UIStroke")
		if UIStroke then
			local Info = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
			local Properties = { Transparency = 1 }
			local Tween = TweenService:Create(UIStroke, Info, Properties)
			Tween:Play()

			Tween.Completed:Connect(function()
				UIStroke:Destroy()
			end)
		end
	end

	Frame.MouseEnter:Connect(function()
		AddStroke()
	end)

	Frame.MouseLeave:Connect(function()
		RemoveStroke()
	end)
end



-- Properties

MainModeration.Name = "MainModeration"
MainModeration.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainModeration.ZIndexBehavior = Enum.ZIndexBehavior.Global

Main.Name = "Main"
Main.Parent = MainModeration
Main.BackgroundColor3 = Color3.new(1, 1, 1)
Main.BackgroundTransparency = 1
Main.BorderColor3 = Color3.new(0, 0, 0)
Main.BorderSizePixel = 0
Main.Size = UDim2.new(1, 0, 1, 0)

Next.Name = "Next"
Next.Parent = Main
Next.BackgroundColor3 = Color3.new(0.168627, 0.972549, 0.443137)
Next.BorderColor3 = Color3.new(0, 0, 0)
Next.BorderSizePixel = 0
Next.Position = UDim2.new(0.5950463601, 0, 0.044926092, 0)
Next.Size = UDim2.new(0, 100, 0, 40)
Next.ZIndex = 8

Hover(Next)

UICorner.Parent = Next
UICorner.CornerRadius = UDim.new(0, 6)

Gradient.Name = "Gradient"
Gradient.Parent = Next
Gradient.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient.BorderColor3 = Color3.new(0, 0, 0)
Gradient.BorderSizePixel = 0
Gradient.Size = UDim2.new(1, 0, 1, 0)
Gradient.ZIndex = 8
AddGradient(Gradient)

SHop.Name = "SHop"
SHop.Parent = Main
SHop.BackgroundColor3 = Color3.new(0.168627, 0.972549, 0.443137)
SHop.BorderColor3 = Color3.new(0, 0, 0)
SHop.BorderSizePixel = 0
SHop.Position = UDim2.new(0.5950463601, 0, 0.116684591, 0)
SHop.Size = UDim2.new(0, 100, 0, 40)
SHop.ZIndex = 8

Hover(SHop)

UICorner_9.Parent = SHop
UICorner_9.CornerRadius = UDim.new(0, 6)

Gradient_5.Name = "Gradient"
Gradient_5.Parent = SHop
Gradient_5.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient_5.BorderColor3 = Color3.new(0, 0, 0)
Gradient_5.BorderSizePixel = 0
Gradient_5.Size = UDim2.new(1, 0, 1, 0)
Gradient_5.ZIndex = 8
AddGradient(Gradient_5)

local UICorner_10 = Instance.new("UICorner")

UICorner_10.Parent = Gradient_5
UICorner_10.CornerRadius = UDim.new(0, 6)

local Text_4 = Instance.new("TextLabel")

Text_4.Name = "Text"
Text_4.Parent = SHop
Text_4.BackgroundColor3 = Color3.new(1, 1, 1)
Text_4.BackgroundTransparency = 1
Text_4.BorderColor3 = Color3.new(0, 0, 0)
Text_4.BorderSizePixel = 0
Text_4.Size = UDim2.new(1, 0, 1, 0)
Text_4.ZIndex = 8
Text_4.Font = Enum.Font.SourceSansBold
Text_4.Text = "Server Hop"
Text_4.TextColor3 = Color3.new(1, 1, 1)
Text_4.TextSize = 20
Text_4.TextTransparency = 0.05000000074505806
Text_4.TextWrapped = true

local Button_6 = Instance.new("TextButton")

Button_6.Name = "Button"
Button_6.Parent = SHop
Button_6.BackgroundColor3 = Color3.new(1, 1, 1)
Button_6.BackgroundTransparency = 1
Button_6.BorderColor3 = Color3.new(0, 0, 0)
Button_6.BorderSizePixel = 0
Button_6.Size = UDim2.new(1, 0, 1, 0)
Button_6.ZIndex = 9
Button_6.AutoButtonColor = false
Button_6.Font = Enum.Font.SourceSans
Button_6.Text = ""
Button_6.TextColor3 = Color3.new(0, 0, 0)
Button_6.TextSize = 1
Button_6.TextTransparency = 1

UICorner_2.Parent = Gradient
UICorner_2.CornerRadius = UDim.new(0, 6)

Button.Name = "Button"
Button.Parent = Next
Button.BackgroundColor3 = Color3.new(1, 1, 1)
Button.BackgroundTransparency = 1
Button.BorderColor3 = Color3.new(0, 0, 0)
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 1, 0)
Button.ZIndex = 9
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.new(0, 0, 0)
Button.TextSize = 1
Button.TextTransparency = 1

Text.Name = "Text"
Text.Parent = Next
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(1, 0, 1, 0)
Text.ZIndex = 8
Text.Font = Enum.Font.SourceSansBold
Text.Text = "Next"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 25
Text.TextTransparency = 0.05000000074505806
Text.TextWrapped = true

Back.Name = "Back"
Back.Parent = Main
Back.BackgroundColor3 = Color3.new(0.737255, 0.12549, 0.133333)
Back.BorderColor3 = Color3.new(0, 0, 0)
Back.BorderSizePixel = 0
Back.Position = UDim2.new(0.3380000007, 0, 0.0460000001, 0)
Back.Size = UDim2.new(0, 100, 0, 40)
Back.ZIndex = 8
Hover(Back)

UICorner_3.Parent = Back
UICorner_3.CornerRadius = UDim.new(0, 6)

Gradient_2.Name = "Gradient"
Gradient_2.Parent = Back
Gradient_2.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient_2.BorderColor3 = Color3.new(0, 0, 0)
Gradient_2.BorderSizePixel = 0
Gradient_2.Size = UDim2.new(1, 0, 1, 0)
Gradient_2.ZIndex = 8
AddGradient(Gradient_2)

UICorner_4.Parent = Gradient_2
UICorner_4.CornerRadius = UDim.new(0, 6)

Button_2.Name = "Button"
Button_2.Parent = Back
Button_2.BackgroundColor3 = Color3.new(1, 1, 1)
Button_2.BackgroundTransparency = 1
Button_2.BorderColor3 = Color3.new(0, 0, 0)
Button_2.BorderSizePixel = 0
Button_2.Size = UDim2.new(1, 0, 1, 0)
Button_2.ZIndex = 9
Button_2.AutoButtonColor = false
Button_2.Font = Enum.Font.SourceSans
Button_2.Text = ""
Button_2.TextColor3 = Color3.new(0, 0, 0)
Button_2.TextSize = 1
Button_2.TextTransparency = 1

Text_2.Name = "Text"
Text_2.Parent = Back
Text_2.BackgroundColor3 = Color3.new(1, 1, 1)
Text_2.BackgroundTransparency = 1
Text_2.BorderColor3 = Color3.new(0, 0, 0)
Text_2.BorderSizePixel = 0
Text_2.Size = UDim2.new(1, 0, 1, 0)
Text_2.ZIndex = 8
Text_2.Font = Enum.Font.SourceSansBold
Text_2.Text = "Back"
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextSize = 25
Text_2.TextTransparency = 0.05000000074505806
Text_2.TextWrapped = true

Exit.Name = "Exit"
Exit.Parent = Main
Exit.BackgroundColor3 = Color3.new(0.737255, 0.12549, 0.133333)
Exit.BorderColor3 = Color3.new(0, 0, 0)
Exit.BorderSizePixel = 0
Exit.Position = UDim2.new(0.3380000007, 0, 0.116684591, 0)
Exit.Size = UDim2.new(0, 100, 0, 40)
Exit.ZIndex = 8
Hover(Exit)

UICorner_5.Parent = Exit
UICorner_5.CornerRadius = UDim.new(0, 6)

Gradient_3.Name = "Gradient"
Gradient_3.Parent = Exit
Gradient_3.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient_3.BorderColor3 = Color3.new(0, 0, 0)
Gradient_3.BorderSizePixel = 0
Gradient_3.Size = UDim2.new(1, 0, 1, 0)
Gradient_3.ZIndex = 8
AddGradient(Gradient_3)

UICorner_6.Parent = Gradient_3
UICorner_6.CornerRadius = UDim.new(0, 6)

Button_3.Name = "Button"
Button_3.Parent = Exit
Button_3.BackgroundColor3 = Color3.new(1, 1, 1)
Button_3.BackgroundTransparency = 1
Button_3.BorderColor3 = Color3.new(0, 0, 0)
Button_3.BorderSizePixel = 0
Button_3.Size = UDim2.new(1, 0, 1, 0)
Button_3.ZIndex = 9
Button_3.AutoButtonColor = false
Button_3.Font = Enum.Font.SourceSans
Button_3.Text = ""
Button_3.TextColor3 = Color3.new(0, 0, 0)
Button_3.TextSize = 1
Button_3.TextTransparency = 1

Text_3.Name = "Text"
Text_3.Parent = Exit
Text_3.BackgroundColor3 = Color3.new(1, 1, 1)
Text_3.BackgroundTransparency = 1
Text_3.BorderColor3 = Color3.new(0, 0, 0)
Text_3.BorderSizePixel = 0
Text_3.Size = UDim2.new(1, 0, 1, 0)
Text_3.ZIndex = 8
Text_3.Font = Enum.Font.SourceSansBold
Text_3.Text = "Exit"
Text_3.TextColor3 = Color3.new(1, 1, 1)
Text_3.TextSize = 25
Text_3.TextTransparency = 0.05000000074505806
Text_3.TextWrapped = true

User.Name = "User"
User.Parent = Main
User.BackgroundColor3 = Color3.new(0.764706, 0.203922, 0.87451)
User.BorderColor3 = Color3.new(0, 0, 0)
User.BorderSizePixel = 0
User.Position = UDim2.new(0.40128762, 0, 0.0459999889, 0)
User.Size = UDim2.new(0, 350, 0, 105)
User.ZIndex = 8

local TextLabel = Instance.new("TextLabel")

-- Properties

TextLabel.Parent = User
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = Color3.new(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.331428558, 0, 0.219047621, 0)
TextLabel.Size = UDim2.new(0, 67, 0, 23)
TextLabel.ZIndex = 9
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Viewing"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextSize = 18
TextLabel.TextTransparency = 0.05
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom

UICorner_7.Parent = User
UICorner_7.CornerRadius = UDim.new(0, 6)

Gradient_4.Name = "Gradient"
Gradient_4.Parent = User
Gradient_4.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient_4.BorderColor3 = Color3.new(0, 0, 0)
Gradient_4.BorderSizePixel = 0
Gradient_4.Size = UDim2.new(1, 0, 1, 0)
Gradient_4.ZIndex = 8
AddGradient(Gradient_4)

UICorner_8.Parent = Gradient_4
UICorner_8.CornerRadius = UDim.new(0, 6)

Button_4.Name = "Button"
Button_4.Parent = User
Button_4.BackgroundColor3 = Color3.new(1, 1, 1)
Button_4.BackgroundTransparency = 1
Button_4.BorderColor3 = Color3.new(0, 0, 0)
Button_4.BorderSizePixel = 0
Button_4.Size = UDim2.new(1, 0, 1, 0)
Button_4.ZIndex = 9
Button_4.AutoButtonColor = false
Button_4.Font = Enum.Font.SourceSans
Button_4.Text = ""
Button_4.TextColor3 = Color3.new(0, 0, 0)
Button_4.TextSize = 1
Button_4.TextTransparency = 1

Profile.Name = "Profile"
Profile.Parent = User
Profile.BackgroundColor3 = Color3.new(1, 1, 1)
Profile.BackgroundTransparency = 1
Profile.BorderColor3 = Color3.new(0, 0, 0)
Profile.BorderSizePixel = 0
Profile.Position = UDim2.new(0.0257142857, 0, 0.0666666701, 0)
Profile.Size = UDim2.new(0, 90, 0, 90)
Profile.ZIndex = 9
Profile.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

DisplayName.Name = "DisplayName"
DisplayName.Parent = User
DisplayName.BackgroundColor3 = Color3.new(1, 1, 1)
DisplayName.BackgroundTransparency = 1
DisplayName.BorderColor3 = Color3.new(0, 0, 0)
DisplayName.BorderSizePixel = 0
DisplayName.Position = UDim2.new(0.331428498, 0, 0.439252883, 0)
DisplayName.Size = UDim2.new(0, 111, 0, 34)
DisplayName.ZIndex = 9
DisplayName.Font = Enum.Font.SourceSansBold
DisplayName.Text = "DISPLAY NAME"
DisplayName.TextColor3 = Color3.new(1, 1, 1)
DisplayName.TextSize = 20
DisplayName.TextXAlignment = Enum.TextXAlignment.Left

Username.Name = "Username"
Username.Parent = User
Username.BackgroundColor3 = Color3.new(1, 1, 1)
Username.BackgroundTransparency = 1
Username.BorderColor3 = Color3.new(0, 0, 0)
Username.BorderSizePixel = 0
Username.Position = UDim2.new(0.331428558, 0, 0.620205224, 0)
Username.Size = UDim2.new(0, 185, 0, 31)
Username.ZIndex = 9
Username.Font = Enum.Font.SourceSansSemibold
Username.Text = "@Username"
Username.TextColor3 = Color3.new(1, 1, 1)
Username.TextSize = 19
Username.TextXAlignment = Enum.TextXAlignment.Left

local Ban = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Gradient = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Button = Instance.new("TextButton")
local Text = Instance.new("TextLabel")
local Reason = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Gradient_2 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local Button_2 = Instance.new("TextButton")
local Text_2 = Instance.new("TextBox")

-- Properties

Ban.Name = "Ban"
Ban.Parent = Main
Ban.BackgroundColor3 = Color3.new(0.737255, 0.12549, 0.133333)
Ban.BorderColor3 = Color3.new(0, 0, 0)
Ban.BorderSizePixel = 0
Ban.Position = UDim2.new(0.405, 0, 0.17, 0)
Ban.Size = UDim2.new(0, 180, 0, 40)
Ban.ZIndex = 8
Hover(Ban)

UICorner.Parent = Ban
UICorner.CornerRadius = UDim.new(0, 6)

Gradient.Name = "Gradient"
Gradient.Parent = Ban
Gradient.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient.BorderColor3 = Color3.new(0, 0, 0)
Gradient.BorderSizePixel = 0
Gradient.Size = UDim2.new(1, 0, 1, 0)
Gradient.ZIndex = 8

AddGradient(Gradient)

UICorner_2.Parent = Gradient
UICorner_2.CornerRadius = UDim.new(0, 6)

Button.Name = "Button"
Button.Parent = Ban
Button.BackgroundColor3 = Color3.new(1, 1, 1)
Button.BackgroundTransparency = 1
Button.BorderColor3 = Color3.new(0, 0, 0)
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 1, 0)
Button.ZIndex = 9
Button.AutoButtonColor = false
Button.Font = Enum.Font.SourceSans
Button.Text = ""
Button.TextColor3 = Color3.new(0, 0, 0)
Button.TextSize = 1
Button.TextTransparency = 1

Text.Name = "Text"
Text.Parent = Ban
Text.BackgroundColor3 = Color3.new(1, 1, 1)
Text.BackgroundTransparency = 1
Text.BorderColor3 = Color3.new(0, 0, 0)
Text.BorderSizePixel = 0
Text.Size = UDim2.new(1, 0, 1, 0)
Text.ZIndex = 8
Text.Font = Enum.Font.SourceSansBold
Text.Text = "Ban"
Text.TextColor3 = Color3.new(1, 1, 1)
Text.TextSize = 25
Text.TextTransparency = 0.05000000074505806
Text.TextWrapped = true

Reason.Name = "Reason"
Reason.Parent = Main
Reason.BackgroundColor3 = Color3.new(0.764706, 0.203922, 0.87451)
Reason.BorderColor3 = Color3.new(0, 0, 0)
Reason.BorderSizePixel = 0
Reason.Position = UDim2.new(0.517, 0, 0.17, 0)
Reason.Size = UDim2.new(0, 115, 0, 40)
Reason.ZIndex = 8
Hover(Reason)

UICorner_3.Parent = Reason
UICorner_3.CornerRadius = UDim.new(0, 6)

Gradient_2.Name = "Gradient"
Gradient_2.Parent = Reason
Gradient_2.BackgroundColor3 = Color3.new(1, 1, 1)
Gradient_2.BorderColor3 = Color3.new(0, 0, 0)
Gradient_2.BorderSizePixel = 0
Gradient_2.Size = UDim2.new(1, 0, 1, 0)
Gradient_2.ZIndex = 8
AddGradient(Gradient_2)

UICorner_4.Parent = Gradient_2
UICorner_4.CornerRadius = UDim.new(0, 6)

Button_2.Name = "Button"
Button_2.Parent = Reason
Button_2.BackgroundColor3 = Color3.new(1, 1, 1)
Button_2.BackgroundTransparency = 1
Button_2.BorderColor3 = Color3.new(0, 0, 0)
Button_2.BorderSizePixel = 0
Button_2.Size = UDim2.new(1, 0, 1, 0)
Button_2.ZIndex = 9
Button_2.AutoButtonColor = false
Button_2.Font = Enum.Font.SourceSans
Button_2.Text = ""
Button_2.TextColor3 = Color3.new(0, 0, 0)
Button_2.TextSize = 1
Button_2.TextTransparency = 1

Text_2.Name = "Text"
Text_2.Parent = Reason
Text_2.BackgroundColor3 = Color3.new(1, 1, 1)
Text_2.BackgroundTransparency = 1
Text_2.BorderColor3 = Color3.new(0, 0, 0)
Text_2.BorderSizePixel = 0
Text_2.Position = UDim2.new(0.121739127, 0, 0, 0)
Text_2.Size = UDim2.new(0, 101, 0, 40)
Text_2.ZIndex = 9
Text_2.Font = Enum.Font.SourceSansSemibold
Text_2.PlaceholderColor3 = Color3.new(0.901961, 0.901961, 0.901961)
Text_2.PlaceholderText = "Reason..."
Text_2.Text = ""
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextSize = 16
Text_2.TextXAlignment = Enum.TextXAlignment.Left



local TweenService = game:GetService("TweenService")

local Notifications = Instance.new("Frame")
Notifications.Name = "Notifications"
Notifications.Parent = Main
Notifications.BackgroundTransparency = 1
Notifications.Position = UDim2.new(0, 0, 0.81155777, 0)
Notifications.Size = UDim2.new(0, 218, 0, 150)

local Icons = {

	wrench = "rbxassetid://10747383470",
	moderate = "rbxassetid://10723395896"

}

local function CreateNotification(title, description, icon, duration)
	local Notification = Instance.new("Frame")
	local Gradient = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UICorner_2 = Instance.new("UICorner")
	local Icon = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local Description = Instance.new("TextLabel")

	Notification.Name = "Notification"
	Notification.Parent = Notifications
	Notification.BackgroundColor3 = Color3.new(0.737255, 0.12549, 0.133333)
	Notification.BorderSizePixel = 0
	Notification.Size = UDim2.new(0, 209, 0, 80)
	Notification.Position = UDim2.new(-1, 0, 0, 0)

	Gradient.Name = "Gradient"
	Gradient.Parent = Notification
	Gradient.Size = UDim2.new(1, 0, 1, 0)
	UICorner.Parent = Gradient
	UICorner.CornerRadius = UDim.new(0, 6)
	AddGradient(Gradient)

	UICorner_2.Parent = Notification
	UICorner_2.CornerRadius = UDim.new(0, 6)

	Icon.Name = "Icon"
	Icon.Parent = Notification
	Icon.BackgroundTransparency = 1
	Icon.Position = UDim2.new(0.07, 0, 0.18, 0)
	Icon.Size = UDim2.new(0, 50, 0, 50)
	Icon.Image = icon

	Title.Name = "Title"
	Title.Parent = Notification
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0.4, 0, 0.23, 0)
	Title.Size = UDim2.new(0, 95, 0, 11)
	Title.Font = Enum.Font.SourceSansBold
	Title.Text = title
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.TextSize = 22
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Description.Name = "Description"
	Description.Parent = Notification
	Description.BackgroundTransparency = 1
	Description.Position = UDim2.new(0.4, 0, 0.47, 0)
	Description.Size = UDim2.new(0, 107, 0, 34)
	Description.Font = Enum.Font.SourceSansSemibold
	Description.Text = description
	Description.TextColor3 = Color3.new(1, 1, 1)
	Description.TextSize = 16
	Description.TextWrapped = true
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.TextYAlignment = Enum.TextYAlignment.Top

	local slideInTween = TweenService:Create(
		Notification,
		TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0, 40, 0, 0) } -- Position in view
	)
	slideInTween:Play()

	task.delay(duration or 5, function()
		local slideOutTween = TweenService:Create(
			Notification,
			TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{ Position = UDim2.new(-1, 0, 0, 0) }
		)
		slideOutTween:Play()
		slideOutTween.Completed:Connect(function()
			Notification:Destroy()
		end)
	end)
end

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local JobId = game.JobId
local userIds = {}
local currentIndex = 1

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

local function spectateUser(userId)
	--print("Called")
	local camera = workspace.CurrentCamera
	--print("Camera:", camera)
	local player = Players:GetPlayerByUserId(userId)

	--print("2")
	if player and player.Character then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			--print("Set")
			camera.CameraSubject = humanoid
		else
			camera.CameraSubject = nil
			--warn("Humanoid not found in the player's character!")
		end
	else
		camera.CameraSubject = nil
		--warn("Player or character is invalid!")
	end
end


local function updateUserProfile()
	local userId = userIds[currentIndex]
	if not userId then return end

	--print("Spectate")
	spectateUser(userId)

	local successThumbnail, thumbnailUrl = pcall(function()
		return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	end)
	if successThumbnail then
		Profile.Image = thumbnailUrl
	else
		Profile.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end

	local successName, username = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if successName then
		Username.Text = "@" .. username
		local player = Players:GetPlayerByUserId(userId)
		if player then
			DisplayName.Text = player.DisplayName
		else
			DisplayName.Text = "Display Name Unavailable"
		end
	else
		Username.Text = "@UnknownUser"
		DisplayName.Text = "Display Name Unavailable"
	end
end

local function onPlayerAdded(player)
	table.insert(userIds, player.UserId)
	if #userIds == 1 then
		--currentIndex = 1
		--updateUserProfile()
	end
end

local function onPlayerRemoving(player)
	for i, userId in ipairs(userIds) do
		if userId == player.UserId then
			table.remove(userIds, i)
			if currentIndex > #userIds then
				currentIndex = #userIds
			end
			--updateUserProfile()
			break
		end
	end
end

Next.Button.MouseButton1Click:Connect(function()
	if #userIds > 0 then
		currentIndex = currentIndex + 1
		if currentIndex > #userIds then
			currentIndex = 1
		end
		updateUserProfile()
	end
end)

SHop.Button.MouseButton1Click:Connect(function()
	serverHop()
end)

Back.Button.MouseButton1Click:Connect(function()
	if #userIds > 0 then
		currentIndex = currentIndex - 1
		if currentIndex < 1 then
			currentIndex = #userIds
		end
		updateUserProfile()
	end
end)

Exit.Button.MouseButton1Click:Connect(function()
	for i,v in next, game.CoreGui:GetChildren() do
		if v.Name == "MainModeration" then
			v:Destroy()
		end
	end
	local player = Players.LocalPlayer
	if player then
		currentIndex = table.find(userIds, player.UserId) or 1
		updateUserProfile()
	end
end)

Ban.Button.MouseButton1Click:Connect(function()
	local function RemoveAtSymbol(inputString)
		return string.gsub(inputString, "@", "")
	end

	CreateNotification("Ban Request", "Request Sent For: "..RemoveAtSymbol(User.Username.Text), Icons.moderate, 2)
	
	--ban user with reason Reason.Text.Text
end)

for _, player in ipairs(Players:GetPlayers()) do
	table.insert(userIds, player.UserId)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

repeat task.wait()

	if #userIds > 0 then
		currentIndex = 1
		updateUserProfile()
	end

until game:IsLoaded() == true

warn("[ Survival Odyssey Moderation ] : Loaded!")
CreateNotification("Loaded!", "Moderation Pannel Loaded!", Icons.wrench, 2)
