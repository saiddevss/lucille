-- UI Library
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(title)
    -- Ana GUI
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabContainer = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local ModuleContainer = Instance.new("Frame")

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "ModernUI"

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.Position = UDim2.new(0.5, -200, 0.5, -150)
    Main.Size = UDim2.new(0, 400, 0, 300)
    Main.Active = true
    Main.Draggable = true

    UICorner.Parent = Main

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHolder.Position = UDim2.new(0, 10, 0, 40)
    TabHolder.Size = UDim2.new(0, 100, 1, -50)

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TabHolder
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
    TabContainer.ScrollBarThickness = 0

    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    ModuleContainer.Name = "ModuleContainer"
    ModuleContainer.Parent = Main
    ModuleContainer.BackgroundTransparency = 1
    ModuleContainer.Position = UDim2.new(0, 120, 0, 40)
    ModuleContainer.Size = UDim2.new(1, -130, 1, -50)

    local Window = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabModules = Instance.new("ScrollingFrame")
        local ModuleList = Instance.new("UIListLayout")

        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Tab.Size = UDim2.new(1, -10, 0, 30)
        Tab.Font = Enum.Font.Gotham
        Tab.Text = name
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 14
        Tab.AutoButtonColor = false

        local UICorner = Instance.new("UICorner")
        UICorner.Parent = Tab

        TabModules.Name = name.."Modules"
        TabModules.Parent = ModuleContainer
        TabModules.BackgroundTransparency = 1
        TabModules.Size = UDim2.new(1, 0, 1, 0)
        TabModules.ScrollBarThickness = 4
        TabModules.Visible = false

        ModuleList.Parent = TabModules
        ModuleList.SortOrder = Enum.SortOrder.LayoutOrder
        ModuleList.Padding = UDim.new(0, 5)

        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ModuleContainer:GetChildren()) do
                v.Visible = false
            end
            TabModules.Visible = true
        end)

        local TabFunctions = {}

        function TabFunctions:CreateModule(moduleName)
            local Module = Instance.new("Frame")
            local ModuleTitle = Instance.new("TextLabel")
            local ModuleToggle = Instance.new("TextButton")
            local Slider = Instance.new("Frame")
            local SliderButton = Instance.new("TextButton")
            local SliderValue = Instance.new("TextLabel")

            Module.Name = moduleName
            Module.Parent = TabModules
            Module.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Module.Size = UDim2.new(1, -10, 0, 70)

            local UICorner = Instance.new("UICorner")
            UICorner.Parent = Module

            ModuleTitle.Name = "Title"
            ModuleTitle.Parent = Module
            ModuleTitle.BackgroundTransparency = 1
            ModuleTitle.Position = UDim2.new(0, 10, 0, 5)
            ModuleTitle.Size = UDim2.new(1, -20, 0, 20)
            ModuleTitle.Font = Enum.Font.Gotham
            ModuleTitle.Text = moduleName
            ModuleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ModuleTitle.TextSize = 14
            ModuleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ModuleToggle.Name = "Toggle"
            ModuleToggle.Parent = Module
            ModuleToggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            ModuleToggle.Position = UDim2.new(1, -60, 0, 5)
            ModuleToggle.Size = UDim2.new(0, 50, 0, 20)
            ModuleToggle.Font = Enum.Font.Gotham
            ModuleToggle.Text = "OFF"
            ModuleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ModuleToggle.TextSize = 12

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.Parent = ModuleToggle

            Slider.Name = "Slider"
            Slider.Parent = Module
            Slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Slider.Position = UDim2.new(0, 10, 0, 35)
            Slider.Size = UDim2.new(1, -20, 0, 25)

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.Parent = Slider

            SliderButton.Name = "SliderButton"
            SliderButton.Parent = Slider
            SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderButton.Size = UDim2.new(0, 25, 1, 0)
            SliderButton.Text = ""

            local UICorner_4 = Instance.new("UICorner")
            UICorner_4.Parent = SliderButton

            SliderValue.Name = "Value"
            SliderValue.Parent = Slider
            SliderValue.BackgroundTransparency = 1
            SliderValue.Size = UDim2.new(1, 0, 1, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = "50"
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14

            -- Toggle functionality
            local enabled = false
            ModuleToggle.MouseButton1Click:Connect(function()
                enabled = not enabled
                ModuleToggle.Text = enabled and "ON" or "OFF"
                ModuleToggle.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            end)

            -- Slider functionality
            local dragging = false
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
                    local mousePos = UserInputService:GetMouseLocation()
                    local sliderPos = Slider.AbsolutePosition
                    local sliderSize = Slider.AbsoluteSize
                    local percent = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
                    SliderButton.Position = UDim2.new(percent, -12.5, 0, 0)
                    SliderValue.Text = math.floor(percent * 100)
                end
            end)
        end

        return TabFunctions
    end

    return Window
end

return Library
