--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--// Values
local speed = 60
local jumpForce = 85
local speedEnabled = false
local speedConn

--// GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "SprizanBooster"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,300,0,250)
main.Position = UDim2.new(0.35,0,0.35,0)
main.BackgroundColor3 = Color3.fromRGB(18,18,22)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

-- Glow
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(120,160,255)

-- Gradient Animation
local grad = Instance.new("UIGradient", main)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(90,120,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255,90,200))
}
TweenService:Create(
	grad,
	TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
	{Rotation = 360}
):Play()

-- Drag (TOP BAR)
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,45)
top.BackgroundTransparency = 1

local dragging, dragStart, startPos
top.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
	end
end)
UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local d = i.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Title
local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Sprizan Booster"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(160,190,255)

local dc = Instance.new("TextLabel", top)
dc.Position = UDim2.new(0,0,0,28)
dc.Size = UDim2.new(1,0,0,16)
dc.BackgroundTransparency = 1
dc.Text = "discord.gg/DAA3d7BcPU"
dc.Font = Enum.Font.Gotham
dc.TextScaled = true
dc.TextColor3 = Color3.fromRGB(180,180,180)

-- Sound
local sound = Instance.new("Sound", gui)
sound.SoundId = "rbxassetid://9118823101"
sound.Volume = 1

-- Speed Button
local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0.8,0,0,45)
btn.Position = UDim2.new(0.1,0,0.35,0)
btn.Text = "ENABLE BOOST"
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(80,120,255)
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,14)

-- Boxes
local sBox = Instance.new("TextBox", main)
sBox.Size = UDim2.new(0.35,0,0,38)
sBox.Position = UDim2.new(0.1,0,0.6,0)
sBox.Text = speed
sBox.Font = Enum.Font.GothamBold
sBox.TextScaled = true
sBox.TextColor3 = Color3.new(1,1,1)
sBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
Instance.new("UICorner", sBox).CornerRadius = UDim.new(0,10)

local jBox = Instance.new("TextBox", main)
jBox.Size = UDim2.new(0.35,0,0,38)
jBox.Position = UDim2.new(0.55,0,0.6,0)
jBox.Text = jumpForce
jBox.Font = Enum.Font.GothamBold
jBox.TextScaled = true
jBox.TextColor3 = Color3.new(1,1,1)
jBox.BackgroundColor3 = Color3.fromRGB(30,30,35)
Instance.new("UICorner", jBox).CornerRadius = UDim.new(0,10)

-- Speed Logic
local function startSpeed()
	if speedConn then speedConn:Disconnect() end
	speedConn = RunService.Heartbeat:Connect(function()
		local c = player.Character
		local hrp = c and c:FindFirstChild("HumanoidRootPart")
		local hum = c and c:FindFirstChildOfClass("Humanoid")
		if hrp and hum then
			local d = hum.MoveDirection
			if d.Magnitude > 0 then
				hrp.AssemblyLinearVelocity = Vector3.new(d.X*speed, hrp.AssemblyLinearVelocity.Y, d.Z*speed)
			end
		end
	end)
end

-- Hard Jump Bypass
UIS.JumpRequest:Connect(function()
	if not speedEnabled then return end
	local c = player.Character
	local hrp = c and c:FindFirstChild("HumanoidRootPart")
	if hrp then
		local bv = Instance.new("BodyVelocity", hrp)
		bv.MaxForce = Vector3.new(0, math.huge, 0)
		bv.Velocity = Vector3.new(0, jumpForce, 0)
		game.Debris:AddItem(bv, 0.25)
	end
end)

-- Toggle
btn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
	sound:Play()
	if speedEnabled then
		btn.Text = "DISABLE BOOST"
		btn.BackgroundColor3 = Color3.fromRGB(255,80,80)
		startSpeed()
	else
		btn.Text = "ENABLE BOOST"
		btn.BackgroundColor3 = Color3.fromRGB(80,120,255)
		if speedConn then speedConn:Disconnect() end
	end
end)

sBox.FocusLost:Connect(function()
	local v = tonumber(sBox.Text)
	if v then speed = math.clamp(v,1,500) end
	sBox.Text = speed
end)

jBox.FocusLost:Connect(function()
	local v = tonumber(jBox.Text)
	if v then jumpForce = math.clamp(v,1,300) end
	jBox.Text = jumpForce
end)

-- Auto reapply
player.CharacterAdded:Connect(function()
	if speedEnabled then task.wait(0.5) startSpeed() end
end)

