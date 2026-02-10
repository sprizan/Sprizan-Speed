--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Player
local player = Players.LocalPlayer
local speed = 50
local enabled = false
local connection

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SprizanSpeedGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.05, 0, 0.8, 0)
button.Text = "Enable Speed"
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(70,120,255)
button.Parent = gui

Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)
local stroke = Instance.new("UIStroke", button)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(120,170,255)

-- TextBox
local box = Instance.new("TextBox")
box.Size = UDim2.new(0, 80, 0, 50)
box.Position = UDim2.new(0.05, 160, 0.8, 0)
box.PlaceholderText = "Speed"
box.Text = tostring(speed)
box.ClearTextOnFocus = false
box.Font = Enum.Font.GothamBold
box.TextScaled = true
box.TextColor3 = Color3.new(1,1,1)
box.BackgroundColor3 = Color3.fromRGB(20,20,20)
box.Parent = gui

Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)
local boxStroke = Instance.new("UIStroke", box)
boxStroke.Thickness = 2
boxStroke.Color = Color3.fromRGB(80,80,80)

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

--// Button Toggle
button.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		button.Text = "Disable Speed"
		button.BackgroundColor3 = Color3.fromRGB(255,70,70)
		stroke.Color = Color3.fromRGB(255,120,120)
		startSpeed()
	else
		button.Text = "Enable Speed"
		button.BackgroundColor3 = Color3.fromRGB(70,120,255)
		stroke.Color = Color3.fromRGB(120,170,255)
		stopSpeed()
	end
end)

--// Speed Input
box.FocusLost:Connect(function()
	local val = tonumber(box.Text)
	if val then
		speed = math.clamp(val, 1, 500)
		box.Text = tostring(speed)
	else
		box.Text = tostring(speed)
	end
end)
