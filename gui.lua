local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

-- Renk Teması
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),
    DarkContrast = Color3.fromRGB(35, 35, 45),
    LightContrast = Color3.fromRGB(45, 45, 55),
    TextColor = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(0, 170, 255)
}

-- Yardımcı Fonksiyonlar
local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    return instance
end

local function Tween(object, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    game:GetService("TweenService"):Create(object, tweenInfo, properties):Play()
end

-- Ana Window Sınıfı
function GuiLibrary.new(title)
    local Window = {}
    setmetatable(Window, GuiLibrary)
    
    -- Ana GUI
    Window.ScreenGui = CreateInstance("ScreenGui", {
        Name = "ModernUI",
        Parent = game.CoreGui
    })
    
    -- Ana Frame
    Window.MainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = Window.ScreenGui
    })
    
    -- Üst Bar
    Window.TopBar = CreateInstance("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = Theme.DarkContrast,
        BorderSizePixel = 0,
        Parent = Window.MainFrame
    })
    
    -- Başlık
    Window.Title = CreateInstance("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.TextColor,
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Window.TopBar
    })
    
    -- Tab Container
    Window.TabContainer = CreateInstance("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 150, 1, -30),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Theme.DarkContrast,
        BorderSizePixel = 0,
        Parent = Window.MainFrame
    })
    
    -- Tab Content
    Window.TabContent = CreateInstance("Frame", {
        Name = "TabContent",
        Size = UDim2.new(1, -150, 1, -30),
        Position = UDim2.new(0, 150, 0, 30),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Parent = Window.MainFrame
    })
    
    -- Sürükleme Özelliği
    local dragging
    local dragInput
    local dragStart
    local startPos

    Window.TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.MainFrame.Position
        end
    end)

    Window.TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            Window.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Tab Sistemi
    Window.Tabs = {}
    Window.ActiveTab = nil
    
    function Window:Tab(name)
        local Tab = {}
        
        -- Tab Butonu
        Tab.Button = CreateInstance("TextButton", {
            Name = name.."Tab",
            Size = UDim2.new(1, 0, 0, 35),
            Position = UDim2.new(0, 0, 0, #Window.Tabs * 35),
            BackgroundColor3 = Theme.LightContrast,
            BorderSizePixel = 0,
            Text = name,
            TextColor3 = Theme.TextColor,
            TextSize = 14,
            Font = Enum.Font.GothamSemibold,
            Parent = Window.TabContainer
        })
        
        -- Tab İçerik
        Tab.Content = CreateInstance("ScrollingFrame", {
            Name = name.."Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            Visible = false,
            Parent = Window.TabContent
        })
        
        -- Section Sistemi
        function Tab:Section(name)
            local Section = {}
            
            Section.Container = CreateInstance("Frame", {
                Name = name.."Section",
                Size = UDim2.new(0.5, -10, 0, 200),
                BackgroundColor3 = Theme.DarkContrast,
                BorderSizePixel = 0,
                Parent = Tab.Content
            })
            
            Section.Title = CreateInstance("TextLabel", {
                Size = UDim2.new(1, 0, 0, 25),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = Theme.TextColor,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                Parent = Section.Container
            })
            
            -- Toggle Element
            function Section:Toggle(name, default, callback)
                local Toggle = {}
                
                Toggle.Button = CreateInstance("TextButton", {
                    Size = UDim2.new(0.9, 0, 0, 30),
                    Position = UDim2.new(0.05, 0, 0, #Section.Container:GetChildren() * 35),
                    BackgroundColor3 = Theme.LightContrast,
                    BorderSizePixel = 0,
                    Text = name,
                    TextColor3 = Theme.TextColor,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    Parent = Section.Container
                })
                
                Toggle.Status = CreateInstance("Frame", {
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0.9, -25, 0.5, -10),
                    BackgroundColor3 = default and Theme.AccentColor or Color3.fromRGB(255, 50, 50),
                    BorderSizePixel = 0,
                    Parent = Toggle.Button
                })
                
                local enabled = default
                Toggle.Button.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    Toggle.Status.BackgroundColor3 = enabled and Theme.AccentColor or Color3.fromRGB(255, 50, 50)
                    callback(enabled)
                end)
                
                return Toggle
            end
            
            -- Slider Element
            function Section:Slider(name, min, max, default, callback)
                local Slider = {}
                
                Slider.Container = CreateInstance("Frame", {
                    Size = UDim2.new(0.9, 0, 0, 50),
                    Position = UDim2.new(0.05, 0, 0, #Section.Container:GetChildren() * 55),
                    BackgroundTransparency = 1,
                    Parent = Section.Container
                })
                
                Slider.Label = CreateInstance("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = name..": "..default,
                    TextColor3 = Theme.TextColor,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    Parent = Slider.Container
                })
                
                Slider.Bar = CreateInstance("TextBox", {
                    Size = UDim2.new(1, 0, 0, 25),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = Theme.LightContrast,
                    BorderSizePixel = 0,
                    Text = default,
                    TextColor3 = Theme.TextColor,
                    TextSize = 14,
                    Font = Enum.Font.Gotham,
                    Parent = Slider.Container
                })
                
                Slider.Bar.FocusLost:Connect(function()
                    local num = tonumber(Slider.Bar.Text)
                    if num then
                        num = math.clamp(num, min, max)
                        Slider.Bar.Text = num
                        Slider.Label.Text = name..": "..num
                        callback(num)
                    end
                end)
                
                return Slider
            end
            
            return Section
        end
        
        -- Tab Değiştirme
        Tab.Button.MouseButton1Click:Connect(function()
            if Window.ActiveTab then
                Window.ActiveTab.Button.BackgroundColor3 = Theme.LightContrast
                Window.ActiveTab.Content.Visible = false
            end
            
            Tab.Button.BackgroundColor3 = Theme.AccentColor
            Tab.Content.Visible = true
            Window.ActiveTab = Tab
        end)
        
        table.insert(Window.Tabs, Tab)
        
        if #Window.Tabs == 1 then
            Tab.Button.BackgroundColor3 = Theme.AccentColor
            Tab.Content.Visible = true
            Window.ActiveTab = Tab
        end
        
        return Tab
    end
    
    -- GUI Toggle
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            Window.ScreenGui.Enabled = not Window.ScreenGui.Enabled
        end
    end)
    
    return Window
end

return GuiLibrary
