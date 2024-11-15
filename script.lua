local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game:GetService("CoreGui")
 
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.4, 0)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui
 
local frameUICorner = Instance.new("UICorner")
frameUICorner.CornerRadius = UDim.new(0.1, 0)
frameUICorner.Parent = frame
 
local frameGradient = Instance.new("UIGradient")
frameGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
}
frameGradient.Parent = frame
 
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.2, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "MM2 duping thingy"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 22
textLabel.Font = Enum.Font.GothamBold
textLabel.TextStrokeTransparency = 0.8
textLabel.Parent = frame
 
local itemTextBox1 = Instance.new("TextBox")
itemTextBox1.Size = UDim2.new(0.75, 0, 0.15, 0)
itemTextBox1.Position = UDim2.new(0.125, 0, 0.3, 0)
itemTextBox1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
itemTextBox1.PlaceholderText = "name to dupe"
itemTextBox1.TextColor3 = Color3.fromRGB(255, 255, 255)
itemTextBox1.TextSize = 15
itemTextBox1.Font = Enum.Font.Gotham
itemTextBox1.Parent = frame
 
local itemTextBoxUICorner1 = Instance.new("UICorner")
itemTextBoxUICorner1.CornerRadius = UDim.new(0.1, 0)
itemTextBoxUICorner1.Parent = itemTextBox1
 
local itemTextBox2 = Instance.new("TextBox")
itemTextBox2.Size = UDim2.new(0.75, 0, 0.15, 0)
itemTextBox2.Position = UDim2.new(0.125, 0, 0.5, 0)
itemTextBox2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
itemTextBox2.PlaceholderText = "amount"
itemTextBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
itemTextBox2.TextSize = 15
itemTextBox2.Font = Enum.Font.Gotham
itemTextBox2.Parent = frame
 
local itemTextBoxUICorner2 = Instance.new("UICorner")
itemTextBoxUICorner2.CornerRadius = UDim.new(0.1, 0)
itemTextBoxUICorner2.Parent = itemTextBox2
 
local spawnButton = Instance.new("TextButton")
spawnButton.Size = UDim2.new(0.75, 0, 0.15, 0)
spawnButton.Position = UDim2.new(0.125, 0, 0.7, 0)
spawnButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
spawnButton.Text = "Spawn"
spawnButton.TextSize = 18
spawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnButton.Font = Enum.Font.Gotham
spawnButton.Parent = frame
 
local spawnButtonUICorner = Instance.new("UICorner")
spawnButtonUICorner.CornerRadius = UDim.new(0.1, 0)
spawnButtonUICorner.Parent = spawnButton
 
local function buttonHoverEffect(button)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    end)
 
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
 
    button.MouseButton1Click:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
end
 
buttonHoverEffect(spawnButton)
 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
local UIPath
 
if LocalPlayer.PlayerGui.MainGUI.Game:FindFirstChild("Inventory") ~= nil then
    UIPath = LocalPlayer.PlayerGui.MainGUI.Game.Inventory.Main
else
    UIPath = LocalPlayer.PlayerGui.MainGUI.Lobby.Screens.Inventory.Main
end
 
local function VisualDupe(knifeName, dupeAmount)
    dupeAmount = tonumber(dupeAmount) or 2
    for _, v in pairs(UIPath.Weapons.Items.Container:GetChildren()) do
        for _, v in pairs(v.Container:GetChildren()) do
            if v.Name == "Christmas" or v.Name == "Halloween" then
                for _, itemFrame in pairs(v.Container:GetChildren()) do
                    if itemFrame:IsA("Frame") and itemFrame.ItemName.Label.Text == knifeName then
                        local currentAmount = itemFrame.Container.Amount.Text
                        local num = tonumber(currentAmount:match("x(%d+)")) or 1
                        itemFrame.Container.Amount.Text = "x" .. tostring(num + dupeAmount)
                    end
                end
            else
                if v:IsA("Frame") and v.ItemName.Label.Text == knifeName then
                    local currentAmount = v.Container.Amount.Text
                    local num = tonumber(currentAmount:match("x(%d+)")) or 1
                    v.Container.Amount.Text = "x" .. tostring(num + dupeAmount)
                end
            end
        end
    end
end
 
spawnButton.MouseButton1Click:Connect(function()
    local knifeToDupe = itemTextBox1.Text
    local dupeAmount = tonumber(itemTextBox2.Text) or 1
    VisualDupe(knifeToDupe, dupeAmount)
end)
 
local dragging, dragInput, dragStart, startPos
 
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)
 
frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
 
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
