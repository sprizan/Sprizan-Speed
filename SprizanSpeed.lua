-- SPRIZAN BOOSTER
-- discord.gg/DAA3d7BcPU

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
end)

--------------------------------------------------
-- INTRO (NO IMAGE = NO BLACKSCREEN)
--------------------------------------------------
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.IgnoreGuiInset = true

local introFrame = Instance.new("Frame", introGui)
introFrame.Size = UDim2.new(1,0,1,0)
introFrame.BackgroundColor3 = Color3.fromRGB(15,10,30)

local title = Instance.new("TextLabel", introFrame)
title.Size = UDim2.new(1,0,0,200)
title.Position = UDim2.new(0,0,0.4,0)
title.Text = "SPRIZAN BOOSTER"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(200,160,255)
title.BackgroundTransparency = 1

local dc = Instance.new("TextLabel", introFrame)
dc.Size = UDim2.new(1,0,0,60)
dc.Position = UDim2.new(0,0,0.6,0)
dc.Text = "discord.gg/DAA3d7BcPU"
dc.Font = Enum.Font.GothamBold
dc.TextScaled = true
dc.TextColor3 = Color3.fromRGB(160,130,255)
dc.BackgroundTransparency = 1

local introSound = Instance.new("Sound", introFrame)
introSound.SoundId = "rbxassetid://1843529636"
introSound.Volume = 1
introSound:Play()

task.wait(3)
introGui:Destroy()

--------------------------------------------------
-- MAIN UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,360,0,320)
main.Position = UDim2.new(0.5,-180,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(20,15,40)
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

--------------------------------------------------
-- DRAG (MOBILE + PC)
--------------------------------------------------
local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local delta = i.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function()
	dragging = false
end)

--------------------------------------------------
-- TITLE
--------------------------------------------------
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1,0,0,45)
header.Text = "Sprizan Booster"
header.Font = Enum.Font.GothamBlack
header.TextScaled = true
header.TextColor3 = Color3.fromRGB(220,180,255)
header.BackgroundTransparency = 1

--------------------------------------------------
-- SPEED
--------------------------------------------------
local speedValue = 16

local speedLabel = Instance.new("TextLabel", main)
speedLabel.Position = UDim2.new(0.08,0,0.18,0)
speedLabel.Size = UDim2.new(0.84,0,0,25)
speedLabel.Text = "Speed (0 - 50)"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextScaled = true
speedLabel.TextColor3 = Color3.fromRGB(200,200,255)
speedLabel.BackgroundTransparency = 1

local speedBox = Instance.new("TextBox", main)
speedBox.Position = UDim2.new(0.08,0,0.26,0)
speedBox.Size = UDim2.new(0.84,0,0,40)
speedBox.PlaceholderText = "Example: 25"
speedBox.Text = ""
speedBox.Font = Enum.Font.GothamBold
speedBox.TextScaled = true
speedBox.BackgroundColor3 = Color3.fromRGB(30,25,60)
speedBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedBox)

--------------------------------------------------
-- JUMP
--------------------------------------------------
local jumpValue = 50

local jumpLabel = Instance.new("TextLabel", main)
jumpLabel.Position = UDim2.new(0.08,0,0.42,0)
jumpLabel.Size = UDim2.new(0.84,0,0,25)
jumpLabel.Text = "Jump Power (0 - 120)"
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.TextScaled = true
jumpLabel.TextColor3 = Color3.fromRGB(200,200,255)
jumpLabel.BackgroundTransparency = 1

local jumpBox = Instance.new("TextBox", main)
jumpBox.Position = UDim2.new(0.08,0,0.50,0)
jumpBox.Size = UDim2.new(0.84,0,0,40)
jumpBox.PlaceholderText = "Example: 80"
jumpBox.Text = ""
jumpBox.Font = Enum.Font.GothamBold
jumpBox.TextScaled = true
jumpBox.BackgroundColor3 = Color3.fromRGB(30,25,60)
jumpBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", jumpBox)

--------------------------------------------------
-- APPLY
--------------------------------------------------
local enabled = true

local apply = Instance.new("TextButton", main)
apply.Position = UDim2.new(0.08,0,0.68,0)
apply.Size = UDim2.new(0.84,0,0,45)
apply.Text = "APPLY BOOST"
apply.Font = Enum.Font.GothamBlack
apply.TextScaled = true
apply.TextColor3 = Color3.new(1,1,1)
apply.BackgroundColor3 = Color3.fromRGB(130,90,255)
Instance.new("UICorner", apply)

apply.MouseButton1Click:Connect(function()
	local s = tonumber(speedBox.Text)
	local j = tonumber(jumpBox.Text)

	if s and s >= 0 and s <= 50 then
		speedValue = s
	end
	if j and j >= 0 and j <= 120 then
		jumpValue = j
	end
end)

--------------------------------------------------
-- FORCE APPLY (THIS IS WHY IT WORKS)
--------------------------------------------------
RunService.RenderStepped:Connect(function()
	if enabled and humanoid then
		humanoid.WalkSpeed = speedValue
		humanoid.JumpPower = jumpValue
	end
end)

--------------------------------------------------
-- UI TOGGLE
--------------------------------------------------
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,60,0,60)
toggle.Position = UDim2.new(0.02,0,0.5,-30)
toggle.Text = "SB"
toggle.Font = Enum.Font.GothamBlack
toggle.TextScaled = true
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(120,80,255)
Instance.new("UICorner", toggle)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)


