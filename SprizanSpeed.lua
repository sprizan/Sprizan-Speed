-- SPRIZAN BOOSTER
-- discord.gg/DAA3d7BcPU

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local humanoid

local function setupChar(char)
	humanoid = char:WaitForChild("Humanoid")
end

if player.Character then
	setupChar(player.Character)
end
player.CharacterAdded:Connect(setupChar)

--------------------------------------------------
-- INTRO (NO IMAGE / NO BLACKSCREEN)
--------------------------------------------------
local introGui = Instance.new("ScreenGui", player.PlayerGui)
introGui.IgnoreGuiInset = true

local bg = Instance.new("Frame", introGui)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(15,10,30)

local grad = Instance.new("UIGradient", bg)
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(140,100,255)), -- violet
	ColorSequenceKeypoint.new(1, Color3.fromRGB(120,180,255))  -- blue
}

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1,0,0,160)
title.Position = UDim2.new(0,0,0.38,0)
title.Text = "SPRIZAN BOOSTER"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1

local dc = Instance.new("TextLabel", bg)
dc.Size = UDim2.new(1,0,0,50)
dc.Position = UDim2.new(0,0,0.58,0)
dc.Text = "discord.gg/DAA3d7BcPU"
dc.Font = Enum.Font.GothamBold
dc.TextScaled = true
dc.TextColor3 = Color3.fromRGB(220,230,255)
dc.BackgroundTransparency = 1

task.wait(2.5)
introGui:Destroy()

--------------------------------------------------
-- MAIN UI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,360,0,280)
main.Position = UDim2.new(0.5,-180,0.5,-140)
main.BackgroundColor3 = Color3.fromRGB(22,18,40)
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16)

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
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function()
	dragging = false
end)

--------------------------------------------------
-- HEADER
--------------------------------------------------
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1,0,0,40)
header.Text = "Sprizan Booster"
header.Font = Enum.Font.GothamBlack
header.TextScaled = true
header.TextColor3 = Color3.fromRGB(230,230,255)
header.BackgroundTransparency = 1

--------------------------------------------------
-- SPEED
--------------------------------------------------
local speedValue = 16

local speedLabel = Instance.new("TextLabel", main)
speedLabel.Position = UDim2.new(0.08,0,0.22,0)
speedLabel.Size = UDim2.new(0.84,0,0,22)
speedLabel.Text = "Speed (recommended 20–35)"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextScaled = true
speedLabel.TextColor3 = Color3.fromRGB(200,200,255)
speedLabel.BackgroundTransparency = 1

local speedBox = Instance.new("TextBox", main)
speedBox.Position = UDim2.new(0.08,0,0.30,0)
speedBox.Size = UDim2.new(0.84,0,0,38)
speedBox.PlaceholderText = "Example: 25"
speedBox.Font = Enum.Font.GothamBold
speedBox.TextScaled = true
speedBox.BackgroundColor3 = Color3.fromRGB(30,26,60)
speedBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedBox)

--------------------------------------------------
-- APPLY
--------------------------------------------------
local apply = Instance.new("TextButton", main)
apply.Position = UDim2.new(0.08,0,0.62,0)
apply.Size = UDim2.new(0.84,0,0,44)
apply.Text = "APPLY SPEED"
apply.Font = Enum.Font.GothamBlack
apply.TextScaled = true
apply.TextColor3 = Color3.new(1,1,1)
apply.BackgroundColor3 = Color3.fromRGB(120,90,255)
Instance.new("UICorner", apply)

apply.MouseButton1Click:Connect(function()
	local s = tonumber(speedBox.Text)
	if s and s >= 0 and s <= 50 then
		speedValue = s
	end
end)

--------------------------------------------------
-- FORCE SPEED (OLD WORKING METHOD)
--------------------------------------------------
RunService.RenderStepped:Connect(function()
	if humanoid then
		humanoid.WalkSpeed = speedValue
	end
end)

--------------------------------------------------
-- UI TOGGLE
--------------------------------------------------
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,56,0,56)
toggle.Position = UDim2.new(0.02,0,0.5,-28)
toggle.Text = "SB"
toggle.Font = Enum.Font.GothamBlack
toggle.TextScaled = true
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(120,90,255)
Instance.new("UICorner", toggle)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)



