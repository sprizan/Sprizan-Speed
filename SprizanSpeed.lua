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

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,340,0,260)
main.Position = UDim2.new(0.33,0,0.32,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,20)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

-- Glow Stroke
local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(120,170,255)

-- Gradient Glow Animation
local grad = Instance.new("UIGradient", main)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(80,120,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180,80,255))
}

TweenService:Create(
	grad,
	TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
	{Rotation = 360}
):Play()

-- TOP BAR (Drag PC + Mobile)
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,45)
top.BackgroundTransparency = 1

local dragging, dragStart, startPos

top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement 
	or input.UserInputType == Enum.UserInputType.Touch) then
		
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- TITLE
local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,0,28)
title.BackgroundTransparency = 1
title.Text = "Sprizan Booster"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(170,200,255)

-- Discord
local dc = Instance.new("TextLabel", top)
dc.Position = UDim2.new(0,0,0,28)
dc.Size = UDim2.new(1,0,0,16)
dc.BackgroundTransparency = 1
dc.Text = "discord.gg/DAA3d7BcPU"
dc.Font = Enum.Font.Gotham
dc.TextScaled = true
dc.TextColor3 = Color3.fromRGB(160,160,160)

-- CLOSE BUTTON (X)
local closeBtn = Instance.new("TextButton", top)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,7)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
end)

-- SPEED LABEL
local speedLabel = Instance.new("TextLabel", main)
speedLabel.Position = UDim2.new(0.1,0,0.35,0)
speedLabel.Size = UDim2.new(0.35,0,0,20)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextScaled = true
speedLabel.TextColor3 = Color3.fromRGB(120,170,255)

-- JUMP LABEL
local jumpLabel = Instance.new("TextLabel", main)
jumpLabel.Position = UDim2.new(0.55,0,0.35,0)
jumpLabel.Size = UDim2.new(0.35,0,0,20)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "Jump Power"
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.TextScaled = true
jumpLabel.TextColor3 = Color3.fromRGB(180,120,255)

-- SPEED BOX
local sBox = Instance.new("TextBox", main)
sBox.Size = UDim2.new(0.35,0,0,40)
sBox.Position = UDim2.new(0.1,0,0.45,0)
sBox.Text = speed
sBox.Font = Enum.Font.GothamBold
sBox.TextScaled = true
sBox.TextColor3 = Color3.new(1,1,1)
sBox.BackgroundColor3 = Color3.fromRGB(25,25,30)
Instance.new("UICorner", sBox).CornerRadius = UDim.new(0,12)

-- JUMP BOX
local jBox = Instance.new("TextBox", main)
jBox.Size = UDim2.new(0.35,0,0,40)
jBox.Position = UDim2.new(0.55,0,0.45,0)
jBox.Text = jumpForce
jBox.Font = Enum.Font.GothamBold
jBox.TextScaled = true
jBox.TextColor3 = Color3.new(1,1,1)
jBox.BackgroundColor3 = Color3.fromRGB(25,25,30)
Instance.new("UICorner", jBox).CornerRadius = UDim.new(0,12)

-- TOGGLE BUTTON
local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0.8,0,0,50)
btn.Position = UDim2.new(0.1,0,0.72,0)
btn.Text = "ENABLE BOOST"
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.fromRGB(80,120,255)
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,15)

-- Hover Effect (PC)
btn.MouseEnter:Connect(function()
	TweenService:Create(btn, TweenInfo.new(0.2), {
		BackgroundColor3 = Color3.fromRGB(100,140,255)
	}):Play()
end)

btn.MouseLeave:Connect(function()
	if not speedEnabled then
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(80,120,255)
		}):Play()
	end
end)



-- Speed Logic
local function startSpeed()
	if speedConn then speedConn:Disconnect() end

	speedConn = RunService.RenderStepped:Connect(function()
		if not speedEnabled then return end

		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		if hum then
			hum.WalkSpeed = speed
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

	if speedConn then 
		speedConn:Disconnect() 
	end

	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = 16
	end
end


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

-- OPEN BUTTON (unten links)
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,130,0,45)
openBtn.Position = UDim2.new(0,20,0.5,0)
openBtn.Text = "Sprizan Booster"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextScaled = true
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.BackgroundColor3 = Color3.fromRGB(80,120,255)
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0,15)

openBtn.MouseButton1Click:Connect(function()
	main.Visible = true
end)
