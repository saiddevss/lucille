local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Main Theme
Library.Theme = {
    MainColor = Color3.fromRGB(25, 25, 35),
    SecondaryColor = Color3.fromRGB(35, 35, 45),
    AccentColor = Color3.fromRGB(65, 105, 225),
    TextColor = Color3.fromRGB(255, 255, 255)
}

function Library:CreateWindow(title)
    -- Main GUI Components
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabContainer = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("Frame")

    -- GUI Setup
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Library.Theme.MainColor
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Library.Theme.SecondaryColor
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Library.Theme.TextColor
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Library.Theme.SecondaryColor
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.Size = UDim2.new(0, 120, 1, -30)

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = TabHolder
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
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

    local Window = {}

    function Window:CreateTab(name)
        local Tab = Instance.new("TextButton")
        local TabContent = Instance.new("ScrollingFrame")
        local ModuleList = Instance.new("UIListLayout")

        Tab.Name = name
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Library.Theme.SecondaryColor
        Tab.Size = UDim2.new(1, -10, 0, 30)
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = name
        Tab.TextColor3 = Library.Theme.TextColor
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

        Tab.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            TabContent.Visible = true
        end)

        local TabFunctions = {}

        function TabFunctions:CreateModule(moduleName)
            local Module = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local Toggle = Instance.new("TextButton")

            Module.Name = moduleName
            Module.Parent = TabContent
            Module.BackgroundColor3 = Library.Theme.SecondaryColor
            Module.Size = UDim2.new(1, -10, 0, 40)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Module

            Title.Name = "Title"
            Title.Parent = Module
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 10, 0, 0)
            Title.Size = UDim2.new(1, -70, 1, 0)
            Title.Font = Enum.Font.GothamSemibold
            Title.Text = moduleName
            Title.TextColor3 = Library.Theme.TextColor
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Toggle.Name = "Toggle"
            Toggle.Parent = Module
            Toggle.Position = UDim2.new(1, -60, 0.5, -10)
            Toggle.Size = UDim2.new(0, 50, 0, 20)
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Toggle.Font = Enum.Font.GothamBold
            Toggle.Text = "OFF"
            Toggle.TextColor3 = Library.Theme.TextColor
            Toggle.TextSize = 12

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Toggle

            local enabled = false
            Toggle.MouseButton1Click:Connect(function()
                enabled = not enabled
                Toggle.Text = enabled and "ON" or "OFF"
                Toggle.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            end)

            return Module
        end

        return TabFunctions
    end

    return Window
end

return Library
