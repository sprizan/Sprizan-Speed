--[[ 
    SPRIZAN BOOSTER HUB
    discord.gg/DAA3d7BcPU
    Mobile + PC Friendly
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

--------------------------------------------------
-- FULLSCREEN INTRO (3 SEKUNDEN – KRASSER DROP)
--------------------------------------------------
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false

local bg = Instance.new("Frame", introGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(5,0,15)

local logo = Instance.new("ImageLabel", bg)
logo.Size = UDim2.new(0,520,0,520)
logo.Position = UDim2.new(0.5,-260,0.5,-260)
logo.BackgroundTransparency = 1
logo.ImageTransparency = 1
logo.Image = "rbxassetid://130728400704043"

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1,0,0,120)
title.Position = UDim2.new(0,0,0.72,0)
title.BackgroundTransparency = 1
title.Text = "SPRIZAN BOOSTER"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextTransparency = 1
title.TextColor3 = Color3.fromRGB(200,140,255)

local dcIntro = Instance.new("TextLabel", bg)
dcIntro.Size = UDim2.new(1,0,0,50)
dcIntro.Position = UDim2.new(0,0,0.88,0)
dcIntro.BackgroundTransparency = 1
dcIntro.Text = "discord.gg/DAA3d7BcPU"
dcIntro.Font = Enum.Font.GothamBold
dcIntro.TextScaled = true
dcIntro.TextTransparency = 1
dcIntro.TextColor3 = Color3.fromRGB(160,120,255)

local dropSound = Instance.new("Sound", bg)
dropSound.SoundId = "rbxassetid://1843529636"
dropSound.Volume = 1
dropSound:Play()

TweenService:Create(logo, TweenInfo.new(0.6, Enum.EasingStyle.Back), {ImageTransparency = 0}):Play()
TweenService:Create(title, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
TweenService:Create(dcIntro, TweenInfo.new(0.6), {TextTransparency = 0}):Play()

task.wait(3)

TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(logo, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(dcIntro, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

task.wait(0.6)
introGui:Destroy()

--------------------------------------------------
-- MAIN UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,340,0,300)
main.Position = UDim2.new(0.5,-170,0.5,-150)
main.BackgroundColor3 = Color3.fromRGB(15,10,30)
main.Active = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

--------------------------------------------------
-- GRADIENT GLOW
--------------------------------------------------
local grad = Instance.new("UIGradient", main)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120,80,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(60,30,120))
}

task.spawn(function()
	while true do
		grad.Rotation += 1
		task.wait(0.03)
	end
end)

--------------------------------------------------
-- TOP BAR + DRAG
--------------------------------------------------
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundTransparency = 1

local title2 = Instance.new("TextLabel", top)
title2.Size = UDim2.new(1,0,1,0)
title2.Text = "Sprizan Booster"
title2.Font = Enum.Font.GothamBlack
title2.TextScaled = true
title2.TextColor3 = Color3.fromRGB(220,180,255)
title2.BackgroundTransparency = 1

-- Drag (Mobile + PC)
local dragging, dragStart, startPos
top.InputBegan:Connect(function(i)
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
-- SPEED INPUT
--------------------------------------------------
local speedBox = Instance.new("TextBox", main)
speedBox.Size = UDim2.new(0.85,0,0,40)
speedBox.Position = UDim2.new(0.075,0,0.25,0)
speedBox.PlaceholderText = "Speed (Max 50)"
speedBox.Font = Enum.Font.GothamBold
speedBox.TextScaled = true
speedBox.BackgroundColor3 = Color3.fromRGB(20,15,40)
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedBox)

--------------------------------------------------
-- JUMP INPUT
--------------------------------------------------
local jumpBox = Instance.new("TextBox", main)
jumpBox.Size = UDim2.new(0.85,0,0,40)
jumpBox.Position = UDim2.new(0.075,0,0.42,0)
jumpBox.PlaceholderText = "Jump (Max 120)"
jumpBox.Font = Enum.Font.GothamBold
jumpBox.TextScaled = true
jumpBox.BackgroundColor3 = Color3.fromRGB(20,15,40)
jumpBox.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", jumpBox)

--------------------------------------------------
-- APPLY BUTTON
--------------------------------------------------
local apply = Instance.new("TextButton", main)
apply.Size = UDim2.new(0.85,0,0,45)
apply.Position = UDim2.new(0.075,0,0.62,0)
apply.Text = "APPLY BOOST"
apply.Font = Enum.Font.GothamBlack
apply.TextScaled = true
apply.TextColor3 = Color3.fromRGB(255,255,255)
apply.BackgroundColor3 = Color3.fromRGB(130,90,255)
Instance.new("UICorner", apply)

local clickSound = Instance.new("Sound", apply)
clickSound.SoundId = "rbxassetid://9118823101"
clickSound.Volume = 0.8

apply.MouseButton1Click:Connect(function()
	clickSound:Play()

	local spd = tonumber(speedBox.Text)
	local jmp = tonumber(jumpBox.Text)

	if spd and spd >= 0 and spd <= 50 then
		hum.WalkSpeed = spd
	end

	if jmp and jmp >= 0 and jmp <= 120 then
		hum.JumpPower = jmp
	end
end)

--------------------------------------------------
-- UI TOGGLE BUTTON
--------------------------------------------------
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0,60,0,60)
toggleBtn.Position = UDim2.new(0.02,0,0.5,-30)
toggleBtn.Text = "SB"
toggleBtn.Font = Enum.Font.GothamBlack
toggleBtn.TextScaled = true
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BackgroundColor3 = Color3.fromRGB(120,80,255)
Instance.new("UICorner", toggleBtn)

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

--------------------------------------------------
-- DISCORD FOOTER
--------------------------------------------------
local dcFooter = Instance.new("TextLabel", main)
dcFooter.Size = UDim2.new(1,0,0,30)
dcFooter.Position = UDim2.new(0,0,1,-30)
dcFooter.Text = "discord.gg/DAA3d7BcPU"
dcFooter.Font = Enum.Font.GothamBold
dcFooter.TextScaled = true
dcFooter.TextColor3 = Color3.fromRGB(170,130,255)
dcFooter.BackgroundTransparency = 1


