--[[
    🌊 Wind Hub - UI Library
    Создано для Roblox Studio
    Поддержка: Кнопки, Loop-кнопки, Уведомления, Темы
]]

local WindHub = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Пресеты тем
WindHub.Themes = {
    Ocean = {
        Name = "Ocean",
        Accent = Color3.fromRGB(0, 180, 255),        -- Голубой
        Background = Color3.fromRGB(15, 25, 40),     -- Темно-синий
        Secondary = Color3.fromRGB(25, 40, 60),      -- Синий
        TextColor = Color3.fromRGB(220, 240, 255),   -- Светло-голубой
        ToggleOn = Color3.fromRGB(0, 200, 255),      -- Ярко-голубой
        ToggleOff = Color3.fromRGB(40, 60, 90),      -- Темно-синий
        WindowGradient1 = Color3.fromRGB(15, 30, 50),
        WindowGradient2 = Color3.fromRGB(10, 20, 35),
    },
    
    Crimson = {
        Name = "Crimson",
        Accent = Color3.fromRGB(255, 60, 80),        -- Красный
        Background = Color3.fromRGB(30, 15, 20),     -- Темно-красный
        Secondary = Color3.fromRGB(50, 25, 30),      -- Красный
        TextColor = Color3.fromRGB(255, 220, 225),   -- Светло-розовый
        ToggleOn = Color3.fromRGB(255, 70, 90),      -- Ярко-красный
        ToggleOff = Color3.fromRGB(70, 35, 45),      -- Темно-красный
        WindowGradient1 = Color3.fromRGB(35, 18, 22),
        WindowGradient2 = Color3.fromRGB(25, 12, 18),
    },
    
    Emerald = {
        Name = "Emerald",
        Accent = Color3.fromRGB(0, 230, 130),        -- Зеленый
        Background = Color3.fromRGB(15, 30, 25),     -- Темно-зеленый
        Secondary = Color3.fromRGB(25, 45, 35),      -- Зеленый
        TextColor = Color3.fromRGB(210, 255, 235),   -- Светло-зеленый
        ToggleOn = Color3.fromRGB(0, 240, 140),      -- Ярко-зеленый
        ToggleOff = Color3.fromRGB(35, 65, 50),      -- Темно-зеленый
        WindowGradient1 = Color3.fromRGB(18, 33, 28),
        WindowGradient2 = Color3.fromRGB(12, 25, 22),
    },
    
    Sunset = {
        Name = "Sunset",
        Accent = Color3.fromRGB(255, 140, 0),        -- Оранжевый
        Background = Color3.fromRGB(35, 25, 15),     -- Темно-оранжевый
        Secondary = Color3.fromRGB(55, 35, 25),      -- Оранжевый
        TextColor = Color3.fromRGB(255, 230, 200),   -- Светло-оранжевый
        ToggleOn = Color3.fromRGB(255, 150, 20),     -- Ярко-оранжевый
        ToggleOff = Color3.fromRGB(75, 50, 35),      -- Темно-оранжевый
        WindowGradient1 = Color3.fromRGB(40, 28, 18),
        WindowGradient2 = Color3.fromRGB(30, 20, 12),
    },
    
    Midnight = {
        Name = "Midnight",
        Accent = Color3.fromRGB(150, 100, 255),      -- Фиолетовый
        Background = Color3.fromRGB(20, 15, 35),     -- Темно-фиолетовый
        Secondary = Color3.fromRGB(35, 25, 55),      -- Фиолетовый
        TextColor = Color3.fromRGB(230, 220, 255),   -- Светло-фиолетовый
        ToggleOn = Color3.fromRGB(160, 110, 255),    -- Ярко-фиолетовый
        ToggleOff = Color3.fromRGB(50, 40, 75),      -- Темно-фиолетовый
        WindowGradient1 = Color3.fromRGB(25, 18, 38),
        WindowGradient2 = Color3.fromRGB(18, 12, 30),
    },
    
    Aurora = {
        Name = "Aurora",
        Accent = Color3.fromRGB(0, 255, 200),        -- Бирюзовый
        Background = Color3.fromRGB(10, 25, 35),     -- Темно-бирюзовый
        Secondary = Color3.fromRGB(20, 40, 50),      -- Бирюзовый
        TextColor = Color3.fromRGB(200, 255, 245),   -- Светло-бирюзовый
        ToggleOn = Color3.fromRGB(0, 255, 210),      -- Ярко-бирюзовый
        ToggleOff = Color3.fromRGB(30, 60, 70),      -- Темно-бирюзовый
        WindowGradient1 = Color3.fromRGB(12, 28, 38),
        WindowGradient2 = Color3.fromRGB(8, 22, 32),
    },
    
    Cherry = {
        Name = "Cherry",
        Accent = Color3.fromRGB(255, 120, 200),      -- Розовый
        Background = Color3.fromRGB(35, 20, 30),     -- Темно-розовый
        Secondary = Color3.fromRGB(55, 30, 45),      -- Розовый
        TextColor = Color3.fromRGB(255, 210, 235),   -- Светло-розовый
        ToggleOn = Color3.fromRGB(255, 130, 210),    -- Ярко-розовый
        ToggleOff = Color3.fromRGB(75, 45, 60),      -- Темно-розовый
        WindowGradient1 = Color3.fromRGB(38, 22, 33),
        WindowGradient2 = Color3.fromRGB(30, 16, 26),
    },
    
    Arctic = {
        Name = "Arctic",
        Accent = Color3.fromRGB(200, 220, 255),      -- Бело-голубой
        Background = Color3.fromRGB(25, 30, 45),     -- Темно-серый синий
        Secondary = Color3.fromRGB(40, 45, 60),      -- Серо-синий
        TextColor = Color3.fromRGB(235, 240, 255),   -- Почти белый
        ToggleOn = Color3.fromRGB(180, 210, 255),    -- Голубой
        ToggleOff = Color3.fromRGB(55, 60, 80),      -- Серый
        WindowGradient1 = Color3.fromRGB(28, 33, 48),
        WindowGradient2 = Color3.fromRGB(22, 28, 40),
    },
}

-- Текущая тема (по умолчанию Ocean)
local CurrentTheme = WindHub.Themes.Ocean
local Settings = {
    Rounding = 8,
    Transparency = 0.02,
}
for k, v in pairs(CurrentTheme) do
    Settings[k] = v
end

-- Функция смены темы
function WindHub:SetTheme(themeName)
    local theme = WindHub.Themes[themeName]
    if theme then
        CurrentTheme = theme
        for k, v in pairs(theme) do
            Settings[k] = v
        end
        return true
    end
    return false
end

-- Получить список доступных тем
function WindHub:GetThemes()
    local themes = {}
    for name, _ in pairs(WindHub.Themes) do
        table.insert(themes, name)
    end
    table.sort(themes)
    return themes
end

-- Анимация
local function CreateTween(object, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out)
    return TweenService:Create(object, tweenInfo, properties)
end

-- Создание UI Corner
local function CreateUICorner(parent, cornerRadius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius or Settings.Rounding)
    corner.Parent = parent
    return corner
end

-- Создание Stroke
local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Settings.Accent
    stroke.Thickness = thickness or 1.5
    stroke.Transparency = 0.3
    stroke.Parent = parent
    return stroke
end

-- Создание градиента
local function CreateGradient(parent)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Settings.WindowGradient1),
        ColorSequenceKeypoint.new(1, Settings.WindowGradient2),
    })
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

-- Класс основного окна
function WindHub:CreateWindow(title)
    local gui = CoreGui:FindFirstChild("WindHub")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "WindHub"
        gui.ResetOnSpawn = false
        gui.Parent = CoreGui
    end

    -- Основное окно
    local Window = Instance.new("Frame")
    Window.Size = UDim2.new(0, 300, 0, 0)
    Window.Position = UDim2.new(0.5, -150, 0.4, -100)
    Window.BackgroundColor3 = Settings.Background
    Window.BackgroundTransparency = Settings.Transparency
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = gui

    CreateUICorner(Window)
    CreateStroke(Window, Settings.Accent)
    CreateGradient(Window)

    -- Тень
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = -1
    Shadow.Parent = Window

    -- Заголовок окна
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Settings.Secondary
    TitleBar.BackgroundTransparency = 0.5
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Window

    -- Логотип Wind Hub
    local Logo = Instance.new("TextLabel")
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.Position = UDim2.new(0, 12, 0, 5)
    Logo.BackgroundTransparency = 1
    Logo.Text = "🌊"
    Logo.TextSize = 18
    Logo.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Position = UDim2.new(0, 45, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Wind Hub"
    Title.TextColor3 = Settings.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 32, 0, 32)
    CloseButton.Position = UDim2.new(1, -38, 0, 4)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.BackgroundTransparency = 0.8
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Settings.TextColor
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 16
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TitleBar
    CreateUICorner(CloseButton, 6)

    CloseButton.MouseButton1Click:Connect(function()
        local tween = CreateTween(Window, {Size = UDim2.new(0, 300, 0, 0), BackgroundTransparency = 1}, 0.3)
        tween:Play()
        tween.Completed:Connect(function()
            Window:Destroy()
        end)
    end)

    -- Подзаголовок
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -50, 0, 15)
    Subtitle.Position = UDim2.new(0, 45, 0, 22)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "v1.0.0"
    Subtitle.TextColor3 = Settings.Accent
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextSize = 11
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.TextTransparency = 0.3
    Subtitle.Parent = TitleBar

    -- Контейнер для контента
    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, -10, 1, -50)
    Content.Position = UDim2.new(0, 5, 0, 45)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 3
    Content.ScrollBarImageColor3 = Settings.Accent
    Content.ScrollBarImageTransparency = 0.5
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.Parent = Window

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)
    UIListLayout.Parent = Content

    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingBottom = UDim.new(0, 10)
    ContentPadding.PaddingLeft = UDim.new(0, 5)
    ContentPadding.PaddingRight = UDim.new(0, 5)
    ContentPadding.Parent = Content

    -- Анимация появления
    Window.Size = UDim2.new(0, 300, 0, 0)
    CreateTween(Window, {Size = UDim2.new(0, 300, 0, 280)}, 0.4):Play()

    -- Перетаскивание окна
    local dragging = false
    local dragInput, dragStart, startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local WindowFunctions = {
        Window = Window,
        Content = Content,
    }

    -- Функция создания разделителя
    function WindowFunctions:CreateDivider(text)
        local Divider = Instance.new("Frame")
        Divider.Size = UDim2.new(1, 0, 0, 25)
        Divider.BackgroundTransparency = 1
        Divider.Parent = Content

        local Line = Instance.new("Frame")
        Line.Size = UDim2.new(1, 0, 0, 1)
        Line.Position = UDim2.new(0, 0, 0.5, 0)
        Line.BackgroundColor3 = Settings.Accent
        Line.BackgroundTransparency = 0.7
        Line.BorderSizePixel = 0
        Line.Parent = Divider

        if text then
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0, 100, 1, 0)
            Label.Position = UDim2.new(0.5, -50, 0, 0)
            Label.BackgroundColor3 = Settings.Background
            Label.BackgroundTransparency = 0.5
            Label.Text = text
            Label.TextColor3 = Settings.Accent
            Label.Font = Enum.Font.GothamBold
            Label.TextSize = 12
            Label.Parent = Divider
        end

        return Divider
    end

    -- Функция создания обычной кнопки
    function WindowFunctions:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 38)
        Button.BackgroundColor3 = Settings.Secondary
        Button.BackgroundTransparency = 0.3
        Button.Text = "  " .. text
        Button.TextColor3 = Settings.TextColor
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 13
        Button.TextXAlignment = Enum.TextXAlignment.Left
        Button.BorderSizePixel = 0
        Button.Parent = Content
        CreateUICorner(Button)

        -- Иконка стрелки
        local Arrow = Instance.new("TextLabel")
        Arrow.Size = UDim2.new(0, 20, 1, 0)
        Arrow.Position = UDim2.new(1, -25, 0, 0)
        Arrow.BackgroundTransparency = 1
        Arrow.Text = "›"
        Arrow.TextColor3 = Settings.Accent
        Arrow.Font = Enum.Font.GothamBold
        Arrow.TextSize = 18
        Arrow.Parent = Button

        -- Hover эффекты
        Button.MouseEnter:Connect(function()
            CreateTween(Button, {BackgroundTransparency = 0.1}, 0.2):Play()
            CreateTween(Arrow, {Position = UDim2.new(1, -22, 0, 0), TextTransparency = 0}, 0.2):Play()
        end)

        Button.MouseLeave:Connect(function()
            CreateTween(Button, {BackgroundTransparency = 0.3}, 0.2):Play()
            CreateTween(Arrow, {Position = UDim2.new(1, -25, 0, 0), TextTransparency = 0.3}, 0.2):Play()
        end)

        Button.MouseButton1Down:Connect(function()
            CreateTween(Button, {Size = UDim2.new(0.95, 0, 0, 36)}, 0.1):Play()
        end)

        Button.MouseButton1Up:Connect(function()
            CreateTween(Button, {Size = UDim2.new(1, 0, 0, 38)}, 0.1):Play()
        end)

        Button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
            -- Эффект клика
            CreateTween(Button, {BackgroundColor3 = Settings.Accent, BackgroundTransparency = 0.5}, 0.1):Play()
            task.wait(0.1)
            CreateTween(Button, {BackgroundColor3 = Settings.Secondary, BackgroundTransparency = 0.3}, 0.2):Play()
        end)

        return Button
    end

    -- Функция создания Loop кнопки
    function WindowFunctions:CreateLoopButton(text, callback)
        local isActive = false
        local loopConnection = nil

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 38)
        Button.BackgroundColor3 = Settings.ToggleOff
        Button.BackgroundTransparency = 0.3
        Button.Text = "  " .. text
        Button.TextColor3 = Settings.TextColor
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 13
        Button.TextXAlignment = Enum.TextXAlignment.Left
        Button.BorderSizePixel = 0
        Button.Parent = Content
        CreateUICorner(Button)

        -- Статус индикатор
        local StatusFrame = Instance.new("Frame")
        StatusFrame.Size = UDim2.new(0, 45, 0, 22)
        StatusFrame.Position = UDim2.new(1, -52, 0.5, -11)
        StatusFrame.BackgroundColor3 = Settings.ToggleOff
        StatusFrame.BackgroundTransparency = 0.5
        StatusFrame.BorderSizePixel = 0
        StatusFrame.Parent = Button
        CreateUICorner(StatusFrame, 100)

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 14, 0, 14)
        Indicator.Position = UDim2.new(0, 4, 0.5, -7)
        Indicator.BackgroundColor3 = Settings.ToggleOff
        Indicator.BackgroundTransparency = 0.5
        Indicator.BorderSizePixel = 0
        Indicator.Parent = StatusFrame
        CreateUICorner(Indicator, 100)

        local StatusText = Instance.new("TextLabel")
        StatusText.Size = UDim2.new(0, 25, 1, 0)
        StatusText.Position = UDim2.new(0, 20, 0, 0)
        StatusText.BackgroundTransparency = 1
        StatusText.Text = "OFF"
        StatusText.TextColor3 = Settings.TextColor
        StatusText.Font = Enum.Font.GothamBold
        StatusText.TextSize = 11
        StatusText.TextTransparency = 0.3
        StatusText.Parent = StatusFrame

        -- Анимация работы
        local highlightAnimation
        local function StartAnimation()
            highlightAnimation = TweenService:Create(Indicator, 
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1),
                {BackgroundColor3 = Settings.ToggleOn, BackgroundTransparency = 0}
            )
            highlightAnimation:Play()
        end

        local function StopAnimation()
            if highlightAnimation then
                highlightAnimation:Cancel()
                Indicator.BackgroundColor3 = Settings.ToggleOff
                Indicator.BackgroundTransparency = 0.5
            end
        end

        Button.MouseButton1Click:Connect(function()
            isActive = not isActive
            
            if isActive then
                -- Включаем Loop
                StatusText.Text = "ON"
                StatusText.TextTransparency = 0
                StatusFrame.BackgroundColor3 = Settings.ToggleOn
                Button.BackgroundColor3 = Settings.ToggleOn
                Button.BackgroundTransparency = 0.3
                StartAnimation()

                loopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if isActive and callback then
                        callback()
                    end
                end)
            else
                -- Выключаем Loop
                StatusText.Text = "OFF"
                StatusText.TextTransparency = 0.3
                StatusFrame.BackgroundColor3 = Settings.ToggleOff
                Button.BackgroundColor3 = Settings.ToggleOff
                Button.BackgroundTransparency = 0.3
                StopAnimation()

                if loopConnection then
                    loopConnection:Disconnect()
                    loopConnection = nil
                end
            end
        end)

        -- Hover эффекты
        Button.MouseEnter:Connect(function()
            if not isActive then
                CreateTween(Button, {BackgroundTransparency = 0.15}, 0.2):Play()
            end
        end)

        Button.MouseLeave:Connect(function()
            if not isActive then
                CreateTween(Button, {BackgroundTransparency = 0.3}, 0.2):Play()
            end
        end)

        return {
            Button = Button,
            Toggle = function(state)
                if state ~= isActive then
                    Button.MouseButton1Click:Fire()
                end
            end,
            IsActive = function()
                return isActive
            end,
            Destroy = function()
                if loopConnection then
                    loopConnection:Disconnect()
                end
                Button:Destroy()
            end
        }
    end

    -- Функция создания переключателя тем
    function WindowFunctions:CreateThemeSelector()
        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.Parent = Content

        local PrevButton = Instance.new("TextButton")
        PrevButton.Size = UDim2.new(0, 30, 1, 0)
        PrevButton.BackgroundColor3 = Settings.Secondary
        PrevButton.BackgroundTransparency = 0.3
        PrevButton.Text = "◀"
        PrevButton.TextColor3 = Settings.TextColor
        PrevButton.Font = Enum.Font.GothamBold
        PrevButton.TextSize = 14
        PrevButton.BorderSizePixel = 0
        PrevButton.Parent = Container
        CreateUICorner(PrevButton)

        local ThemeLabel = Instance.new("TextLabel")
        ThemeLabel.Size = UDim2.new(1, -70, 1, 0)
        ThemeLabel.Position = UDim2.new(0, 35, 0, 0)
        ThemeLabel.BackgroundColor3 = Settings.Secondary
        ThemeLabel.BackgroundTransparency = 0.3
        ThemeLabel.Text = "🎨 " .. CurrentTheme.Name
        ThemeLabel.TextColor3 = Settings.TextColor
        ThemeLabel.Font = Enum.Font.GothamBold
        ThemeLabel.TextSize = 13
        ThemeLabel.BorderSizePixel = 0
        ThemeLabel.Parent = Container
        CreateUICorner(ThemeLabel)

        local NextButton = Instance.new("TextButton")
        NextButton.Size = UDim2.new(0, 30, 1, 0)
        NextButton.Position = UDim2.new(1, -30, 0, 0)
        NextButton.BackgroundColor3 = Settings.Secondary
        NextButton.BackgroundTransparency = 0.3
        NextButton.Text = "▶"
        NextButton.TextColor3 = Settings.TextColor
        NextButton.Font = Enum.Font.GothamBold
        NextButton.TextSize = 14
        NextButton.BorderSizePixel = 0
        NextButton.Parent = Container
        CreateUICorner(NextButton)

        -- Логика переключения тем
        local themesList = WindHub:GetThemes()
        local currentThemeIndex = 1

        for i, theme in ipairs(themesList) do
            if theme == CurrentTheme.Name then
                currentThemeIndex = i
                break
            end
        end

        local function UpdateTheme()
            local themeName = themesList[currentThemeIndex]
            WindHub:SetTheme(themeName)
            ThemeLabel.Text = "🎨 " .. CurrentTheme.Name
            
            -- Обновляем цвета в окне
            for k, v in pairs(Settings) do
                if CurrentTheme[k] then
                    Settings[k] = CurrentTheme[k]
                end
            end
            
            -- Обновляем основные элементы
            Window.BackgroundColor3 = Settings.Background
            TitleBar.BackgroundColor3 = Settings.Secondary
            Title.TextColor3 = Settings.TextColor
            Subtitle.TextColor3 = Settings.Accent
            
            WindowFunctions:Notify("Тема изменена", "Применена тема: " .. CurrentTheme.Name, 2)
        end

        PrevButton.MouseButton1Click:Connect(function()
            currentThemeIndex = currentThemeIndex - 1
            if currentThemeIndex < 1 then
                currentThemeIndex = #themesList
            end
            UpdateTheme()
        end)

        NextButton.MouseButton1Click:Connect(function()
            currentThemeIndex = currentThemeIndex + 1
            if currentThemeIndex > #themesList then
                currentThemeIndex = 1
            end
            UpdateTheme()
        end)

        return {
            SetTheme = function(themeName)
                for i, theme in ipairs(themesList) do
                    if theme == themeName then
                        currentThemeIndex = i
                        UpdateTheme()
                        return true
                    end
                end
                return false
            end,
            GetCurrentTheme = function()
                return CurrentTheme.Name
            end
        }
    end

    -- Функция создания уведомления
    function WindowFunctions:Notify(title, message, duration)
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 260, 0, 65)
        notification.Position = UDim2.new(0.5, -130, 1, -80)
        notification.BackgroundColor3 = Settings.Background
        notification.BackgroundTransparency = Settings.Transparency
        notification.BorderSizePixel = 0
        notification.ZIndex = 100
        notification.Parent = Window
        CreateUICorner(notification)
        CreateStroke(notification, Settings.Accent)

        -- Акцентная полоса
        local AccentBar = Instance.new("Frame")
        AccentBar.Size = UDim2.new(0, 3, 1, 0)
        AccentBar.BackgroundColor3 = Settings.Accent
        AccentBar.BorderSizePixel = 0
        AccentBar.ZIndex = 100
        AccentBar.Parent = notification

        local notifTitle = Instance.new("TextLabel")
        notifTitle.Size = UDim2.new(1, -25, 0, 22)
        notifTitle.Position = UDim2.new(0, 12, 0, 8)
        notifTitle.BackgroundTransparency = 1
        notifTitle.Text = title or "Wind Hub"
        notifTitle.TextColor3 = Settings.Accent
        notifTitle.Font = Enum.Font.GothamBold
        notifTitle.TextSize = 13
        notifTitle.TextXAlignment = Enum.TextXAlignment.Left
        notifTitle.ZIndex = 100
        notifTitle.Parent = notification

        local notifMessage = Instance.new("TextLabel")
        notifMessage.Size = UDim2.new(1, -25, 0, 20)
        notifMessage.Position = UDim2.new(0, 12, 0, 32)
        notifMessage.BackgroundTransparency = 1
        notifMessage.Text = message or ""
        notifMessage.TextColor3 = Settings.TextColor
        notifMessage.Font = Enum.Font.Gotham
        notifMessage.TextSize = 12
        notifMessage.TextXAlignment = Enum.TextXAlignment.Left
        notifMessage.ZIndex = 100
        notifMessage.Parent = notification

        -- Анимация появления
        notification.Position = UDim2.new(0.5, -130, 1.2, 0)
        CreateTween(notification, {Position = UDim2.new(0.5, -130, 1, -80)}, 0.4):Play()

        -- Исчезновение
        task.delay(duration or 3, function()
            CreateTween(notification, {Position = UDim2.new(0.5, -130, 1.2, 0), BackgroundTransparency = 1}, 0.4):Play()
            task.delay(0.4, function()
                notification:Destroy()
            end)
        end)
    end

    -- Добавляем автоматический селектор тем в начало окна
    WindowFunctions:CreateDivider("ТЕМА")
    local themeSelector = WindowFunctions:CreateThemeSelector()
    WindowFunctions:CreateDivider("ФУНКЦИИ")

    return WindowFunctions
end

return WindHub
