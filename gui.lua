local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function Library:CreateWindow(title)
    -- Ana GUI bileşenleri
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local TabContainer = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("Frame")

    -- GUI Ayarları
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "Close"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.Size = UDim2.new(0, 120, 1, -30)
    TabContainer.ScrollBarThickness = 0
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 120, 0, 30)
    ContentContainer.Size = UDim2.new(1, -120, 1, -30)

    -- Kapatma butonu fonksiyonu
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Window = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        local ModuleList = Instance.new("UIListLayout")

        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Tab.Size = UDim2.new(1, -10, 0, 35)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 12
        Tab.AutoButtonColor = false

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = Tab

        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        ModuleList.Parent = TabContent
        ModuleList.SortOrder = Enum.SortOrder.LayoutOrder
        ModuleList.Padding = UDim.new(0, 5)

        -- Tab seçme fonksiyonu
        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                v.Visible = false
            end
            TabContent.Visible = true
        end)

        local TabFunctions = {}

        function TabFunctions:CreateModule(moduleName)
            local Module = Instance.new("Frame")
            local ModuleTitle = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local Slider = Instance.new("Frame")
            local SliderBar = Instance.new("Frame")
            local SliderButton = Instance.new("TextButton")
            local ValueLabel = Instance.new("TextLabel")

            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Module.Size = UDim2.new(1, -20, 0, 80)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Module

            ModuleTitle.Name = "Title"
            ModuleTitle.Parent = Module
            ModuleTitle.BackgroundTransparency = 1
            ModuleTitle.Position = UDim2.new(0, 10, 0, 5)
            ModuleTitle.Size = UDim2.new(1, -80, 0, 25)
            ModuleTitle.Font = Enum.Font.GothamSemibold
            ModuleTitle.Text = moduleName
            ModuleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ModuleTitle.TextSize = 14
            ModuleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleButton.Name = "Toggle"
            ToggleButton.Parent = Module
            ToggleButton.Position = UDim2.new(1, -60, 0, 5)
            ToggleButton.Size = UDim2.new(0, 50, 0, 25)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ToggleButton.Font = Enum.Font.GothamBold
            ToggleButton.Text = "OFF"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 12

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = ToggleButton

            Slider.Name = "Slider"
            Slider.Parent = Module
            Slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Slider.Position = UDim2.new(0, 10, 0, 40)
            Slider.Size = UDim2.new(1, -20, 0, 30)

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = Slider

            SliderBar.Name = "Bar"
            SliderBar.Parent = Slider
            SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderBar.Size = UDim2.new(0.5, 0, 1, 0)

            local UICorner_4 = Instance.new("UICorner")
            UICorner_4.CornerRadius = UDim.new(0, 4)
            UICorner_4.Parent = SliderBar

            SliderButton.Name = "Button"
            SliderButton.Parent = SliderBar
            SliderButton.AnchorPoint = Vector2.new(1, 0.5)
            SliderButton.Position = UDim2.new(1, 0, 0.5, 0)
            SliderButton.Size = UDim2.new(0, 20, 0, 20)
            SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderButton.Text = ""

            local UICorner_5 = Instance.new("UICorner")
            UICorner_5.CornerRadius = UDim.new(1, 0)
            UICorner_5.Parent = SliderButton

            ValueLabel.Name = "Value"
            ValueLabel.Parent = Slider
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Size = UDim2.new(1, 0, 1, 0)
            ValueLabel.Font = Enum.Font.GothamSemibold
            ValueLabel.Text = "50"
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 14

            -- Toggle fonksiyonu
            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                ToggleButton.Text = enabled and "ON" or "OFF"
                ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            end)

            -- Slider fonksiyonu
            local dragging = false
            local function updateSlider(input)
                local pos = UDim2.new(math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1), 0, 1, 0)
                SliderBar.Size = pos
                ValueLabel.Text = math.floor(pos.X.Scale * 100)
            end

            SliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)

            return Module
        end

        return TabFunctions
    end

    return Window
end

return Library
