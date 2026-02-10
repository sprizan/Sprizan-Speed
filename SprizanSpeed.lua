--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

--// Player
local player = Players.LocalPlayer
local speed = 50
local enabled = false
local connection

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SprizanBooster"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 180)
main.Position = UDim2.new(0.4, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20,20,25)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(90,120,255)
stroke.Thickness = 2

--// Dragging
local dragging, dragStart, startPos
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

main.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--// Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Sprizan Booster"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(120,150,255)
title.Parent = main

--// Discord
local discord = Instance.new("TextLabel")
discord.Position = UDim2.new(0, 0, 0, 35)
discord.Size = UDim2.new(1, 0, 0, 25)
discord.BackgroundTransparency = 1
discord.Text = "discord.gg/DAA3d7BcPU"
discord.Font = Enum.Font.Gotham
discord.TextScaled = true
discord.TextColor3 = Color3.fromRGB(180,180,180)
discord.Parent = main

--// Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 45)
button.Position = UDim2.new(0.1, 0, 0.45, 0)
button.Text = "ENABLE SPEED"
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(70,120,255)
button.Parent = main

Instance.new("UICorner", button).CornerRadius = UDim.new(0,12)

--// Speed Box
local box = Instance.new("TextBox")
box.Size = UDim2.new(0.5, 0, 0, 40)
box.Position = UDim2.new(0.25, 0, 0.75, 0)
box.Text = tostring(speed)
box.PlaceholderText = "Speed"
box.ClearTextOnFocus = false
box.Font = Enum.Font.GothamBold
box.TextScaled = true
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(30,30,35)
box.Parent = main

Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

--// Speed Logic
local function startSpeed()
	if connection then connection:Disconnect() end
	connection = RunService.Heartbeat:Connect(function()
		local char = player.Character
		if not char then return end

		local hrp = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hrp or not hum then return end

		local dir = hum.MoveDirection
		if dir.Magnitude > 0 then
			hrp.AssemblyLinearVelocity =
				Vector3.new(dir.X * speed, hrp.AssemblyLinearVelocity.Y, dir.Z * speed)
		end
	end)
end

local function stopSpeed()
	if connection then
		connection:Disconnect()
		connection = nil
	end
end

--// Toggle
button.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		button.Text = "DISABLE SPEED"
		button.BackgroundColor3 = Color3.fromRGB(255,80,80)
		startSpeed()
	else
		button.Text = "ENABLE SPEED"
		button.BackgroundColor3 = Color3.fromRGB(70,120,255)
		stopSpeed()
	end
end)

--// Speed Input
box.FocusLost:Connect(function()
	local v = tonumber(box.Text)
	if v then
		speed = math.clamp(v,1,500)
	end
	box.Text = tostring(speed)
end)

