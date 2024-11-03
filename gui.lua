-- UI Library
local Library = {}

function Library.new(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = title
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 160, 0, 300)
    MainFrame.Position = UDim2.new(0, 10, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Logo ve başlık
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleText = Instance.new("TextLabel")
    TitleText.Text = title
    TitleText.TextColor3 = Color3.fromRGB(255, 128, 0)
    TitleText.TextSize = 18
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Size = UDim2.new(1, -10, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    local TabHolder = {}
    
    function TabHolder:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.Position = UDim2.new(0, 0, 0, #MainFrame:GetChildren() * 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.BorderSizePixel = 0
        TabButton.Parent = MainFrame
        
        local PaddingLeft = Instance.new("UIPadding")
        PaddingLeft.PaddingLeft = UDim.new(0, 10)
        PaddingLeft.Parent = TabButton
        
        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(0, 150, 0, 0)
        ContentFrame.Position = UDim2.new(1.1, 0, 0, TabButton.Position.Y.Offset)
        ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        ContentFrame.BorderSizePixel = 0
        ContentFrame.Visible = false
        ContentFrame.Parent = MainFrame
        
        local ContentHolder = {}
        
        function ContentHolder:AddButton(buttonName, hasExtra)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, 0, 0, 30)
            Button.Position = UDim2.new(0, 0, 0, #ContentFrame:GetChildren() * 30)
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Button.Text = buttonName
            Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.BorderSizePixel = 0
            Button.Parent = ContentFrame
            
            local PaddingLeft = Instance.new("UIPadding")
            PaddingLeft.PaddingLeft = UDim.new(0, 10)
            PaddingLeft.Parent = Button
            
            if hasExtra then
                local ExtraButton = Instance.new("TextButton")
                ExtraButton.Size = UDim2.new(0, 20, 0, 20)
                ExtraButton.Position = UDim2.new(1, -25, 0.5, -10)
                ExtraButton.BackgroundTransparency = 1
                ExtraButton.Text = "..."
                ExtraButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                ExtraButton.TextSize = 14
                ExtraButton.Font = Enum.Font.GothamBold
                ExtraButton.Parent = Button
                
                local ExtraFrame = Instance.new("Frame")
                ExtraFrame.Size = UDim2.new(0, 150, 0, 100)
                ExtraFrame.Position = UDim2.new(1.1, 0, 0, 0)
                ExtraFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ExtraFrame.BorderSizePixel = 0
                ExtraFrame.Visible = false
                ExtraFrame.Parent = Button
                
                -- Slider örneği
                local Slider = Instance.new("Frame")
                Slider.Size = UDim2.new(0.9, 0, 0, 20)
                Slider.Position = UDim2.new(0.05, 0, 0, 10)
                Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Slider.Parent = ExtraFrame
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Size = UDim2.new(0.1, 0, 1, 0)
                SliderButton.BackgroundColor3 = Color3.fromRGB(255, 128, 0)
                SliderButton.Text = ""
                SliderButton.Parent = Slider
                
                -- Mode değiştirme butonu
                local ModeButton = Instance.new("TextButton")
                ModeButton.Size = UDim2.new(0.9, 0, 0, 25)
                ModeButton.Position = UDim2.new(0.05, 0, 0, 40)
                ModeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                ModeButton.Text = "Mode >"
                ModeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                ModeButton.TextSize = 14
                ModeButton.Font = Enum.Font.Gotham
                ModeButton.Parent = ExtraFrame
                
                ExtraButton.MouseButton1Click:Connect(function()
                    ExtraFrame.Visible = not ExtraFrame.Visible
                end)
            end
            
            ContentFrame.Size = UDim2.new(0, 150, 0, #ContentFrame:GetChildren() * 30)
        end
        
        TabButton.MouseButton1Click:Connect(function()
            ContentFrame.Visible = not ContentFrame.Visible
        end)
        
        return ContentHolder
    end
    
    return TabHolder
end

-- Kullanım örneği:
local UI = Library.new("VAPE V4")

local CombatTab = UI:CreateTab("Combat")
CombatTab:AddButton("AimAssist", true)
CombatTab:AddButton("AntiBot", true)
CombatTab:AddButton("AutoClicker", true)
CombatTab:AddButton("Combat Settings", true)

local MovementTab = UI:CreateTab("Movement")
MovementTab:AddButton("Eagle", true)
MovementTab:AddButton("MoveFix", false)
MovementTab:AddButton("Sprint", true)

local PlayerTab = UI:CreateTab("Player")
PlayerTab:AddButton("AutoArmor", true)
PlayerTab:AddButton("ChestStealer", false)
PlayerTab:AddButton("SlotHandler", true)
