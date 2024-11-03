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
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 2
    })
end

-- Create a text label
function RobloxUILibrary:createLabel(name, parent, text, position)
    return createInstance("TextLabel", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -10, 0, 30),
        Position = position or UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        Font = Enum.Font.SourceSansBold
    })
end

-- Create a button
function RobloxUILibrary:createButton(name, parent, text, position, callback)
    local button = createInstance("TextButton", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(0, 100, 0, 30),
        Position = position or UDim2.new(0.5, -50, 1, -40),
        BackgroundColor3 = Color3.fromRGB(0, 162, 255),
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.SourceSansBold
    })
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Create a text input
function RobloxUILibrary:createTextInput(name, parent, placeholderText, position)
    return createInstance("TextBox", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -10, 0, 30),
        Position = position or UDim2.new(0, 5, 0, 40),
        BackgroundColor3 = Color3.fromRGB(240, 240, 240),
        Text = "",
        PlaceholderText = placeholderText,
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        Font = Enum.Font.SourceSans
    })
end

-- Create a simple dropdown
function RobloxUILibrary:createDropdown(name, parent, options, position)
    local dropdown = createInstance("TextButton", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(1, -10, 0, 30),
        Position = position or UDim2.new(0, 5, 0, 75),
        BackgroundColor3 = Color3.fromRGB(240, 240, 240),
        Text = "Select an option",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        Font = Enum.Font.SourceSans
    })
    
    local optionsList = createInstance("Frame", {
        Name = "OptionsList",
        Parent = dropdown,
        Size = UDim2.new(1, 0, 0, #options * 30),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Visible = false
    })
    
    for i, option in ipairs(options) do
        local optionButton = createInstance("TextButton", {
            Parent = optionsList,
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, (i-1) * 30),
            BackgroundColor3 = Color3.fromRGB(240, 240, 240),
            Text = option,
            TextColor3 = Color3.fromRGB(0, 0, 0),
            TextSize = 14,
            Font = Enum.Font.SourceSans
        })
        
        optionButton.MouseButton1Click:Connect(function()
            dropdown.Text = option
            optionsList.Visible = false
        end)
    end
    
    dropdown.MouseButton1Click:Connect(function()
        optionsList.Visible = not optionsList.Visible
    end)
    
    return dropdown
end

-- Create a toggle switch
function RobloxUILibrary:createToggle(name, parent, position, callback)
    local toggle = createInstance("Frame", {
        Name = name,
        Parent = parent,
        Size = UDim2.new(0, 50, 0, 25),
        Position = position or UDim2.new(0, 5, 0, 110),
        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
        BorderSizePixel = 0
    })
    
    local switch = createInstance("Frame", {
        Parent = toggle,
        Size = UDim2.new(0, 25, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    
    local isOn = false
    
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOn = not isOn
            if isOn then
                switch:TweenPosition(UDim2.new(0.5, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                toggle.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            else
                switch:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                toggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            end
            if callback then
                callback(isOn)
            end
        end
    end)
    
    return toggle
end

return RobloxUILibrary
