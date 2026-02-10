-- SPRIZAN BOOSTER (FIXED)
-- discord.gg/DAA3d7BcPU

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

--------------------------------------------------
-- SAFE CHARACTER HANDLING
--------------------------------------------------
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

player.CharacterAdded:Connect(function()
	task.wait(1)
	humanoid = getHumanoid()
end)

--------------------------------------------------
-- INTRO (NO BLACKSCREEN GUARANTEE)
--------------------------------------------------
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.IgnoreGuiInset = true

local bg = Instance.new("Frame", introGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(10,5,25)

local glow = Instance.new("UIGradient", bg)
glow.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120,80,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40,20,80))
}

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1,0,0,150)
title.Position = UDim2.new(0,0,0.4,0)
title.Text = "SPRIZAN BOOSTER"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(220,180,255)
title.BackgroundTransparency = 1

local dc = Instance.new("TextLabel", bg)
dc.Size = UDim2.new(1,0,0,60)
dc.Position = UDim2.new(0,0,0.6,0)
dc.Text = "discord.gg/DAA3d7BcPU"
dc.Font = Enum.Font.GothamBold
dc.TextScaled = true
dc.TextColor3 = Color3.fromRGB(170,130,255)
dc.BackgroundTransparency = 1

local sound = Instance.new("Sound", bg)
sound.SoundId = "rbxassetid://1843529636"
sound.Volume = 1
sound:Play()

task.wait(3)
introGui:Destroy()

--------------------------------------------------
-- MAIN UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,360,0,330)
main.Position = UDim2.new(0.5,-180,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(18,12,35)
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

--------------------------------------------------
-- DRAG (PC + MOBILE)
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
local title2 = Instance.new("TextLabel", main)
title2.Size = UDim2.new(1,0,0,50)
title2.Text = "Sprizan Booster"
title2.Font = Enum.Font.GothamBlack
title2.TextScaled = true
title2.TextColor3 = Color3.fromRGB(220,180,255)
title2.BackgroundTransparency = 1

--------------------------------------------------
-- SPEED LABEL + BOX
--------------------------------------------------
local speedLabel = Instance.new("TextLabel", main)
speedLabel.Position = UDim2.new(0.08,0,0.2,0)
speedLabel.Size = UDim2.new(0.84,0,0,25)
speedLabel.Text = "Speed (0 – 50)"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextScaled = true
speedLabel.TextColor3 = Color3.fromRGB(200,200,255)
speedLabel.BackgroundTransparency = 1

local speedBox = Instance.new("TextBox", main)
speedBox.Position = UDim2.new(0.08,0,0.28,0)
speedBox.Size = UDim2.new(0.84,0,0,40)
speedBox.PlaceholderText = "z.B. 25"
speedBox.Text = ""
speedBox.Font = Enum.Font.GothamBold
speedBox.TextScaled = true
speedBox.BackgroundColor3 = Color3.fromRGB(25,18,45)
speedBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedBox)

--------------------------------------------------
-- JUMP LABEL + BOX
--------------------------------------------------
local jumpLabel = Instance.new("TextLabel", main)
jumpLabel.Position = UDim2.new(0.08,0,0.43,0)
jumpLabel.Size = UDim2.new(0.84,0,0,25)
jumpLabel.Text = "Jump Boost (0 – 120)"
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.TextScaled = true
jumpLabel.TextColor3 = Color3.fromRGB(200,200,255)
jumpLabel.BackgroundTransparency = 1

local jumpBox = Instance.new("TextBox", main)
jumpBox.Position = UDim2.new(0.08,0,0.51,0)
jumpBox.Size = UDim2.new(0.84,0,0,40)
jumpBox.PlaceholderText = "z.B. 80"
jumpBox.Text = ""
jumpBox.Font = Enum.Font.GothamBold
jumpBox.TextScaled = true
jumpBox.BackgroundColor3 = Color3.fromRGB(25,18,45)
jumpBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", jumpBox)

--------------------------------------------------
-- APPLY BUTTON
--------------------------------------------------
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
	local spd = tonumber(speedBox.Text)
	local jmp = tonumber(jumpBox.Text)

	if spd and spd >= 0 and spd <= 50 then
		humanoid.WalkSpeed = spd
	end

	if jmp and jmp >= 0 and jmp <= 120 then
		humanoid.JumpPower = jmp
		humanoid.JumpHeight = jmp / 2
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


