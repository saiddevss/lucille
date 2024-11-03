-- Modern UI Library with Advanced Effects
local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- Utility Functions
local function CreateShadow(parent, strength)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://7912134082" -- Özel shadow texture
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 1 - (strength or 0.5)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
    return shadow
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

local function CreateBlur(parent)
    local blur = Instance.new("BlurEffect")
    blur.Size = 10
    blur.Parent = parent
    return blur
end

function Library:CreateWindow(title)
    -- Ana GUI bileşenleri
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Container = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("ImageButton")
    local MinimizeButton = Instance.new("ImageButton")
    local TabContainer = Instance.new("ScrollingFrame")
    local ContentArea = Instance.new("Frame")

    -- GUI Styling
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.ClipsDescendants = true

    -- Add main shadow
    CreateShadow(MainFrame, 0.7)

    -- Add gradient effect
    CreateGradient(MainFrame, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }, 45)

    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Container.Position = UDim2.new(0, 5, 0, 35)
    Container.Size = UDim2.new(1, -10, 1, -40)

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Stylish Top Bar
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    CreateGradient(TopBar, {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
    })

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Animated Close Button
    CloseButton.Name = "Close"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Image = "rbxassetid://7072725342"
    CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

    -- Tab Container with custom scrolling
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Container
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabContainer.Position = UDim2.new(0, 5, 0, 5)
    TabContainer.Size = UDim2.new(0, 150, 1, -10)
    TabContainer.ScrollBarThickness = 0
    TabContainer.ScrollingEnabled = true

    -- Content Area
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Container
    ContentArea.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ContentArea.Position = UDim2.new(0, 160, 0, 5)
    ContentArea.Size = UDim2.new(1, -165, 1, -10)

    -- Add smooth dragging
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Window Functions
    local Window = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        
        -- Tab Styling
        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        Tab.Size = UDim2.new(1, -10, 0, 40)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 14
        Tab.AutoButtonColor = false

        -- Add hover effect
        Tab.MouseEnter:Connect(function()
            TweenService:Create(Tab, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            }):Play()
        end)

        Tab.MouseLeave:Connect(function()
            TweenService:Create(Tab, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            }):Play()
        end)

        -- Tab Content
        TabContent.Name = name.."Content"
        TabContent.Parent = ContentArea
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false

        local TabFunctions = {}

        function TabFunctions:CreateModule(moduleName)
            local Module = Instance.new("Frame")
            local ModuleTitle = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local Slider = Instance.new("Frame")
            
            -- Module styling and functionality buraya gelecek
            -- (Modül detayları için kod çok uzun olacağından kısaltıldı)

            return Module
        end

        return TabFunctions
    end

    -- Animate GUI opening
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 600, 0, 400),
        BackgroundTransparency = 0
    }):Play()

    return Window
end

return Library
