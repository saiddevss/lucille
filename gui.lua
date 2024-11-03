local TweenService = game:GetService("TweenService")

local RobloxUILibrary = {}

-- Utility functions
local function createInstance(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    return instance
end

-- Create a basic frame
function RobloxUILibrary:createFrame(name, parent, size, position)
    return createInstance("Frame", {
        Name = name,
        Parent = parent,
        Size = size or UDim2.new(0, 200, 0, 200),
        Position = position or UDim2.new(0.5, -100, 0.5, -100),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
end

-- Create a text label
function RobloxUILibrary:createLabel(name, parent, text, position)
    return createInstance("TextLabel", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -20, 0, 30),
        Position = position or UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end

-- Create a button
function RobloxUILibrary:createButton(name, parent, text, position, callback)
    local button = createInstance("TextButton", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(0, 120, 0, 35),
        Position = position or UDim2.new(0.5, -60, 1, -45),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = false
    })
    
    local cornerRadius = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = button
    })
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Create a text input
function RobloxUILibrary:createTextInput(name, parent, placeholderText, position)
    local textBox = createInstance("TextBox", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -20, 0, 35),
        Position = position or UDim2.new(0, 10, 0, 40),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        Text = "",
        PlaceholderText = placeholderText,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false
    })
    
    local cornerRadius = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = textBox
    })
    
    local padding = createInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        Parent = textBox
    })
    
    textBox.Focused:Connect(function()
        TweenService:Create(textBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)
    
    textBox.FocusLost:Connect(function()
        TweenService:Create(textBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    return textBox
end

-- Create a modern dropdown
function RobloxUILibrary:createDropdown(name, parent, options, position)
    local dropdown = createInstance("Frame", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -20, 0, 35),
        Position = position or UDim2.new(0, 10, 0, 75),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        ClipsDescendants = true
    })
    
    local cornerRadius = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = dropdown
    })
    
    local selectedOption = createInstance("TextLabel", {
        Name = "SelectedOption",
        Parent = dropdown,
        Size = UDim2.new(1, -35, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "Select an option",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local toggleButton = createInstance("TextButton", {
        Name = "ToggleButton",
        Parent = dropdown,
        Size = UDim2.new(0, 35, 0, 35),
        Position = UDim2.new(1, -35, 0, 0),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold
    })
    
    local optionsList = createInstance("Frame", {
        Name = "OptionsList",
        Parent = dropdown,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        Visible = false
    })
    
    local optionsLayout = createInstance("UIListLayout", {
        Parent = optionsList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    })
    
    for i, option in ipairs(options) do
        local optionButton = createInstance("TextButton", {
            Parent = optionsList,
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = Color3.fromRGB(60, 60, 60),
            Text = option,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Font = Enum.Font.Gotham
        })
        
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            selectedOption.Text = option
            TweenService:Create(dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, 35)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {Rotation = 0}):Play()
            optionsList.Visible = false
        end)
    end
    
    local isOpen = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, 35 + optionsList.AbsoluteSize.Y)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {Rotation = 180}):Play()
            optionsList.Visible = true
        else
            TweenService:Create(dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, 35)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {Rotation = 0}):Play()
            optionsList.Visible = false
        end
    end)
    
    return dropdown
end

-- Create a toggle switch
function RobloxUILibrary:createToggle(name, parent, position, callback)
    local toggle = createInstance("Frame", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(0, 50, 0, 25),
        Position = position or UDim2.new(0, 10, 0, 110),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0
    })
    
    local cornerRadius = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = toggle
    })
    
    local switch = createInstance("Frame", {
        Parent = toggle,
        Size = UDim2.new(0, 21, 0, 21),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    local switchCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(1, 0),
        Parent = switch
    })
    
    local isOn = false
    
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOn = not isOn
            if isOn then
                TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
                TweenService:Create(switch, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0, 2)}):Play()
            else
                TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                TweenService:Create(switch, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            end
            
            if callback then
                callback(isOn)
            end
        end
    end)
    
    -- Add hover effect
    toggle.MouseEnter:Connect(function()
        if not isOn then
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
        end
    end)
    
    toggle.MouseLeave:Connect(function()
        if not isOn then
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end
    end)
    
    -- Add label
    local label = createInstance("TextLabel", {
        Name = name .. "Label",
        Parent = parent,
        Size = UDim2.new(0, 100, 0, 25),
        Position = UDim2.new(0, 70, 0, 110),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    return toggle, label
end

return RobloxUILibrary
