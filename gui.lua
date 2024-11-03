local Library = {}

function Library:CreateWindow(title)
    -- Ana GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = title
    ScreenGui.Parent = game.CoreGui
    
    -- Ana Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 600)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    -- Gölge Efekti
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 47, 1, 47)
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.Parent = MainFrame
    
    -- Başlık Çubuğu
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    -- Başlık
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.Size = UDim2.new(1, 0, 1, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 18
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Parent = TitleBar
    
    -- Tab Butonları Çerçevesi
    local TabButtons = Instance.new("Frame")
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(0, 150, 1, -40)
    TabButtons.Position = UDim2.new(0, 0, 0, 40)
    TabButtons.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabButtons.BorderSizePixel = 0
    TabButtons.Parent = MainFrame
    
    -- Tab Butonları Liste Düzeni
    local TabButtonList = Instance.new("UIListLayout")
    TabButtonList.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonList.Padding = UDim.new(0, 5)
    TabButtonList.Parent = TabButtons
    
    -- Tab İçerik Alanı
    local TabContent = Instance.new("Frame")
    TabContent.Name = "TabContent"
    TabContent.Size = UDim2.new(1, -160, 1, -50)
    TabContent.Position = UDim2.new(0, 155, 0, 45)
    TabContent.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TabContent.BorderSizePixel = 0
    TabContent.Parent = MainFrame
    
    local Window = {}
    local Tabs = {}
    local CurrentTab = nil
    
    function Window:AddTab(name)
        -- Tab Butonu
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Position = UDim2.new(0, 5, 0, 5)
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Parent = TabButtons
        
        -- Tab Frame
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Name = name
        TabFrame.Size = UDim2.new(1, -20, 1, -20)
        TabFrame.Position = UDim2.new(0, 10, 0, 10)
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.ScrollBarThickness = 2
        TabFrame.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 80)
        TabFrame.Visible = false
        TabFrame.Parent = TabContent
        
        -- Tab İçerik Liste Düzeni
        local TabList = Instance.new("UIListLayout")
        TabList.SortOrder = Enum.SortOrder.LayoutOrder
        TabList.Padding = UDim.new(0, 10)
        TabList.Parent = TabFrame
        
        local Tab = {}
        
        -- Tab Seçme Fonksiyonu
        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Visible = false
            end
            TabFrame.Visible = true
            CurrentTab = TabFrame
            
            -- Buton Animasyonu
            for _, button in pairs(TabButtons:GetChildren()) do
                if button:IsA("TextButton") then
                    game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {
                        BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                    }):Play()
                end
            end
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            }):Play()
        end)
        
        -- İlk Tab'ı Otomatik Seç
        if #Tabs == 0 then
            TabFrame.Visible = true
            CurrentTab = TabFrame
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            }):Play()
        end
        
        function Tab:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 0, 35)
            Button.Position = UDim2.new(0, 10, 0, 0)
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Button.BorderSizePixel = 0
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabFrame
            
            -- Buton Hover Efekti
            Button.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                callback()
            end)
        end
        
        function Tab:AddToggle(text, default, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 20, 0, 20)
            ToggleButton.Position = UDim2.new(0, 10, 0.5, -10)
            ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 60, 60)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            local ToggleText = Instance.new("TextLabel")
            ToggleText.Size = UDim2.new(1, -50, 1, 0)
            ToggleText.Position = UDim2.new(0, 40, 0, 0)
            ToggleText.BackgroundTransparency = 1
            ToggleText.Text = text
            ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleText.TextSize = 14
            ToggleText.Font = Enum.Font.Gotham
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            ToggleText.Parent = ToggleFrame
            
            local enabled = default
            
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                game:GetService("TweenService"):Create(ToggleButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 60, 60)
                }):Play()
                callback(enabled)
            end)
        end
        
        function Tab:AddSlider(text, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -20, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabFrame
            
            local SliderText = Instance.new("TextLabel")
            SliderText.Size = UDim2.new(1, -20, 0, 20)
            SliderText.Position = UDim2.new(0, 10, 0, 5)
            SliderText.BackgroundTransparency = 1
            SliderText.Text = text .. ": " .. default
            SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderText.TextSize = 14
            SliderText.Font = Enum.Font.Gotham
            SliderText.TextXAlignment = Enum.TextXAlignment.Left
            SliderText.Parent = SliderFrame
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -20, 0, 4)
            SliderBar.Position = UDim2.new(0, 10, 0, 35)
            SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(0, 10, 0, 20)
            SliderButton.Position = UDim2.new((default - min)/(max - min), -5, 0, -8)
            SliderButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
            SliderButton.BorderSizePixel = 0
            SliderButton.Text = ""
            SliderButton.Parent = SliderBar
            
            local dragging = false
            
            SliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("RunService").RenderStepped:Connect(function()
                if dragging then
                    local mouse = game:GetService("UserInputService"):GetMouseLocation()
                    local percent = math.clamp((mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + ((max - min) * percent))
                    
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderButton.Position = UDim2.new(percent, -5, 0, -8)
                    SliderText.Text = text .. ": " .. value
                    
                    callback(value)
                end
            end)
        end
        
        table.insert(Tabs, Tab)
        return Tab
    end
    
    return Window
end

return Library
