--[[
    Phantom UI Library
    Создано для Roblox Studio
    Поддержка: Кнопки, Loop-кнопки, Уведомления
]]

local PhantomLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Настройки библиотеки
local Settings = {
    Accent = Color3.fromRGB(130, 80, 255), -- Основной акцентный цвет
    Background = Color3.fromRGB(25, 25, 35), -- Цвет фона
    Secondary = Color3.fromRGB(40, 40, 55), -- Вторичный цвет
    TextColor = Color3.fromRGB(240, 240, 240), -- Цвет текста
    ToggleOn = Color3.fromRGB(100, 200, 120), -- Цвет включенного тоггла
    ToggleOff = Color3.fromRGB(60, 60, 80), -- Цвет выключенного тоггла
    Rounding = 8, -- Скругление углов
    Transparency = 0.02, -- Прозрачность окон
}

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

-- Класс основного окна
function PhantomLib:CreateWindow(title)
    -- Создаем ScreenGui если нет
    local gui = CoreGui:FindFirstChild("PhantomUI")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "PhantomUI"
        gui.ResetOnSpawn = false
        gui.Parent = CoreGui
    end

    -- Основное окно
    local Window = Instance.new("Frame")
    Window.Size = UDim2.new(0, 280, 0, 0)
    Window.Position = UDim2.new(0.5, -140, 0.4, -100)
    Window.BackgroundColor3 = Settings.Background
    Window.BackgroundTransparency = Settings.Transparency
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = gui

    CreateUICorner(Window)
    CreateStroke(Window)

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
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Settings.Secondary
    TitleBar.BackgroundTransparency = 0.5
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = Window

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Phantom UI"
    Title.TextColor3 = Settings.TextColor
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 2)
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
        Window:Destroy()
    end)

    -- Контейнер для контента
    local Content = Instance.new("ScrollingFrame")
    Content.Size = UDim2.new(1, -10, 1, -45)
    Content.Position = UDim2.new(0, 5, 0, 40)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 2
    Content.ScrollBarImageColor3 = Settings.Accent
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.Parent = Window

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Content

    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 8)
    ContentPadding.PaddingBottom = UDim.new(0, 8)
    ContentPadding.PaddingLeft = UDim.new(0, 5)
    ContentPadding.PaddingRight = UDim.new(0, 5)
    ContentPadding.Parent = Content

    -- Анимация появления
    Window.Size = UDim2.new(0, 280, 0, 0)
    CreateTween(Window, {Size = UDim2.new(0, 280, 0, 250)}, 0.4):Play()

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

    -- Функция создания кнопки
    function WindowFunctions:CreateButton(text, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Settings.Secondary
        Button.BackgroundTransparency = 0.3
        Button.Text = text
        Button.TextColor3 = Settings.TextColor
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 13
        Button.BorderSizePixel = 0
        Button.Parent = Content
        CreateUICorner(Button)

        -- Hover эффекты
        Button.MouseEnter:Connect(function()
            CreateTween(Button, {BackgroundTransparency = 0.1}, 0.2):Play()
        end)

        Button.MouseLeave:Connect(function()
            CreateTween(Button, {BackgroundTransparency = 0.3}, 0.2):Play()
        end)

        Button.MouseButton1Down:Connect(function()
            CreateTween(Button, {Size = UDim2.new(0.95, 0, 0, 33)}, 0.1):Play()
        end)

        Button.MouseButton1Up:Connect(function()
            CreateTween(Button, {Size = UDim2.new(1, 0, 0, 35)}, 0.1):Play()
        end)

        Button.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)

        return Button
    end

    -- Функция создания Loop кнопки
    function WindowFunctions:CreateLoopButton(text, callback)
        local isActive = false
        local loopConnection = nil

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Settings.ToggleOff
        Button.BackgroundTransparency = 0.3
        Button.Text = text .. " [OFF]"
        Button.TextColor3 = Settings.TextColor
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 13
        Button.BorderSizePixel = 0
        Button.Parent = Content
        CreateUICorner(Button)

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 8, 0, 8)
        indicator.Position = UDim2.new(1, -15, 0.5, -4)
        indicator.BackgroundColor3 = Settings.ToggleOff
        indicator.BorderSizePixel = 0
        indicator.Parent = Button
        CreateUICorner(indicator, 100)

        -- Анимация работы кнопки
        local highlightAnimation
        local function StartAnimation()
            highlightAnimation = TweenService:Create(indicator, 
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1),
                {BackgroundColor3 = Settings.ToggleOn, Rotation = 360}
            )
            highlightAnimation:Play()
        end

        local function StopAnimation()
            if highlightAnimation then
                highlightAnimation:Cancel()
                indicator.Rotation = 0
                indicator.BackgroundColor3 = Settings.ToggleOff
            end
        end

        Button.MouseButton1Click:Connect(function()
            isActive = not isActive
            
            if isActive then
                -- Включаем Loop
                Button.Text = text .. " [ON]"
                Button.BackgroundColor3 = Settings.ToggleOn
                StartAnimation()

                -- Запускаем loop
                loopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if isActive and callback then
                        callback()
                    end
                end)
            else
                -- Выключаем Loop
                Button.Text = text .. " [OFF]"
                Button.BackgroundColor3 = Settings.ToggleOff
                StopAnimation()

                -- Останавливаем loop
                if loopConnection then
                    loopConnection:Disconnect()
                    loopConnection = nil
                end
            end
        end)

        -- Hover эффекты
        Button.MouseEnter:Connect(function()
            if not isActive then
                CreateTween(Button, {BackgroundTransparency = 0.1}, 0.2):Play()
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

    -- Функция создания уведомления
    function WindowFunctions:Notify(title, message, duration)
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 250, 0, 60)
        notification.Position = UDim2.new(0.5, -125, 1, -70)
        notification.BackgroundColor3 = Settings.Background
        notification.BackgroundTransparency = Settings.Transparency
        notification.BorderSizePixel = 0
        notification.ZIndex = 100
        notification.Parent = Window
        CreateUICorner(notification)
        CreateStroke(notification)

        local notifTitle = Instance.new("TextLabel")
        notifTitle.Size = UDim2.new(1, -20, 0, 20)
        notifTitle.Position = UDim2.new(0, 10, 0, 8)
        notifTitle.BackgroundTransparency = 1
        notifTitle.Text = title or "Уведомление"
        notifTitle.TextColor3 = Settings.Accent
        notifTitle.Font = Enum.Font.GothamBold
        notifTitle.TextSize = 13
        notifTitle.TextXAlignment = Enum.TextXAlignment.Left
        notifTitle.ZIndex = 100
        notifTitle.Parent = notification

        local notifMessage = Instance.new("TextLabel")
        notifMessage.Size = UDim2.new(1, -20, 0, 20)
        notifMessage.Position = UDim2.new(0, 10, 0, 28)
        notifMessage.BackgroundTransparency = 1
        notifMessage.Text = message or ""
        notifMessage.TextColor3 = Settings.TextColor
        notifMessage.Font = Enum.Font.Gotham
        notifMessage.TextSize = 12
        notifMessage.TextXAlignment = Enum.TextXAlignment.Left
        notifMessage.ZIndex = 100
        notifMessage.Parent = notification

        -- Анимация появления
        notification.Position = UDim2.new(0.5, -125, 1.2, 0)
        CreateTween(notification, {Position = UDim2.new(0.5, -125, 1, -70)}, 0.4):Play()

        -- Исчезновение
        task.delay(duration or 3, function()
            CreateTween(notification, {Position = UDim2.new(0.5, -125, 1.2, 0), BackgroundTransparency = 1}, 0.4):Play()
            task.delay(0.4, function()
                notification:Destroy()
            end)
        end)
    end

    return WindowFunctions
end

return PhantomLib
