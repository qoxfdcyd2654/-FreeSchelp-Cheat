local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

print("Версия 2.5 чита запущена. Чит создан для поддержки Schelp")

-- Создание основного интерфейса
local CheatUI = Instance.new("ScreenGui")
CheatUI.Name = "CheatUI"
CheatUI.Parent = PlayerGui
CheatUI.ResetOnSpawn = false
CheatUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Переменные для управления функциями
local noclipActive = false
local flyActive = false
local espActive = false
local speedActive = false
local superSpeedActive = false
local ultimateSpeedActive = false
local espHighlights = {}
local noclipConnection = nil
local flyConnections = {}

-- Функция для создания закругленных углов
function createRoundedCorner(radius, parent)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = parent
	return corner
end

-- Функция для создания тени
function createShadow(parent)
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.Image = "rbxassetid://5554236805"
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(23, 23, 277, 277)
	shadow.ImageTransparency = 0.5
	shadow.BackgroundTransparency = 1
	shadow.Size = UDim2.new(1, 14, 1, 14)
	shadow.Position = UDim2.new(0, -7, 0, -7)
	shadow.ZIndex = parent.ZIndex - 1
	shadow.Parent = parent
	return shadow
end

-- Основное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = CheatUI

createRoundedCorner(12, MainFrame)
createShadow(MainFrame)

-- Заголовок окна
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.BorderSizePixel = 0
Header.ZIndex = 2
Header.Parent = MainFrame

createRoundedCorner(12, Header)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0.02, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "#FREESCHELP CHEAT v2.5"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 3
Title.Parent = Header

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.ZIndex = 3
CloseButton.Parent = Header

createRoundedCorner(15, CloseButton)

CloseButton.MouseButton1Click:Connect(function()
	CheatUI:Destroy()
end)

-- Анимация при наведении на кнопку закрытия
CloseButton.MouseEnter:Connect(function()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 70, 70)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
end)

-- Область для контента
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ContentFrame

-- Функция для создания кнопок
function createFeatureButton(text, description)
	local ButtonFrame = Instance.new("Frame")
	ButtonFrame.Size = UDim2.new(1, 0, 0, 70)
	ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
	ButtonFrame.BorderSizePixel = 0
	ButtonFrame.Parent = ContentFrame

	createRoundedCorner(8, ButtonFrame)

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 1, 0)
	Button.BackgroundTransparency = 1
	Button.Text = ""
	Button.ZIndex = 2
	Button.Parent = ButtonFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(0.7, 0, 0, 30)
	TitleLabel.Position = UDim2.new(0, 15, 0, 10)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = text
	TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 18
	TitleLabel.Parent = ButtonFrame

	local DescLabel = Instance.new("TextLabel")
	DescLabel.Size = UDim2.new(0.7, 0, 0, 20)
	DescLabel.Position = UDim2.new(0, 15, 0, 40)
	DescLabel.BackgroundTransparency = 1
	DescLabel.Text = description
	DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	DescLabel.TextXAlignment = Enum.TextXAlignment.Left
	DescLabel.Font = Enum.Font.Gotham
	DescLabel.TextSize = 14
	DescLabel.Parent = ButtonFrame

	local Toggle = Instance.new("Frame")
	Toggle.Size = UDim2.new(0, 40, 0, 20)
	Toggle.Position = UDim2.new(1, -55, 0.5, -10)
	Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	Toggle.BorderSizePixel = 0
	Toggle.Parent = ButtonFrame

	createRoundedCorner(10, Toggle)

	local ToggleDot = Instance.new("Frame")
	ToggleDot.Size = UDim2.new(0, 16, 0, 16)
	ToggleDot.Position = UDim2.new(0, 2, 0, 2)
	ToggleDot.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
	ToggleDot.BorderSizePixel = 0
	ToggleDot.Parent = Toggle

	createRoundedCorner(8, ToggleDot)

	local isActive = false

	-- Анимация при наведении
	Button.MouseEnter:Connect(function()
		TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 55)}):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()
	end)

	return Button, ToggleDot, function(state)
		isActive = state
		if isActive then
			TweenService:Create(ToggleDot, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 22, 0, 2),
				BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			}):Play()
			TweenService:Create(Toggle, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(0, 100, 155)
			}):Play()
		else
			TweenService:Create(ToggleDot, TweenInfo.new(0.2), {
				Position = UDim2.new(0, 2, 0, 2),
				BackgroundColor3 = Color3.fromRGB(120, 120, 125)
			}):Play()
			TweenService:Create(Toggle, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(60, 60, 65)
			}):Play()
		end
		return isActive
	end
end

-- Реализация функций

-- Speed Hack
local function toggleSpeedHack(active)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if active then
				humanoid.WalkSpeed = 100
				print("Cheat SYSTEM: скорость увеличена до 100")
			else
				humanoid.WalkSpeed = 16
				print("Cheat SYSTEM: скорость возвращена к нормальной")
			end
		end
	end
end

-- Super Speed
local function toggleSuperSpeed(active)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if active then
				humanoid.WalkSpeed = 200  -- Супер скорость
				print("Cheat SYSTEM: супер скорость включена")
			else
				humanoid.WalkSpeed = 16   -- Нормальная скорость
				print("Cheat SYSTEM: супер скорость выключена")
			end
		end
	end
end

-- Ultimate Speed
local function toggleUltimateSpeed(active)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if active then
				humanoid.WalkSpeed = 900
				print("БЛЯЯЯЯ ОХУЕТЬ ЭТО ШТО ЗА СКОРОСТЬ")
			else
				humanoid.WalkSpeed = 16
				print("фух я остановился")
			end
		end
	end
end

-- Noclip
local function toggleNoclip(active)
	if active then
		if noclipConnection then
			noclipConnection:Disconnect()
		end

		noclipConnection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in ipairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
		print("Cheat SYSTEM: Noclip включен")
	else
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil

			-- Восстанавливаем коллизию для всех частей
			if player.Character then
				for _, part in ipairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = true
					end
				end
			end
		end
		print("Cheat SYSTEM: Noclip выключен")
	end
end

-- Fly
local flyBodyVelocity, flyBodyGyro
local isSpacePressed = false
local isShiftPressed = false

local function toggleFly(active)
	if active then
		local character = player.Character
		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				-- Создаем необходимые объекты для полета
				flyBodyVelocity = Instance.new("BodyVelocity")
				flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
				flyBodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
				flyBodyVelocity.Parent = humanoidRootPart

				flyBodyGyro = Instance.new("BodyGyro")
				flyBodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
				flyBodyGyro.P = 1000
				flyBodyGyro.D = 50
				flyBodyGyro.Parent = humanoidRootPart

				-- Обновляем гироскоп для следования за камерой
				local flyConnection = RunService.Heartbeat:Connect(function()
					if flyBodyGyro and humanoidRootPart then
						local camera = workspace.CurrentCamera
						if camera then
							flyBodyGyro.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + camera.CFrame.LookVector)
						end
					end
				end)

				-- Обработка движения вперед/назад и в стороны
				local moveConnection = RunService.Heartbeat:Connect(function()
					if not flyBodyVelocity then return end

					local moveDirection = Vector3.new(0, 0, 0)
					local verticalVelocity = 0

					-- Вертикальное движение (Space/Shift)
					if isSpacePressed then
						verticalVelocity = 50  -- Подъем
					elseif isShiftPressed then
						verticalVelocity = -50 -- Снижение
					end

					-- Движение вперед/назад
					if UserInputService:IsKeyDown(Enum.KeyCode.W) then
						moveDirection = moveDirection + Vector3.new(0, 0, -50)
					elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
						moveDirection = moveDirection + Vector3.new(0, 0, 50)
					end

					-- Движение влево/вправо
					if UserInputService:IsKeyDown(Enum.KeyCode.A) then
						moveDirection = moveDirection + Vector3.new(-50, 0, 0)
					elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
						moveDirection = moveDirection + Vector3.new(50, 0, 0)
					end

					-- Применяем движение
					if moveDirection.Magnitude > 0 then
						local camera = workspace.CurrentCamera
						if camera then
							-- Преобразуем направление движения относительно камеры
							local cameraCFrame = camera.CFrame
							local moveDirectionCameraSpace = cameraCFrame:VectorToWorldSpace(moveDirection)
							moveDirectionCameraSpace = Vector3.new(moveDirectionCameraSpace.X, 0, moveDirectionCameraSpace.Z).Unit * 50

							flyBodyVelocity.Velocity = Vector3.new(
								moveDirectionCameraSpace.X,
								verticalVelocity,
								moveDirectionCameraSpace.Z
							)
						end
					else
						-- Останавливаем горизонтальное движение, но сохраняем вертикальное
						flyBodyVelocity.Velocity = Vector3.new(0, verticalVelocity, 0)
					end
				end)

				-- Обработка нажатия клавиш Space и Shift
				local spaceDownConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end

					if input.KeyCode == Enum.KeyCode.Space then
						isSpacePressed = true
					elseif input.KeyCode == Enum.KeyCode.LeftShift then
						isShiftPressed = true
					end
				end)

				local spaceUpConnection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
					if gameProcessed then return end

					if input.KeyCode == Enum.KeyCode.Space then
						isSpacePressed = false
					elseif input.KeyCode == Enum.KeyCode.LeftShift then
						isShiftPressed = false
					end
				end)

				-- Сохраняем соединения для последующего отключения
				flyConnections[#flyConnections + 1] = flyConnection
				flyConnections[#flyConnections + 1] = moveConnection
				flyConnections[#flyConnections + 1] = spaceDownConnection
				flyConnections[#flyConnections + 1] = spaceUpConnection

				print("Cheat SYSTEM: Fly включен. Используйте WASD для движения, Space для подъема, Shift для снижения")
			end
		end
	else
		-- Сбрасываем состояния клавиш
		isSpacePressed = false
		isShiftPressed = false

		-- Отключаем все соединения fly
		for _, connection in ipairs(flyConnections) do
			connection:Disconnect()
		end
		flyConnections = {}

		-- Удаляем физические объекты
		if flyBodyVelocity then
			flyBodyVelocity:Destroy()
			flyBodyVelocity = nil
		end

		if flyBodyGyro then
			flyBodyGyro:Destroy()
			flyBodyGyro = nil
		end

		print("Cheat SYSTEM: Fly выключен")
	end
end

-- ESP
local function toggleESP(active)
	if active then
		-- Создаем ESP для всех игроков
		for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
			if otherPlayer ~= player and otherPlayer.Character then
				local highlight = Instance.new("Highlight")
				highlight.Name = "ESPHighlight"
				highlight.FillColor = Color3.fromRGB(255, 0, 0)
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.FillTransparency = 0.5
				highlight.OutlineTransparency = 0
				highlight.Parent = otherPlayer.Character

				espHighlights[otherPlayer.Name] = highlight
			end
		end

		-- Отслеживаем появление новых игроков
		local espConnection = game.Players.PlayerAdded:Connect(function(otherPlayer)
			otherPlayer.CharacterAdded:Connect(function(character)
				if espActive then
					local highlight = Instance.new("Highlight")
					highlight.Name = "ESPHighlight"
					highlight.FillColor = Color3.fromRGB(255, 0, 0)
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.FillTransparency = 0.5
					highlight.OutlineTransparency = 0
					highlight.Parent = character

					espHighlights[otherPlayer.Name] = highlight
				end
			end)
		end)

		-- Сохраняем соединение
		flyConnections[#flyConnections + 1] = espConnection
		print("Cheat SYSTEM: ESP включен")
	else
		-- Удаляем все ESP
		for playerName, highlight in pairs(espHighlights) do
			if highlight then
				highlight:Destroy()
			end
		end
		espHighlights = {}

		print("Cheat SYSTEM: ESP выключен")
	end
end

-- Функция для выключения всех функций скорости
local function disableAllSpeedFunctions()
	if speedActive then
		speedActive = false
		setSpeedState(false)
		toggleSpeedHack(false)
	end

	if superSpeedActive then
		superSpeedActive = false
		setSuperSpeedState(false)
		toggleSuperSpeed(false)
	end

	if ultimateSpeedActive then
		ultimateSpeedActive = false
		setUltimateSpeedState(false)
		toggleUltimateSpeed(false)
	end
end

-- Создание кнопок и привязка функций
local SpeedButton, SpeedToggle, setSpeedState = createFeatureButton(
	"Speed Hack", "Увеличивает вашу скорость передвижения"
)

SpeedButton.MouseButton1Click:Connect(function()
	if speedActive then
		speedActive = false
		local state = setSpeedState(speedActive)
		toggleSpeedHack(state)
	else
		disableAllSpeedFunctions()
		speedActive = true
		local state = setSpeedState(speedActive)
		toggleSpeedHack(state)
	end
end)

local SuperSpeedButton, SuperSpeedToggle, setSuperSpeedState = createFeatureButton(
	"Super Speed", "Увеличивает вашу скорость до 200"
)

SuperSpeedButton.MouseButton1Click:Connect(function()
	if superSpeedActive then
		superSpeedActive = false
		local state = setSuperSpeedState(superSpeedActive)
		toggleSuperSpeed(state)
	else
		disableAllSpeedFunctions()
		superSpeedActive = true
		local state = setSuperSpeedState(superSpeedActive)
		toggleSuperSpeed(state)
	end
end)

local UltimateSpeedButton, UltimateSpeedToggle, setUltimateSpeedState = createFeatureButton(
	"Ultimate Speed", "АААААА БЛЯТЬ КУДА Я НЕСУСЬ"
)

UltimateSpeedButton.MouseButton1Click:Connect(function()
	if ultimateSpeedActive then
		ultimateSpeedActive = false
		local state = setUltimateSpeedState(ultimateSpeedActive)
		toggleUltimateSpeed(state)
	else
		disableAllSpeedFunctions()
		ultimateSpeedActive = true
		local state = setUltimateSpeedState(ultimateSpeedActive)
		toggleUltimateSpeed(state)
	end
end)

local NoclipButton, NoclipToggle, setNoclipState = createFeatureButton(
	"Noclip", "Позволяет проходить сквозь стены"
)

NoclipButton.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	local state = setNoclipState(noclipActive)
	toggleNoclip(state)
end)

local FlyButton, FlyToggle, setFlyState = createFeatureButton(
	"Fly", "Позволяет летать в любом направлении"
)

FlyButton.MouseButton1Click:Connect(function()
	flyActive = not flyActive
	local state = setFlyState(flyActive)
	toggleFly(state)
end)

local ESPButton, ESPToggle, setESPState = createFeatureButton(
	"ESP", "Показывает игроков через стены"
)

ESPButton.MouseButton1Click:Connect(function()
	espActive = not espActive
	local state = setESPState(espActive)
	toggleESP(state)
end)

-- Исправленное перетаскивание окна
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
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

Header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Футер с информацией
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, -20, 0, 30)
Footer.Position = UDim2.new(0, 10, 1, -40)
Footer.BackgroundTransparency = 1
Footer.Text = "Чит создан для поддержки Schelp | Версия 2.5"
Footer.TextColor3 = Color3.fromRGB(150, 150, 150)
Footer.TextSize = 12
Footer.Font = Enum.Font.Gotham
Footer.Parent = MainFrame

-- Обработка выхода персонажа
player.CharacterAdded:Connect(function(character)
	-- Ждем полной загрузки персонажа
	wait(1)

	-- При появлении нового персонажа переустанавливаем функции, если они активны
	if speedActive then
		toggleSpeedHack(true)
	end
	if superSpeedActive then
		toggleSuperSpeed(true)
	end
	if ultimateSpeedActive then
		toggleUltimateSpeed(true)
	end
	if flyActive then
		toggleFly(true)
	end
	if noclipActive then
		toggleNoclip(true)
	end
	if espActive then
		toggleESP(true)
	end
end)

-- Автоматическое отключение noclip при смерти
player.CharacterRemoving:Connect(function()
	if noclipActive and noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
end)
