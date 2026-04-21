-- by qwqowo

local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = game.Players.LocalPlayer

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() and self == MarketplaceService then
        if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
            return true 
        end
    end
    return oldNamecall(self, ...)
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Product RauMa"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 280, 0, 160)
Main.Position = UDim2.new(0.5, -140, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Parent = Main

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 70, 0, 70)
Logo.Position = UDim2.new(0.5, -35, 0.15, 0)
Logo.Image = "https://github.com/4nmnnax-prog/wigma/blob/4ee6e8f2ce24650454651448ce548a0f65a529d3/image/raw/script/a/b/c/b.png"
Logo.BackgroundTransparency = 1
Logo.Parent = Main

local Checkmark = Instance.new("ImageLabel")
Checkmark.Size = UDim2.new(0, 45, 0, 45)
Checkmark.Position = UDim2.new(0.5, -22, 0.22, 0)
Checkmark.Image = "https://github.com/4nmnnax-prog/wigma/blob/4ee6e8f2ce24650454651448ce548a0f65a529d3/image/raw/script/a/b/c/a.png"
Checkmark.BackgroundTransparency = 1
Checkmark.ImageTransparency = 1
Checkmark.ZIndex = 5
Checkmark.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Text = "By Qwqowo"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 15
Title.BackgroundTransparency = 1
Title.Parent = Main

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0.7, 0)
Status.Text = "System Idle"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.Font = Enum.Font.Code
Status.TextSize = 13
Status.BackgroundTransparency = 1
Status.Parent = Main

local rotSpeed = 40
RunService.RenderStepped:Connect(function(dt)
    Logo.Rotation = Logo.Rotation + (rotSpeed * dt)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

local function ExecuteBypass(id)
    local oldSpeed = rotSpeed
    rotSpeed = 600

    Status.Text = "Synchronizing: " .. id
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)

    TweenService:Create(Checkmark, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        ImageTransparency = 0,
        Size = UDim2.new(0, 55, 0, 55),
        Position = UDim2.new(0.5, -27, 0.2, 0)
    }):Play()

    MarketplaceService.PromptGamePassPurchaseFinished:Fire(LP, id, true)

    task.wait(2)

    rotSpeed = oldSpeed
    Status.Text = "Established"
    TweenService:Create(Checkmark, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
end

MarketplaceService.PromptGamePassPurchaseRequested:Connect(function(player, id)
    if player == LP then
        ExecuteBypass(id)
    end
end)