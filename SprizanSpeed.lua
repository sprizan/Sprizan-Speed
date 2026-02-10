-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Werte (legit & safe)
local speed = 20
local jump = 55
local enabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SprizanMobileMovement"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 340, 0, 260)
main.Position = UDim2.new(0.5, -170, 0.6, -130)
main.BackgroundColor3 = Color3.fromRGB(240,240,240)
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

-- Top Bar (Drag)
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,55)
top.BackgroundColor3 = Color3.fromRGB(230,230,230)
Instance.new("UICorner", top).CornerRadius = UDim.new(0,20)

-- Drag (Touch + Mouse)
local dragging = false
local dragStart, startPos

top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

top.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement
	) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Title
local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Movement Settings"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(40,40,40)

-- Toggle Button (groß)
local toggle = Instance.new("TextButton", main)
toggle.Size = UDim2.new(0.9,0,0,60)
toggle.Position = UDim2.new(0.05,0,0.3,0)
toggle.Text = "Enable Movement Boost"
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(90,170,120)
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,14)

-- Speed Box
local speedBox = Instance.new("TextBox", main)
speedBox.Size = UDim2.new(0.4,0,0,50)
speedBox.Position = UDim2.new(0.05,0,0.6,0)
speedBox.Text = tostring(speed)
speedBox.PlaceholderText = "Speed"
speedBox.ClearTextOnFocus = false
speedBox.Font = Enum.Font.GothamBold
speedBox.TextScaled = true
speedBox.TextColor3 = Color3.fromRGB(30,30,30)
speedBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,12)

-- Jump Box
local jumpBox = Instance.new("TextBox", main)
jumpBox.Size = UDim2.new(0.4,0,0,50)
jumpBox.Position = UDim2.new(0.55,0,0.6,0)
jumpBox.Text = tostring(jump)
jumpBox.PlaceholderText = "Jump"
jumpBox.ClearTextOnFocus = false
jumpBox.Font = Enum.Font.GothamBold
jumpBox.TextScaled = true
jumpBox.TextColor3 = Color3.fromRGB(30,30,30)
jumpBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0,12)

-- Dezenter Sound
local sound = Instance.new("Sound", gui)
sound.SoundId = "rbxassetid://12221967"
sound.Volume = 0.5

-- Apply
local function apply()
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		if enabled then
			hum.WalkSpeed = speed
			hum.JumpPower = jump
		else
			hum.WalkSpeed = 16
			hum.JumpPower = 50
		end
	end
end

-- Toggle
toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	sound:Play()

	if enabled then
		toggle.Text = "Disable Movement Boost"
		toggle.BackgroundColor3 = Color3.fromRGB(200,90,90)
	else
		toggle.Text = "Enable Movement Boost"
		toggle.BackgroundColor3 = Color3.fromRGB(90,170,120)
	end

	apply()
end)

-- Inputs
speedBox.FocusLost:Connect(function()
	local v = tonumber(speedBox.Text)
	if v then speed = math.clamp(v,16,30) end
	speedBox.Text = speed
	apply()
end)

jumpBox.FocusLost:Connect(function()
	local v = tonumber(jumpBox.Text)
	if v then jump = math.clamp(v,50,70) end
	jumpBox.Text = jump
	apply()
end)

-- Respawn safe
player.CharacterAdded:Connect(function()
	task.wait(0.5)
	apply()
end)

