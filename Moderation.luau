task.wait(3)

local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and self.Name == "UseBagItem" and args[1] == "Hack" then
        return
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

warn("[ CLIENT ] : ' Anti-Cheat has been bypassed. '")

task.wait(5)

local IndexMT; IndexMT = function(self, index)
	self[index] = setmetatable({}, {
		__index = IndexMT
	})
	return self[index]
end

local Services = setmetatable({}, {
	__index = function(self, index)
		return game:GetService(index)
	end,
})

---[[Services]]---

local Players = Services.Players
local RunService = Services.RunService
local TweenService = Services.TweenService
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()



---[[Utility]]---

local Utility = setmetatable({}, {
	__index = IndexMT
})

local Library = setmetatable({}, {
	__index = Utility
})

local Connections = setmetatable({}, {
	__index = IndexMT
})

Library.Flags = {}

function Utility:Create(Object, Parent, Properties)
	local Object = Instance.new(Object, Parent)
	for Property, Value in next, Properties or {} do
		Object[Property] = Value
	end
	return Object
end

function Utility:GetPlayers(IncludeClient)
	local PlayerList = {}
	for Index, Plr in next, Players do
		if Plr ~= Player then
			PlayerList[Index] = tostring(Plr)
		end
	end

	if IncludeClient then
		PlayerList[#PlayerList + 1] = tostring(Player)
	end

	return PlayerList
end

function Utility:Tween(Object, Duration, Properties, ...)
	local Tween = TweenService:Create(Object, TweenInfo.new(Duration, ...), Properties):Play()
	return Tween
end

--[[Functions]]

local Functions = setmetatable({}, {
	__index = Utility
})

function Functions:Drag(Hold, Frame)
	Hold = Hold or Frame

	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		Utility:Tween(Frame, .1, { Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) })
	end

	Hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	Services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function Functions:SetState(Object, Default, Callback)

	if Library.Flags[Object].Debounce then
		return
	end

	Library.Flags[Object].Debounce = not Library.Flags[Object].Debounce

	Utility:Tween(Object.Inner, .2, {

		BackgroundColor3 = ( not Library.Flags[Object].State and Color3.fromRGB(82, 146, 236)) or Color3.fromRGB(50,50,51)

	})

	Utility:Tween(Object.Inner.Circle, .2, {

		Position = ( not Library.Flags[Object].State and UDim2.new(0.49, 0, 0.135, 0)) or UDim2.new(0, 3, 0.135, 0),

	})

	task.wait(0.2)

	Library.Flags[Object].Debounce = not Library.Flags[Object].Debounce
	Library.Flags[Object].State = not Library.Flags[Object].State

	Callback(Library.Flags[Object].State)

end

---[[Library]]---

function Library:Init(Title, TitleIcon)
	
	if Player.PlayerGui:FindFirstChild(Title) then
		error("[ CLIENT ] : ERROR - Already Running")
		return
	end

	local Aurora = self:Create("ScreenGui", game.Players.LocalPlayer.PlayerGui, {

		Name            = Title,
		ZIndexBehavior  = Enum.ZIndexBehavior.Global,
		ResetOnSpawn    = false

	})
	
	local Main = self:Create("ImageLabel", Aurora, {

		Name                   = "Main",
		BackgroundColor3       = Color3.fromRGB(26, 26, 26),
		BackgroundTransparency = 0.025,
		AnchorPoint            = Vector2.new(0.5, 0.5),
		Position               = UDim2.new(0.5, 0, 0.5, 0),
		Size                   = UDim2.new(0, 452, 0, 375),
		ZIndex                 = 1,

	})

	local MainC = self:Create("UICorner", Main, {

		Name         = "MainC",
		CornerRadius = UDim.new(0,6)

	})

	local MainS = self:Create("UIStroke", Main, {

		Name            = "MainS",
		Color           = Color3.fromRGB(124, 124, 124),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode    = Enum.LineJoinMode.Round,
		Thickness       = 1.2,
		Transparency    = 0.4

	})

	local Title = self:Create("TextLabel", Main, {

		Name                   = "Title",
		Text                   = Title,
		BackgroundTransparency = 1,
		Position               = UDim2.new(0.075, 0, 0.019, 0),
		Size                   = UDim2.new(0, 200, 0, 30),
		Font                   = Enum.Font.SourceSansSemibold,
		TextSize               = 20,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextColor3             = Color3.fromRGB(255,255,255),
		ZIndex                 = 2

	})

	local TitleIcon = self:Create("ImageLabel", Main, {

		Name                   = "TitleIcon",
		Image                  = "rbxassetid://10734966248",
		BackgroundTransparency = 1,
		ImageColor3            = Color3.fromRGB(255,255,255),
		Position               = UDim2.new(0.022, 0, 0.032, 0),
		Size                   = UDim2.new(0, 18, 0, 18),
		ZIndex                 = 2

	})

	local Top = self:Create("Frame", Main, {

		Name = "Top",
		BackgroundTransparency = 1,
		Position = UDim2.new(0,0,0,0),
		Size = UDim2.new(1,0,0,50),
		ZIndex = 1,

	})

	local Exit = self:Create("ImageButton", Main, {

		Name                   = "Exit",
		Image                  = "http://www.roblox.com/asset/?id=18637764429",
		BackgroundTransparency = 1,
		Position               = UDim2.new(0.922, 0, 0.025, 0),
		Size                   = UDim2.new(0, 25, 0, 25),
		ZIndex                 = 2

	})

	Exit.MouseButton1Click:Connect(function()

		Library:ToggleUi(true)

	end)

	local SectionHolder = self:Create("ScrollingFrame", Main, {

		Name                   = "SectionHolder",
		Position               = UDim2.new(0.015, 0, 0.139, 0),
		Size                   = UDim2.new(0, 440, 0, 310),
		BackgroundTransparency = 1,
		CanvasSize             = UDim2.new(0,0,0,0),
		AutomaticCanvasSize    = Enum.AutomaticSize.Y,
		ScrollBarThickness     = 0,
		ScrollingDirection     = Enum.ScrollingDirection.Y,
		ZIndex                 = 2

	})

	local SectionHolderP = self:Create("UIPadding", SectionHolder, {

		Name          = "SectionHolderP",
		PaddingBottom = UDim.new(0,4),
		PaddingTop    = UDim.new(0,4)

	})

	local SectionHolderL = self:Create("UIListLayout", SectionHolder, {

		Name = "SectionHolderL",
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding = UDim.new(0, 10)

	})

	local Glow = self:Create("ImageLabel", Main, {

		AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://6014261993",
		ZIndex = 0,
		Size = UDim2.new(1, 57, 1, 48),
		Name = "Glow",
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.fromRGB(26, 26, 26),
		ImageColor3 = Color3.fromRGB(26, 26, 26),
		ImageTransparency = 0.5

	})
	
	Library.ToggledGui = false
	Library.ToggledGuiDebounce = false

	function Library:ToggleUi(Destroy)

		local Debounce = Library.ToggledGuiDebounce

		if Debounce then
			return
		end

		Debounce = not Debounce

		Destroy = Destroy or false

		if Destroy then
			local AD = Instance.new("StringValue")
			AD.Name = "Destroyed"
			AD.Parent = Aurora
			return Aurora:Destroy()
		end

		Aurora.Enabled = not Aurora.Enabled

		Debounce = not Debounce

	end

	Functions:Drag(Top, Main)

	local Tabs = setmetatable({}, {
		__index = Library
	})

	function Tabs:Section(Name)

		local Section = self:Create("Frame", SectionHolder, {

			AnchorPoint = Vector2.new(0, 0),
			ZIndex = 3,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, -14, 0, 40),
			Name = "Section",
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255)

		})

		--Library.Tabs[] = Section

		local SectionTitle = self:Create("TextLabel", Section, {

			TextTransparency = 0,
			AnchorPoint = Vector2.new(0, 0),
			ZIndex = 4,
			TextSize = 22,
			Size = UDim2.new(0, 370, 0, 20),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = Name,
			Font = Enum.Font.SourceSansSemibold,
			Name = "SectionTitle",
			Position = UDim2.new(0.0328283, 0, 0.149254, 0),
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			Visible = true

		})

		local SectionL = self:Create("UIListLayout", Section, {

			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Name = "SectionL",
			Padding = UDim.new(0, 8)

		})

		local SectionP = self:Create("UIPadding", Section, {

			Name = "SectionP",
			PaddingBottom = UDim.new(0, 3),
			PaddingTop = UDim.new(0, 3)

		})

		local Content = setmetatable({}, {
			__index = Tabs
		})

		function Content:Button(Name, Callback)

			local Button = self:Create("Frame", Section, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 4,
				Size = UDim2.new(0, 380, 0, 40),
				Name = "Button",
				Position = UDim2.new(0.373737, 0, 0.533333, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)

			})


			local ButtonC = self:Create("UICorner", Button, {

				CornerRadius = UDim.new(0, 5),
				Name = "ButtonC"

			})


			local ButtonB = self:Create("TextButton", Button, {

				TextTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 1,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Text = "0",
				Font = Enum.Font.SourceSans,
				Name = "ButtonB",
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local ButtonT = self:Create("TextLabel", Button, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 17,
				Size = UDim2.new(0, 200, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Name,
				Font = Enum.Font.SourceSansSemibold,
				Name = "ButtonT",
				Position = UDim2.new(0.0421053, 0, 0.175, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				TextXAlignment = Enum.TextXAlignment.Left

			})

			ButtonB.MouseButton1Click:Connect(function()
				task.spawn(Callback)
			end)

			return Button

		end

		function Content:Toggle(Name, Default, Callback)

			local Toggle = self:Create("Frame", Section, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 4,
				Size = UDim2.new(0, 380, 0, 40),
				Name = "Toggle",
				Position = UDim2.new(0.373737, 0, 0.533333, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)

			})

			Library.Flags[Toggle] = {State = Default, Debounce = false, Callback = Callback or function() end}



			local ToggleC = self:Create("UICorner", Toggle, {

				CornerRadius = UDim.new(0, 5),
				Name = "ToggleC"

			})


			local ToggleT = self:Create("TextLabel", Toggle, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 17,
				Size = UDim2.new(0, 200, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Name,
				Font = Enum.Font.SourceSansSemibold,
				Name = "ToggleT",
				Position = UDim2.new(0.0421053, 0, 0.175, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local Inner = self:Create("Frame", Toggle, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				Size = UDim2.new(0, 34, 0, 20),
				Name = "Inner",
				Position = UDim2.new(0.86074, 0, 0.245, 1),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(50, 50, 51)

			})


			local InnerC = self:Create("UICorner", Inner, {

				CornerRadius = UDim.new(1, 0),
				Name = "InnerC"

			})


			local Circle = self:Create("Frame", Inner, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				Size = UDim2.new(0, 14, 0, 14),
				Name = "Circle",
				Position = UDim2.new(0, 3, 0.135, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(29, 29, 29)

			})


			local CicleC = self:Create("UICorner", Circle, {

				CornerRadius = UDim.new(999, 0),
				Name = "CicleC"

			})


			local ToggleB = self:Create("TextButton", Toggle, {

				TextTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 14,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Text = "",
				Font = Enum.Font.SourceSans,
				Name = "ToggleB",
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})

			if Default then

				Utility:Tween(Inner, .2, {

					BackgroundColor3 = ( Library.Flags[Toggle].State and Color3.fromRGB(82, 146, 236)) or Color3.fromRGB(50,50,51)

				})

				Utility:Tween(Circle, .2, {

					Position = ( Library.Flags[Toggle].State and UDim2.new(0.49, 0, 0.135, 0)) or UDim2.new(0, 3, 0.135, 0),

				})

				Callback(Default)

			end

			Toggle.ToggleB.MouseButton1Click:Connect(function()

				Functions:SetState(Toggle, Default, Callback)

			end)

			return Toggle

		end

		function Content:Keybind(Name, Default, Callback)

			local Keybind = self:Create("Frame", Section, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 4,
				Size = UDim2.new(0, 380, 0, 40),
				Name = "Keybind",
				Position = UDim2.new(0.373737, 0, 0.533333, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)

			})


			local KeybindC = self:Create("UICorner", Keybind, {

				CornerRadius = UDim.new(0, 5),
				Name = "KeybindC"

			})


			local KeybindB = self:Create("TextButton", Keybind, {

				TextTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 1,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Text = "0",
				Font = Enum.Font.SourceSans,
				Name = "KeybindB",
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local KeybindT = self:Create("TextLabel", Keybind, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 17,
				Size = UDim2.new(0, 200, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Name,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "KeybindT",
				Position = UDim2.new(0.0421053, 0, 0.175, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local Inner = self:Create("Frame", Keybind, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				Size = UDim2.new(0, 32, 0, 25),
				Name = "Inner",
				Position = UDim2.new(0.853, 0, 0.175, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})


			local InnerC = self:Create("UICorner", Inner, {

				CornerRadius = UDim.new(0, 5),
				Name = "InnerC"

			})


			local InnerKB = self:Create("TextBox", Inner, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 14,
				Size = UDim2.new(0, 24, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Default,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "InnerKB",
				TextTruncate = Enum.TextTruncate.AtEnd,
				Position = UDim2.new(0.368, 0, 0, 0),
				BackgroundTransparency = 1,
				Interactable = false,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})

			Callback = Callback or function() end

			local BannedKeys, ShortNames = {
				Return = true,
				Space = true,
				Tab = true,
				Backquote = true,
				CapsLock = true,
				Escape = true,
				Unknown = true,
			}, {
				RightControl = "Right Ctrl",
				LeftControl = "Left Ctrl",
				LeftShift = "Left Shift",
				RightShift = "Right Shift",
				Semicolon = ";",
				Quote = '"',
				LeftBracket = "[",
				RightBracket = "]",
				Equals = "=",
				Minus = "-",
				RightAlt = "Right Alt",
				LeftAlt = "Left Alt"
			}

			Default = (typeof(Default) == "string" and Enum.KeyCode[Default] or Default)

			local KeyTxt, BindKey = (Default and (ShortNames[Default.Name] or Default.Name) or "None"), Default

			Connections[#Connections + 1] = Services.UserInputService.InputBegan:Connect(function(inp, gpe)
				if gpe then
					return
				end

				if inp.UserInputType ~= Enum.UserInputType.Keyboard then
					return
				end

				if inp.KeyCode ~= BindKey then
					return
				end

				Callback(BindKey.Name)
			end)

			local Debounce, InMenu = false, false

			KeybindB.MouseButton1Click:Connect(function()

				if Debounce then
					return
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = InMenu and UDim2.new(0.787, 0, 0.175, 0) or UDim2.new(0.853, 0, 0.175, 0),
					Size = InMenu and UDim2.new(0, 58, 0, 25) or UDim2.new(0, 32, 0, 25)

				})

				Library:Tween(InnerKB, .2, {

					Position = InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.368, 0, 0, 0),
					Size = InMenu and UDim2.new(0, 52, 0, 25) or UDim2.new(0, 24, 0, 25)

				})

				task.wait(0.1)

				InnerKB.Text = InMenu and "..." or KeyTxt

				Library:Tween(InnerKB, .1, {TextTransparency = 0})

				task.wait()

				local key = Services.UserInputService.InputEnded:Wait()

				if key.UserInputType ~= Enum.UserInputType.Keyboard then

					InMenu = not InMenu

					InnerKB.Text = KeyTxt

					Library:Tween(Inner, .2, {

						Position = InMenu and UDim2.new(0.787, 0, 0.175, 0) or UDim2.new(0.853, 0, 0.175, 0),
						Size = InMenu and UDim2.new(0, 58, 0, 25) or UDim2.new(0, 32, 0, 25)

					})

					Library:Tween(InnerKB, .2, {

						Position = InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.368, 0, 0, 0),
						Size = InMenu and UDim2.new(0, 52, 0, 25) or UDim2.new(0, 24, 0, 25)

					})

					Debounce = not Debounce

					return
				end

				if BannedKeys[tostring(key.KeyCode.Name)] then

					InMenu = not InMenu

					InnerKB.Text = KeyTxt

					Library:Tween(Inner, .2, {

						Position = InMenu and UDim2.new(0.787, 0, 0.175, 0) or UDim2.new(0.853, 0, 0.175, 0),
						Size = InMenu and UDim2.new(0, 58, 0, 25) or UDim2.new(0, 32, 0, 25)

					})

					Library:Tween(InnerKB, .2, {

						Position = InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.368, 0, 0, 0),
						Size = InMenu and UDim2.new(0, 52, 0, 25) or UDim2.new(0, 24, 0, 25)

					})

					Debounce = not Debounce

					return
				end

				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = InMenu and UDim2.new(0.787, 0, 0.175, 0) or UDim2.new(0.853, 0, 0.175, 0),
					Size = InMenu and UDim2.new(0, 58, 0, 25) or UDim2.new(0, 32, 0, 25)

				})

				Library:Tween(InnerKB, .2, {

					Position = InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.368, 0, 0, 0),
					Size = InMenu and UDim2.new(0, 52, 0, 25) or UDim2.new(0, 24, 0, 25)

				})

				BindKey = Enum.KeyCode[tostring(key.KeyCode.Name)]

				InnerKB.Text = ShortNames[tostring(key.KeyCode.Name)] or tostring(key.KeyCode.Name)

				Debounce = not Debounce

			end)

			return Keybind

		end

		function Content:TextBox(Name, Default, Callback)

			local TextBox = self:Create("Frame", Section, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 4,
				Size = UDim2.new(0, 380, 0, 40),
				Name = "TextBox",
				Position = UDim2.new(0.373737, 0, 0.533333, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)

			})


			local TextBoxC = self:Create("UICorner", TextBox, {

				CornerRadius = UDim.new(0, 5),
				Name = "TextBoxC"

			})


			local TextBoxB = self:Create("TextButton", TextBox, {

				TextTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 1,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Text = "0",
				Font = Enum.Font.SourceSans,
				Name = "TextBoxB",
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local TextBoxT = self:Create("TextLabel", TextBox, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 17,
				Size = UDim2.new(0, 200, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Name,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "TextBoxT",
				Position = UDim2.new(0.0421053, 0, 0.175, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local Inner = self:Create("Frame", TextBox, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				Size = UDim2.new(0, 32, 0, 25),
				Name = "Inner",
				Position = UDim2.new(0.853, 0, 0.175, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})


			local InnerC = self:Create("UICorner", Inner, {

				CornerRadius = UDim.new(0, 5),
				Name = "InnerC"

			})


			local InnerTextBox = self:Create("TextBox", Inner, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 14,
				Size = UDim2.new(0, 24, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Default,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Name = "InnerTextBox",
				Position = UDim2.new(0.368, 0, 0, 0),
				BackgroundTransparency = 1,
				--Interactable = false,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})

			Callback = Callback or function() end

			Library.Flags[TextBox] = {Text = Default}

			local Debounce, InMenu = false, false

			InnerTextBox.Focused:Connect(function()

				if Debounce then
					return
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = (InMenu and UDim2.new(0.769, 0, 0.175, 0)) or UDim2.new(0.816, 0, 0.175, 0),
					Size = (InMenu and UDim2.new(0, 64, 0, 25)) or UDim2.new(0, 46, 0, 25)

				})

				Library:Tween(InnerTextBox, .2, {

					Position = (InMenu and UDim2.new(0.2, 0, 0, 0)) or UDim2.new(0.2, 0, 0, 0),
					Size = (InMenu and UDim2.new(0, 44, 0, 25)) or UDim2.new(0, 38, 0, 25)

				})

				task.wait(0.2)

				Debounce = not Debounce
				InMenu = not InMenu

			end)

			InnerTextBox.FocusLost:Connect(function()

				if Debounce then
					InnerTextBox:CaptureFocus() 
					return
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = not InMenu and UDim2.new(0.769, 0, 0.175, 0) or UDim2.new(0.816, 0, 0.175, 0),
					Size = not InMenu and UDim2.new(0, 64, 0, 25) or UDim2.new(0, 46, 0, 25)

				})

				Library:Tween(InnerTextBox, .2, {

					Position = not InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.2, 0, 0, 0),
					Size = not InMenu and UDim2.new(0, 44, 0, 25) or UDim2.new(0, 38, 0, 25)

				})

				task.wait(0.2)

				if InnerTextBox.Text == "" then
					InnerTextBox.Text = Default
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Callback(InnerTextBox.Text)

			end)

			return TextBox

		end
		
		function Content:CopyLabel(Name, Default, Callback)

			local CopyLabel = self:Create("Frame", Section, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 4,
				Size = UDim2.new(0, 380, 0, 40),
				Name = "CopyLabel",
				Position = UDim2.new(0.373737, 0, 0.533333, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)

			})


			local TextBoxC = self:Create("UICorner", CopyLabel, {

				CornerRadius = UDim.new(0, 5),
				Name = "TextBoxC"

			})


			local TextBoxB = self:Create("TextButton", CopyLabel, {

				TextTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 1,
				Size = UDim2.new(1, 0, 1, 0),
				TextColor3 = Color3.fromRGB(0, 0, 0),
				Text = "0",
				Font = Enum.Font.SourceSans,
				Name = "TextBoxB",
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local TextBoxT = self:Create("TextLabel", CopyLabel, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 17,
				Size = UDim2.new(0, 200, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Name,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				Name = "TextBoxT",
				Position = UDim2.new(0.0421053, 0, 0.175, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			})


			local Inner = self:Create("Frame", CopyLabel, {

				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				Size = UDim2.new(0, 32, 0, 25),
				Name = "CopyLabelInner",
				Position = UDim2.new(0.853, 0, 0.175, 0),
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})


			local InnerC = self:Create("UICorner", Inner, {

				CornerRadius = UDim.new(0, 5),
				Name = "InnerC"

			})


			local InnerTextBox = self:Create("TextBox", Inner, {

				TextTransparency = 0,
				AnchorPoint = Vector2.new(0, 0),
				ZIndex = 5,
				TextSize = 14,
				Size = UDim2.new(0, 44, 0, 25),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Text = Default,
				Font = Enum.Font.SourceSansSemibold,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Name = "CopyLabelInnerTB",
				Position = UDim2.new(0.368, 0, 0, 0),
				BackgroundTransparency = 1,
				ClearTextOnFocus = false,
				--Interactable = false,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)

			})

			Callback = Callback or function() end

			Library.Flags[CopyLabel] = {Text = Default}

			local Debounce, InMenu = false, false

			InnerTextBox.Focused:Connect(function()

				if Debounce then
					return
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = (InMenu and UDim2.new(0.725, 0, 0.175, 0)) or UDim2.new(0.816, 0, 0.175, 0),
					Size = (InMenu and UDim2.new(0, 82, 0, 25)) or UDim2.new(0, 52, 0, 25)

				})

				Library:Tween(InnerTextBox, .2, {

					Position = (InMenu and UDim2.new(0.2, 0, 0, 0)) or UDim2.new(0.2, 0, 0, 0),
					Size = (InMenu and UDim2.new(0, 60, 0, 25)) or UDim2.new(0, 44, 0, 25)

				})

				task.wait(0.2)

				Debounce = not Debounce
				InMenu = not InMenu

			end)

			InnerTextBox.FocusLost:Connect(function()

				if Debounce then
					InnerTextBox:CaptureFocus() 
					return
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Library:Tween(Inner, .2, {

					Position = not InMenu and UDim2.new(0.725, 0, 0.175, 0) or UDim2.new(0.816, 0, 0.175, 0),
					Size = not InMenu and UDim2.new(0, 64, 0, 25) or UDim2.new(0, 46, 0, 25)

				})

				Library:Tween(InnerTextBox, .2, {

					Position = not InMenu and UDim2.new(0.2, 0, 0, 0) or UDim2.new(0.2, 0, 0, 0),
					Size = not InMenu and UDim2.new(0, 44, 0, 25) or UDim2.new(0, 38, 0, 25)

				})

				task.wait(0.2)

				if InnerTextBox.Text == "" then
					InnerTextBox.Text = Default
				end

				Debounce = not Debounce
				InMenu = not InMenu

				Callback(InnerTextBox.Text)

			end)

			return CopyLabel

		end

		return Content

	end

	return Tabs

end

local ScriptFunctions = setmetatable({}, { __index = Functions })

ScriptFunctions.Players = {}
ScriptFunctions.Servers = {}
ScriptFunctions.NumberOfServers = 0
ScriptFunctions.Viewing = nil

function ScriptFunctions:ViewPlayer(Player)

	if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then

		game.Workspace.CurrentCamera.CameraSubject = Player.Character.HumanoidRootPart

		ScriptFunctions.Viewing = Player

	end

end

for i, v in next, game.Players:GetPlayers() do
	if v ~= game.Players.LocalPlayer then
		ScriptFunctions.Players[#ScriptFunctions.Players + 1] = v
	end
end

Connections[#Connections + 1] = game.Players.PlayerAdded:Connect(function(Player)
	ScriptFunctions.Players[#ScriptFunctions.Players + 1] = Player
end)

Connections[#Connections + 1] = game.Players.PlayerRemoving:Connect(function(Player)
	for i, v in ipairs(ScriptFunctions.Players) do
		if v == Player then
			table.remove(ScriptFunctions.Players, i)
			break
		end
	end
end)

function ScriptFunctions:GetServerByJobId(JobId)
	
	local Found = false
	
	for i,v in next, ScriptFunctions.Servers do
		
		if v.JobId == JobId then
			
			Found = true
			
			return v
			
		end
		
	end
	
	if not Found then
		
		warn("[ CLIENT ] : SERVER NOT FOUND")
		
		return nil
		
	end
	
end

function ScriptFunctions:GetRandomServer()
	
	local RandomIndex = math.random(1, #ScriptFunctions.Servers)

	local Server = ScriptFunctions.Servers[RandomIndex]
	
	if Server.JobId == game.JobId then
		
		Server = ScriptFunctions:GetRandomServer()
		
	end
	
	return Server
	
end

Connections[#Connections + 1] = game:GetService("ReplicatedStorage").Servers.ChildAdded:Connect(function(Child)
	
	ScriptFunctions.Servers[#ScriptFunctions.Servers + 1] = {Object = Child, JobId = Child:GetAttribute("serverId"), PlaceId = Child:GetAttribute("placeId")}
	
	warn("[ CLIENT ] : SERVER ADDED : ".. Child.Name)
	
end)

for i,v in next, game:GetService("ReplicatedStorage").Servers:GetChildren() do
	
	ScriptFunctions.Servers[#ScriptFunctions.Servers + 1] = {Object = v, JobId = v:GetAttribute("serverId"), PlaceId = v:GetAttribute("placeId")}
	
end

local Window = Library:Init("Moderation Menu", nil)

local Section = Window:Section("Viewing")

local ViewingIndex = 1

Section:Button("Next Player", function()
	
	if #ScriptFunctions.Players > 0 then
		
		ViewingIndex = (ViewingIndex % #ScriptFunctions.Players) + 1
		
		ScriptFunctions:ViewPlayer(ScriptFunctions.Players[ViewingIndex])
		
	end
	
end)

Section:Button("Last Player", function()
	
	if #ScriptFunctions.Players > 0 then
		
		ViewingIndex = (ViewingIndex - 2) % #ScriptFunctions.Players + 1
		
		ScriptFunctions:ViewPlayer(ScriptFunctions.Players[ViewingIndex])
		
	end
	
end)

--[[
game.Players.LocalPlayer:GetMouse().Button1Down:Connect(function()
	
	game:GetService("ReplicatedStorage").Events.SpawnMeteor:FireServer(game.Players.LocalPlayer:GetMouse().Hit.Position, game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton2), nil)
	
end)
]]

Section:Toggle("Viewing", false, function(State)
	
	if not State then
		
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		
		ScriptFunctions.Viewing = nil
		
	elseif ScriptFunctions.Viewing then
		
		ScriptFunctions:ViewPlayer(ScriptFunctions.Players[ViewingIndex])
		
	end
	
end)

Section:Button("Server Hop", function()
	
	local Server = ScriptFunctions:GetRandomServer()
	
	Services.TeleportService:TeleportToPlaceInstance(Server.PlaceId, Server.JobId, Player)
	
end)

local Section = Window:Section("Player")

Section:Button("Copy UserId", function()

	Library.Flags["CopyLabel"].CopyLabelInner.CopyLabelInnerTB.Text = tostring(ScriptFunctions.Players[ViewingIndex].UserId)

end)

Section:Button("Copy Username", function()

	Library.Flags["CopyLabel"].CopyLabelInner.CopyLabelInnerTB.Text = tostring(ScriptFunctions.Players[ViewingIndex].Name)

end)

Library.Flags["CopyLabel"] = Section:CopyLabel("UserId / Username", "")
Library.Flags["BanFlags"] = {}

local Section2 = Window:Section("Joining")

Section2:TextBox("UserId To Join", "", function(UserId)
	
	local Found = false
	
	for _, v in next, ScriptFunctions.Servers do
		
		local ids = string.split(v.Object:GetAttribute("players"), ",")
		
		for _, v1 in ipairs(ids) do
			
			if UserId == v1 then
				
				Found = true
				
				Services.TeleportService:TeleportToPlaceInstance(v.PlaceId, v.JobId, Player)
				
			end
			
		end
		
	end
	
	if not Found then
		
		warn("[ CLIENT ] : PLAYER NOT FOUND")
		
	end
	
end)

local Section3 = Window:Section("Moderation")


Library.Flags.BanFlags["CopyLabel"] = Section3:CopyLabel("UserId / Username To Moderate", "")
Library.Flags.BanFlags["Reason"] = Section3:CopyLabel("Reason", "")

Section3:Button("Ban", function()
	
	local args = {
		[1] = "banUser " .. tostring(Library.Flags.BanFlags.CopyLabel.CopyLabelInner.CopyLabelInnerTB.Text) .. " " .. tostring(Library.Flags.BanFlags.Reason.CopyLabelInner.CopyLabelInnerTB.Text),
		[2] = {}
	}

	if Library.Flags[Library.Flags.BanFlags.Toggle].State == true then
		
		Services.ReplicatedStorage:WaitForChild("CmdrClient"):WaitForChild("CmdrFunction"):InvokeServer(unpack(args))
		
	end
	
end)

Section3:Button("Unban", function()

	local args = {
		[1] = "unban " .. tostring(Library.Flags.BanFlags.CopyLabel.CopyLabelInner.CopyLabelInnerTB.Text) .. " " .. tostring(Library.Flags.BanFlags.Reason.CopyLabelInner.CopyLabelInnerTB.Text),
		[2] = {}
	}
	
	if Library.Flags[Library.Flags.BanFlags.Toggle].State == true then

		Services.ReplicatedStorage:WaitForChild("CmdrClient"):WaitForChild("CmdrFunction"):InvokeServer(unpack(args))

	end

end)

Section3:Button("Kick", function()

	local args = {
		[1] = "kick " .. tostring(Library.Flags.BanFlags.CopyLabel.CopyLabelInner.CopyLabelInnerTB.Text) .. " " .. tostring(Library.Flags.BanFlags.Reason.CopyLabelInner.CopyLabelInnerTB.Text),
		[2] = {}
	}
	
	if Library.Flags[Library.Flags.BanFlags.Toggle].State == true then

		Services.ReplicatedStorage:WaitForChild("CmdrClient"):WaitForChild("CmdrFunction"):InvokeServer(unpack(args))

	end

end)

Library.Flags.BanFlags.Toggle = Section3:Toggle("Confirm", false, function(State)
	
	Library.Flags.BanFlags.Confirmed = State
	
end)

local Section4 = Window:Section("Settings")

Section4:Keybind("Toggle UI", "F", function(Value)
	
	Library:ToggleUi()
	
end)

queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

Player.OnTeleport:Connect(function()

    queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Crystal-Softworks/Utils/refs/heads/main/Moderation.luau'))()")

end)
