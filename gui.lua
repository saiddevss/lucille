local Library = {
    Themes = {
        Default = {
            MainColor = Color3.fromRGB(25, 25, 35),
            SecondaryColor = Color3.fromRGB(35, 35, 45),
            AccentColor = Color3.fromRGB(65, 105, 225),
            TextColor = Color3.fromRGB(255, 255, 255)
        },
        Dark = {
            MainColor = Color3.fromRGB(15, 15, 20),
            SecondaryColor = Color3.fromRGB(20, 20, 25),
            AccentColor = Color3.fromRGB(120, 0, 255),
            TextColor = Color3.fromRGB(240, 240, 240)
        }
    },
    CurrentTheme = nil,
    Flags = {}
}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

function Library:CreateWindow(title, theme)
    self.CurrentTheme = self.Themes[theme] or self.Themes.Default

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui

    -- Create Watermark
    local Watermark = Instance.new("Frame")
    Watermark.Name = "Watermark"
    Watermark.Parent = ScreenGui
    Watermark.BackgroundColor3 = self.CurrentTheme.MainColor
    Watermark.Position = UDim2.new(0, 10, 0, 10)
    Watermark.Size = UDim2.new(0, 250, 0, 30)
    Watermark.Active = true
    Watermark.Draggable = true

    local WatermarkCorner = Instance.new("UICorner")
    WatermarkCorner.CornerRadius = UDim.new(0, 4)
    WatermarkCorner.Parent = Watermark

    local WatermarkText = Instance.new("TextLabel")
    WatermarkText.Name = "Text"
    WatermarkText.Parent = Watermark
    WatermarkText.BackgroundTransparency = 1
    WatermarkText.Position = UDim2.new(0, 8, 0, 0)
    WatermarkText.Size = UDim2.new(0, 100, 1, 0)
    WatermarkText.Font = Enum.Font.GothamBold
    WatermarkText.TextColor3 = self.CurrentTheme.TextColor
    WatermarkText.TextSize = 14
    WatermarkText.TextXAlignment = Enum.TextXAlignment.Left

    local FPSLabel = Instance.new("TextLabel")
    FPSLabel.Name = "FPS"
    FPSLabel.Parent = Watermark
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Position = UDim2.new(1, -100, 0, 0)
    FPSLabel.Size = UDim2.new(0, 45, 1, 0)
    FPSLabel.Font = Enum.Font.GothamBold
    FPSLabel.TextColor3 = self.CurrentTheme.TextColor
    FPSLabel.TextSize = 14
    FPSLabel.TextXAlignment = Enum.TextXAlignment.Right

    -- Main GUI
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = self.CurrentTheme.MainColor
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = Main

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = self.CurrentTheme.SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 6)
    TopBarCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = self.CurrentTheme.TextColor
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = self.CurrentTheme.SecondaryColor
    TabHolder.Position = UDim2.new(0, 5, 0, 35)
    TabHolder.Size = UDim2.new(0, 140, 1, -40)

    local TabHolderCorner = Instance.new("UICorner")
    TabHolderCorner.CornerRadius = UDim.new(0, 6)
    TabHolderCorner.Parent = TabHolder

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TabHolder
    TabContainer.Active = true
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 5, 0, 5)
    TabContainer.Size = UDim2.new(1, -10, 1, -10)
    TabContainer.ScrollBarThickness = 2
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 150, 0, 35)
    ContentContainer.Size = UDim2.new(1, -155, 1, -40)

    -- Watermark Animation
    coroutine.wrap(function()
        while true do
            local text = "lucille.cc"
            local displayText = ""
            
            for i = 1, #text do
                displayText = displayText .. text:sub(i,i)
                WatermarkText.Text = displayText .. "_"
                wait(0.1)
            end
            
            wait(1)
            displayText = ""
            WatermarkText.Text = displayText
            wait(0.5)
        end
    end)()

    -- FPS Counter
    local fps = 0
    local frames = 0
    local lastTime = tick()
    
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        if tick() - lastTime >= 1 then
            fps = frames
            frames = 0
            lastTime = tick()
            FPSLabel.Text = fps.." FPS"
        end
    end)

    local Window = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        
        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = self.CurrentTheme.SecondaryColor
        Tab.Size = UDim2.new(1, 0, 0, 35)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = self.CurrentTheme.TextColor
        Tab.TextSize = 12
        Tab.AutoButtonColor = false

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = Tab

        TabContent.Name = name.."Content"
        TabContent.Parent = ContentContainer
        TabContent.Active = true
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local ModuleList = Instance.new("UIListLayout")
        ModuleList.Parent = TabContent
        ModuleList.SortOrder = Enum.SortOrder.LayoutOrder
        ModuleList.Padding = UDim.new(0, 5)

        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        local TabFunctions = {}

        function TabFunctions:CreateModule(moduleName, options)
            options = options or {}
            local Module = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            
            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = Library.CurrentTheme.SecondaryColor
            Module.Size = UDim2.new(1, -10, 0, options.type == "slider" and 70 or 40)

            local ModuleCorner = Instance.new("UICorner")
            ModuleCorner.CornerRadius = UDim.new(0, 4)
            ModuleCorner.Parent = Module

            Title.Name = "Title"
            Title.Parent = Module
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(1, -20, 0, 30)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = moduleName
            Title.TextColor3 = Library.CurrentTheme.TextColor
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            if options.type == "slider" then
                local Slider = Instance.new("Frame")
                local SliderBar = Instance.new("Frame")
                local SliderButton = Instance.new("TextButton")
                local ValueLabel = Instance.new("TextLabel")

                Slider.Name = "Slider"
                Slider.Parent = Module
                Slider.BackgroundColor3 = Library.CurrentTheme.MainColor
                Slider.Position = UDim2.new(0, 10, 0, 35)
                Slider.Size = UDim2.new(1, -20, 0, 25)

                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Parent = Slider

                SliderBar.Name = "Bar"
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = Library.CurrentTheme.AccentColor
                SliderBar.Size = UDim2.new(0.5, 0, 1, 0)

                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 4)
                BarCorner.Parent = SliderBar

                SliderButton.Name = "Button"
                SliderButton.Parent = SliderBar
                SliderButton.AnchorPoint = Vector2.new(1, 0.5)
                SliderButton.Position = UDim2.new(1, 0, 0.5, 0)
                SliderButton.Size = UDim2.new(0, 20, 0, 20)
                SliderButton.BackgroundColor3 = Library.CurrentTheme.TextColor
                SliderButton.Text = ""

                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(1, 0)
                ButtonCorner.Parent = SliderButton

                ValueLabel.Name = "Value"
                ValueLabel.Parent = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Size = UDim2.new(1, 0, 1, 0)
                ValueLabel.Font = Enum.Font.GothamSemibold
                ValueLabel.Text = tostring(options.default or options.min or 0)
                ValueLabel.TextColor3 = Library.CurrentTheme.TextColor
                ValueLabel.TextSize = 14

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
                        local pos = math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
                        local value = math.floor(pos * (options.max or 100))
                        
                        SliderBar.Size = UDim2.new(pos, 0, 1, 0)
                        ValueLabel.Text = tostring(value)
                        
                        if options.callback then
                            options.callback(value)
                        end
                    end
                end)
            end

            ModuleList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                TabContent.CanvasSize = UDim2.new(0, 0, 0, ModuleList.AbsoluteContentSize.Y + 5)
            end)

            return Module
        end

        return TabFunctions
    end

    return Window
end

return Library
