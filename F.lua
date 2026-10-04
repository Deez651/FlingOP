local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local enabled = false
local movel = 0.1

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NinjaGO"
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game.CoreGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 80)
Title.Position = UDim2.new(0.5, -200, 0.5, -40)
Title.BackgroundTransparency = 1
Title.Text = "ninja"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 52
Title.Parent = LoadingFrame

local GoLabel = Instance.new("TextLabel")
GoLabel.Size = UDim2.new(0, 120, 0, 80)
GoLabel.Position = UDim2.new(0.5, 40, 0.5, -40)
GoLabel.BackgroundTransparency = 1
GoLabel.Text = "GO"
GoLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
GoLabel.Font = Enum.Font.GothamBlack
GoLabel.TextSize = 52
GoLabel.Parent = LoadingFrame

task.wait(1.2)

local Rocket = Instance.new("TextLabel")
Rocket.Size = UDim2.new(0, 60, 0, 60)
Rocket.Position = GoLabel.Position
Rocket.BackgroundTransparency = 1
Rocket.Text = "🚀"
Rocket.TextSize = 48
Rocket.Parent = LoadingFrame

GoLabel:Destroy()

local flyTween = TweenService:Create(Rocket, TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
    Position = UDim2.new(0.5, 300, 0.5, -400),
    TextTransparency = 1
})
flyTween:Play()
flyTween.Completed:Wait()

local fade = TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
fade:Play()
fade.Completed:Wait()
LoadingFrame:Destroy()

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 50)
MainFrame.Position = UDim2.new(0, 20, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, 0, 1, 0)
Button.BackgroundTransparency = 1
Button.Text = "Touch Fling: OFF"
Button.TextColor3 = Color3.fromRGB(255, 80, 80)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.Parent = MainFrame

Button.MouseButton1Click:Connect(function()
    enabled = not enabled
    Button.Text = enabled and "Touch Fling: ON" or "Touch Fling: OFF"
    Button.TextColor3 = enabled and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 80, 80)
end)

coroutine.wrap(function()
    local character, hrp, vel
    while true do
        RunService.Heartbeat:Wait()
        if enabled then
            character = LocalPlayer.Character
            hrp = character and character:FindFirstChild("HumanoidRootPart")
            if hrp then
                vel = hrp.Velocity
                hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                RunService.RenderStepped:Wait()
                if hrp and hrp.Parent then
                    hrp.Velocity = vel
                end
                RunService.Stepped:Wait()
                if hrp and hrp.Parent then
                    hrp.Velocity = vel + Vector3.new(0, movel, 0)
                    movel = -movel
                end
            end
        end
    end
end)()
