local ClientApi = {}
local ModuleStarted = false

local function StartModule()
    if ModuleStarted then return end
    ModuleStarted = true
end

function ClientApi.StartModule()
    StartModule()
end

	local function expNeeded(p1) -- line: 3
		return math.ceil(p1 ^ 1.95 + p1 * 8) + 41
	end

	local HttpService = game:GetService("HttpService")

	local function EncodeCooldowns(p2) -- line: 8
		-- upvalues: HttpService (copy)
		local t1 = {}

		for i = 0, 8 do
			local v157 = p2[i]

			if v157 then
				t1[tostring(i)] = {}

				if type(v157) == "table" then
					for k, v in next, v157 do
						t1[tostring(i)][k] = v
					end
				end
			end
		end

		return HttpService:JSONEncode(t1)
	end
	local function DecodeCooldowns(p3) -- line: 24
		-- upvalues: HttpService (copy)
		local data = HttpService:JSONDecode(p3)
		local t2 = {}

		for i = 0, 8 do
			t2[i] = data[tostring(i)]
		end

		return t2
	end

	_G.Cooldowns = {}

	function _G.isBusy() -- line: 36
		for _, v in next, _G.Cooldowns do
			if v[3] == true then
				return true
			end
		end
	end

	_G.Blocking = false
	_G.KO = 0

	function _G.isKO() -- line: 45
		return _G.KO > 0 or _G.PlayersData[game.Players.LocalPlayer].Stunned
	end

	_G.ClientsData = {}
	_G.PlayersData = {}
	_G.BlockedMoves = {}

	local t3 = {
		D1 = {
			Name = "",
			Description = "",
			ProductId = 47584996
		},
		D2 = {
			Name = "",
			Description = "",
			ProductId = 47585001
		},
		D3 = {
			Name = "",
			Description = "",
			ProductId = 47585008
		},
		D4 = {
			Name = "",
			Description = "",
			ProductId = 47585476
		},
		S1 = {
			Name = "",
			Description = "",
			ProductId = 47585486
		},
		S2 = {
			Name = "",
			Description = "",
			ProductId = 47585498
		},
		S3 = {
			Name = "",
			Description = "",
			ProductId = 47585565
		},
		S4 = {
			Name = "",
			Description = "",
			ProductId = 47585574
		},
		RainDrop = {
			Name = "Drops Rain",
			Description = "Everyone will watch as tons of diamonds and shards fall from the sky! Find them in the drop zone and share them with friends!",
			ProductId = 47585712
		},
		ResetPoints = {
			Name = "Refund Stat Points",
			Description = "Want to change your stat selection? Use this to get a refund on your stat points to remake your selection.",
			ProductId = 47585735
		},
		Vip = {
			Name = "VIP",
			Description = "+1.5x shard drop value when you pick them up\n+1.5x EXP multiplier for using magic\n+An exclusive yellow chat color for VIP members only\n+Shard tracker - every time a shard spawns on the map, a ray from coming from the sky will show its location for 3 seconds!\n+Get 1 bonus shard every time someone else picks one up\t\t\t\t\t\n",
			PassId = 603389312
		},
		Premium = {
			Name = "Premium",
			Description = "+Pick up diamonds for 2x their value!\n+2x EXP (stacks, 3x if you own VIP)\n+An exclusive red chat color for Premium members only\n+Diamond tracker - every time a diamond spawns on the map, a ray coming from the sky will show its location for 3 seconds!\n+2x shards value (stacks, 3x if you own vip, only if you pick them up)\n+Get 2 shards every time someone else picks up one(stacks, 3 if you own vip)\n+Lower ultimate cool down when you spawn",
			PassId = 604671045
		},
		Heaven = {
			Name = "Exclusive Map",
			Description = "Get access to a game pass only map with a higher shard and diamond drop rate!",
			PassId = 604668911
		},
		Aura = {
			Name = "White Aura",
			Description = "This game pass will grant you a white cosmetic aura that you can show off to your friends!",
			PassId = 738905856
		}
	}
	local CurrentCamera = workspace.CurrentCamera
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Magics = require(ReplicatedStorage:WaitForChild("Magics"))
	local TypeImages = require(ReplicatedStorage.Magics:WaitForChild("TypeImages"))
	local Enums = require(ReplicatedStorage.Magics:WaitForChild("Enums"))

	_G.MAGICS = Magics
	ReplicatedStorage:WaitForChild("Magics"):Destroy()
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	local LocalPlayer = game.Players.LocalPlayer
	local u12 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local Humanoid = u12:WaitForChild("Humanoid")
	local HumanoidRootPart = u12:WaitForChild("HumanoidRootPart")
	local UserInputService = game:GetService("UserInputService")
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local Main = nil

	tick()

	function touchy(p4) -- line: 166
		-- upvalues: Main (ref), LocalPlayer (copy)
		if not p4.Parent then
			return
		end

		if not Main then
			return
		end

		if p4.Parent.Name == "Increase Cap" then
			local _print = print
			local Level = _G.PlayersData[LocalPlayer].Data.Level

			_print(math.ceil(Level ^ 1.95 + Level * 8) + 41, _G.PlayersData[LocalPlayer].Data.Level)
		end

		if p4.Parent.Name == "Increase Cap" and _G.PlayersData[LocalPlayer].Data.Level >= 225 + _G.PlayersData[LocalPlayer].Data.ExtraLevelCap then
			local Exp = _G.PlayersData[LocalPlayer].Data.Exp
			local Level = _G.PlayersData[LocalPlayer].Data.Level

			if Exp >= math.ceil(Level ^ 1.95 + Level * 8) + 41 - 1 and _G.PlayersData[LocalPlayer].Data.Shards >= 10000 then
				Main.increase.Visible = true
			end
		end
	end

	HumanoidRootPart.Touched:connect(touchy)
	LocalPlayer.CharacterAdded:connect(function(p5) -- line: 195
		-- upvalues: u12 (ref), Humanoid (ref), HumanoidRootPart (ref), Magics (copy), Enums (copy)
		_G.running = false
		u12 = p5
		Humanoid = p5:WaitForChild("Humanoid")
		HumanoidRootPart = p5:WaitForChild("HumanoidRootPart")
		HumanoidRootPart.Touched:connect(touchy)
		_G.Cooldowns = {}
		_G.BlockedMoves = {}
		_G.KO = 0

		for _, v in next, Magics do
			for _, v2 in next, v.Attacks do
				_G.Cooldowns[v2.Type] = {
					v2.MagicType,
					v2.Name,
					false
				}

				if v2.Type == Enums.MoveType.Ultimate then
					_G.BlockedMoves[v2.Type] = true
				end
			end
		end
	end)
	_G.safezoned = true

	local t4 = {}
	local g68 = nil
	local v67 = nil

	for _, v in next, workspace:WaitForChild("Map"):WaitForChild("SafeZones"):GetChildren() do
		t4[#t4 + 1] = {
			pos = v.Position,
			radius = v.Mesh.Scale.x / 2
		}
	end

	print("SAFEZONES")

	local u21 = false
	local Mouse = LocalPlayer:GetMouse()
	local v23 = workspace:WaitForChild(".Ignore")

	Mouse.TargetFilter = v23
	Main = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main")

	local RequiredBar = Main:WaitForChild("RequiredBar")

	RequiredBar.Name = "RequiredStamina"

	local clone = Main:WaitForChild("RequiredStamina"):Clone()

	clone.Name = "RequiredMana"
	clone.Parent = Main:WaitForChild("SkillsBar"):WaitForChild("Energy")

	local Health = Main.SkillsBar.Health
	local Energy = Main.SkillsBar.Energy
	local Stamina = Main.SkillsBar.Stamina
	local Experience = Main.Frame1.Experience
	local TextLabel = Main.Frame1.Level.TextLabel
	local Shards = Main.Frame1.Shards
	local Diamonds = Main.Frame1.Diamonds
	local t5 = {}

	for _, child in pairs(Main:WaitForChild("Shop").GamepassesContainer:GetChildren()) do
		table.insert(t5, child)
	end

	for _, child in pairs(Main:WaitForChild("Shop").ProductsContainer:GetChildren()) do
		table.insert(t5, child)
	end

	print("PASSES")

	local t6 = {}

	for _, v in next, Magics do
		for _, v3 in next, v.Attacks do
			_G.Cooldowns[v3.Type] = {
				v3.MagicType,
				v3.Name,
				false
			}
		end
	end

	Remotes.ClientData.OnClientEvent:connect(function(p6, p7) -- line: 259
		-- upvalues: DecodeCooldowns (copy)
		if type(p7.Cooldowns) == "string" then
			p7.Cooldowns = DecodeCooldowns(p7.Cooldowns)
		end

		_G.ClientsData[p6] = p7
	end)
	Remotes.PlayerData.OnClientEvent:connect(function(p8, p9) -- line: 266
		_G.PlayersData[p8] = p9
	end)
	Remotes.Combat.OnClientEvent:connect(function(p10, p11) -- line: 271
		-- upvalues: Humanoid (ref), HumanoidRootPart (ref)
		_G.KO = _G.KO + p10
		Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
		HumanoidRootPart.Velocity = p11 or Vector3.new()
	end)

	local u43 = nil

	repeat
		wait(0)
	until _G.PlayersData[LocalPlayer]

	print("READY")

	local u44 = _G.PlayersData[LocalPlayer].Data.Diamonds == 150 and (_G.PlayersData[LocalPlayer].Data.Level == 0 and _G.PlayersData[LocalPlayer].Data.Exp == 0)

	if u44 then
		local Next = Main.Frame1.TutWindow.Next
		local ImageButton = Main.welcome.ImageButton

		Next.MouseEnter:connect(function() -- line: 287
			-- upvalues: Next (copy)
			Next.ImageColor3 = Color3.new(0.85, 0.85, 0.85)
		end)
		Next.MouseLeave:connect(function() -- line: 290
			-- upvalues: Next (copy)
			Next.ImageColor3 = Color3.new(1, 1, 1)
		end)
		ImageButton.MouseEnter:connect(function() -- line: 293
			-- upvalues: ImageButton (copy)
			ImageButton.ImageColor3 = Color3.new(0.85, 0.85, 0.85)
		end)
		ImageButton.MouseLeave:connect(function() -- line: 296
			-- upvalues: ImageButton (copy)
			ImageButton.ImageColor3 = Color3.new(1, 1, 1)
		end)
	end

	local n1 = 0

	local function updateTutorial() -- line: 301
		-- upvalues: n1 (ref), Main (ref), updateTutorial (copy), u43 (ref), UserInputService (copy), u44 (ref), LocalPlayer (copy)
		n1 = n1 + 1

		local Arrow = Main.Frame1.Arrow
		local TutWindow = Main.Frame1.TutWindow
		local TutorialText = TutWindow.TutorialText

		if n1 == 1 then
			TutWindow.Next.Image = "rbxassetid://619804494"
			Arrow.Position = UDim2.new(1, 0, 0.75, 0)
			Arrow.Rotation = -180
			TutWindow.Position = UDim2.new(0, 5, -1, 0)
			TutorialText.Text = "This is your Diamonds and Shards. You can spend these on new elements to fight!"
			TutWindow.Visible = true
			Arrow.Visible = true
			TutWindow.Next.MouseButton1Up:wait()
			TutWindow.Next.Visible = false
			updateTutorial()

			return
		end

		if n1 == 2 then
			Arrow.Position = UDim2.new(0.35, 0, -0.3, 0)
			Arrow.Rotation = 90
			TutWindow.Position = UDim2.new(0, 5, -1, 0)
			TutorialText.Text = "This blue button is the elements shop, you can purchase your starter element here. Click it to continue."
			Main.Frame1.Book.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 3 then
			TutWindow.Position = UDim2.new(0, 5, 0.5, 0)
			Arrow.Visible = false
			TutorialText.Text = "Please choose your first element. Click purchase on one of these starter elements to continue."

			local u185 = nil

			u185 = Main.Book.InfoFrame.Changed:connect(function() -- line: 329
				-- upvalues: Main (ref), u185 (ref), updateTutorial (copy)
				if Main.Book.InfoFrame.Visible then
					u185:disconnect()
					updateTutorial()
				end
			end)

			return
		end

		if n1 == 4 then
			TutorialText.Text = "Great! Now purchase 2 moves for this element for 75 and 100 Shards."
			Main.Book.InfoFrame.Moves.b2.TextButton.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 5 then
			TutorialText.Text = "Good job! Buy 1 more move for 100 Shards."
			Main.Book.InfoFrame.Moves.b3.TextButton.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 6 then
			TutWindow.Position = UDim2.new(0, 5, -1, 0)
			Arrow.Position = UDim2.new(0.1, 0, -0.3, 0)
			Arrow.Visible = true
			TutorialText.Text = "Now, click the orange button to view your inventory and character stats."
			Main.Frame1.Character.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 7 then
			TutWindow.Position = UDim2.new(0, 5, 0.6, 0)
			Arrow.Visible = false
			TutWindow.Next.Visible = true
			TutorialText.Text = "On the left side of this page you can equip your new spells. On the right side you can spend your stat points."
			TutWindow.Next.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 8 then
			TutWindow.Position = UDim2.new(0, 5, -1, 0)
			Main.SelectSlot.Position = UDim2.new(0, -400, 0, 0)
			u43 = nil
			bindKeys()
			Main.Character.Visible = false

			if Main.Shop.Visible or Main.Book.Visible then
				Main.Shop.Visible = false
				Main.Book.Visible = false
			end

			if UserInputService.TouchEnabled then
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not (Main.Character.Visible or (Main.Shop.Visible or Main.Book.Visible)))
			end

			TutorialText.Text = "To level up, practice using your magic. You can also defeat other players to gain more experience and shards."
			TutWindow.Next.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 9 then
			if UserInputService.TouchEnabled then
				TutorialText.Text = "The controls are: double tap your jump button to flip and press the small gray button on the right to run."
			else
				TutorialText.Text = "There are also a few important movement controls. Double tap WASD to do flips and press Ctrl/Cmd to toggle sprint."
			end

			TutWindow.Next.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 10 then
			if UserInputService.TouchEnabled then
				TutorialText.Text = "To toggle blocking, tap the small gray button on the left. However, blocking costs stamina!"
			else
				TutorialText.Text = "For your combat, you can press Q to punch and hold R to block. However, blocking costs stamina!"
			end

			TutWindow.Next.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 11 then
			TutorialText.Text = "Finally, you can charge some spells by holding left click before you release to fire. That's all, have fun!"
			TutWindow.Next.Image = "rbxassetid://619804347"
			TutWindow.Next.MouseButton1Up:wait()
			updateTutorial()

			return
		end

		if n1 == 12 then
			TutWindow.Visible = false
			u44 = false
			LocalPlayer.PlayerGui.Menu.MenuButton.Position = UDim2.new(0, 0, 0.5, 0)
		end
	end

	coroutine.resume(coroutine.create(function() -- line: 400
		-- upvalues: u44 (ref), LocalPlayer (copy), Main (ref), updateTutorial (copy), n1 (ref)
		if u44 then
			LocalPlayer.PlayerGui.Menu.MenuButton.Position = UDim2.new(0, -1000, 0, -1000)
			Main.welcome.Visible = true
			Main.welcome.ImageButton.MouseButton1Up:wait()
			Main.welcome.Visible = false
			updateTutorial()

			return
		end

		n1 = 12
	end))

	local function findAttackByKey(p12) -- line: 412
		-- upvalues: t6 (ref)
		for _, v in next, t6 do
			if p12 == v.keybind then
				return v.move
			end
		end
	end
	local function createSkill(p13) -- line: 419
		-- upvalues: Main (ref), Magics (copy), TypeImages (copy)
		local clone2 = Main.Skill:Clone()

		clone2.BackgroundColor3 = Magics[p13.MagicType].ImageColor
		clone2.Image = TypeImages[p13.Type]
		clone2.ImageColor3 = Color3.new(0, 0, 0)
		clone2.Visible = true

		return clone2
	end

	local t7 = {
		Enum.KeyCode.One,
		Enum.KeyCode.Two,
		Enum.KeyCode.Three,
		Enum.KeyCode.Four,
		Enum.KeyCode.Five
	}
	local n2 = 1
	local u53 = nil
	local t8 = {}

	function bindKeys() -- line: 435
		-- upvalues: Main (ref), t8 (copy), t6 (ref), Magics (copy), TypeImages (copy), t7 (copy), UserInputService (copy), u53 (ref), Remotes (copy)
		for _, v in next, Main.SkillsBar:GetChildren() do
			if v:FindFirstChild("N") then
				v:Destroy()
			end
		end

		for _, v in next, Main.Character.Backpack:GetChildren() do
			if v:FindFirstChild("N") then
				v:Destroy()
			end
		end

		for _, v in next, t8 do
			v:disconnect()
		end

		local t9 = {}

		for _, v in next, t6 do
			if v.keybind then
				table.insert(t9, {
					Name = v.move.Name,
					Keybind = v.keybind
				})

				local move = v.move
				local clone3 = Main.Skill:Clone()

				clone3.BackgroundColor3 = Magics[move.MagicType].ImageColor
				clone3.Image = TypeImages[move.Type]
				clone3.ImageColor3 = Color3.new(0, 0, 0)
				clone3.Visible = true
				clone3.Name = v.keybind
				clone3.N.Text = v.keybind
				clone3.AnchorPoint = Vector2.new(0.5, 0)
				clone3.Position = UDim2.new(-0.025 + 0.175 * v.keybind, 0, 0.1, 0)
				clone3.Parent = Main.SkillsBar
				clone3.MouseButton1Up:connect(function() -- line: 463
					-- upvalues: v (copy)
					selectAttack(v.keybind, Enum.UserInputState.Begin, {
						KeyCode = v.keybind
					})
				end)
				game:GetService("ContextActionService"):BindAction(v.keybind, selectAttack, false, t7[v.keybind], Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1)

				local clone4 = clone3:Clone()

				clone4.LayoutOrder = v.keybind
				clone4.Size = UDim2.new(0.7, 0, 0.7, 0)
				clone4.Parent = Main.Character.Backpack
				t8[#t8 + 1] = clone4.MouseButton1Up:connect(function() -- line: 472
					-- upvalues: UserInputService (copy), Main (ref), v (copy), u53 (ref)
					if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
						print("A")
						game:GetService("GuiService").SelectedObject = Main.Frame1.Character
					end

					game:GetService("ContextActionService"):UnbindAction(v.keybind)

					if u53 == v.keybind then
						u53 = nil
					end

					v.keybind = false
					selectAttack(v.keybind, Enum.UserInputState.Begin)
					bindKeys()
				end)

				if u53 == v.keybind then
					selectAttack(v.keybind, Enum.UserInputState.Begin)
				end
			end
		end

		Remotes.SendLoadout:FireServer(t9)
	end

	for _, v in next, Main:WaitForChild("SelectSlot"):WaitForChild("Grid"):GetChildren() do
		if v:IsA("TextButton") then
			v.MouseButton1Up:connect(function() -- line: 495
				-- upvalues: u43 (ref), t6 (ref), v (copy), UserInputService (copy), Main (ref)
				if u43 then
					for _, v4 in next, t6 do
						if v4.keybind and v4.keybind == tonumber(v.Name) then
							v4.keybind = false
						end
					end

					u43.keybind = tonumber(v.Name)

					if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
						game:GetService("GuiService").SelectedObject = Main.Frame1.Character
					end

					Main.SelectSlot.Position = UDim2.new(0, -1000, 0, 0)
					u43 = nil
					bindKeys()
				end
			end)
		end
	end

	local t10 = {}

	local function updateAvailableMoves() -- line: 514
		-- upvalues: t6 (ref), Magics (copy), LocalPlayer (copy), Main (ref), t10 (copy), TypeImages (copy), Mouse (copy), UserInputService (copy), u43 (ref)
		local v205 = t6

		t6 = {}

		local n3 = 0

		for _, _ in next, Magics do
			n3 = n3 + 1
		end

		local t11 = {}

		for i = 1, n3 do
			local t12 = {}

			for k, v in next, _G.PlayersData[LocalPlayer].Data.Magics do
				if Magics[k] and i == Magics[k].Index and not t11[k] then
					t11[k] = true

					for _, v5 in next, Magics[k].Attacks do
						if v.Unlocked >= v5.Id then
							local v216 = false

							for _, v6 in next, v205 do
								if v6.move.Name == v5.Name then
									v216 = v6.keybind
								end
							end

							t12[v5.Id] = {
								keybind = v216,
								move = v5
							}
						end
					end

					for _, v7 in next, t12 do
						table.insert(t6, v7)
					end
				end
			end
		end

		for _, v in next, Main.Character.Available.ScrollingFrame.Frame:GetChildren() do
			if not v:IsA("UIComponent") then
				v:Destroy()
			end
		end

		for _, v in next, t10 do
			v:disconnect()
		end

		local n4 = 0
		local n5 = 0

		for _, v in next, t6 do
			n4 = n4 + 1

			if n4 % 6 == 0 then
				n4 = 1
				n5 = n5 + 1
			end

			local move = v.move
			local clone5 = Main.Skill:Clone()

			clone5.BackgroundColor3 = Magics[move.MagicType].ImageColor
			clone5.Image = TypeImages[move.Type]
			clone5.ImageColor3 = Color3.new(0, 0, 0)
			clone5.Visible = true
			clone5.Name = v.move.Name
			clone5.N.Visible = false
			clone5.Position = UDim2.new(0, n4 * 52 + -38, 0, n5 * 52)
			Instance.new("UIAspectRatioConstraint").Parent = clone5
			clone5.Parent = Main.Character.Available.ScrollingFrame.Frame
			t10[#t10 + 1] = clone5.MouseButton1Up:connect(function() -- line: 574
				-- upvalues: Main (ref), Mouse (copy), UserInputService (copy), u43 (ref), v (copy)
				Main.SelectSlot.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)

				if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
					game:GetService("GuiService").SelectedObject = Main.SelectSlot.Grid["1"]
				end

				u43 = v
			end)
			Main.Character.Available.ScrollingFrame.CanvasSize = UDim2.new(0, 0, (n5 + 1) * 0.333, 0)
			Main.Character.Available.ScrollingFrame.Frame.UIGridLayout.CellSize = UDim2.new(0.19, 0, 1 / (n5 + 1), -1)
		end

		bindKeys()
	end

	updateAvailableMoves()

	local function GetIndexByName(p14) -- line: 593
		-- upvalues: t6 (ref)
		for k, v in next, t6 do
			if p14 == v.move.Name then
				return k
			end
		end
	end

	local v60 = _G.PlayersData[LocalPlayer].Data.Loadout or {}

	if #v60 == 0 then
		for i = 1, math.min(5, #t6) do
			t6[i].keybind = i
		end
	else
		for _, v in next, v60 do
			local vName = v.Name

			for k, v8 in next, t6 do
				if vName == v8.move.Name then
					v67 = k
					g68 = true
				end

				if g68 then
					break
				end
			end

			if not g68 then
				v67 = nil
			end

			g68 = false

			if v67 then
				t6[v67].keybind = v.Keybind
			end
		end
	end

	local function v69() -- line: 615
		-- upvalues: t6 (ref), Main (ref), LocalPlayer (copy)
		for _, v in next, t6 do
			if v.keybind and Main.SkillsBar:FindFirstChild(v.keybind) then
				if _G.PlayersData[LocalPlayer].Stunned or _G.BlockedMoves[v.move.Type] or _G.Cooldowns[v.move.Type][3] == true then
					Main.SkillsBar[v.keybind].CD.Text = "..."
				end

				Main.SkillsBar[v.keybind].CD.Visible = (_G.PlayersData[LocalPlayer].Stunned or _G.BlockedMoves[v.move.Type]) and true or not not _G.Cooldowns[v.move.Type][3]
			end
		end
	end

	Remotes.GetCooldown.OnClientEvent:connect(function(p15, p16, p17, p18) -- line: 625
		-- upvalues: v69 (copy)
		wait(0)

		local v240 = type(p18) == "number"

		_G.Cooldowns[p15] = {
			p16,
			p17,
			v240 and tick() or p18
		}
		v69()
	end)
	Remotes.GetBlock.OnClientEvent:connect(function(p19, p20) -- line: 631
		-- upvalues: v69 (copy)
		wait(0)
		_G.BlockedMoves[p19] = p20
		v69()
	end)

	function selectAttack(p21, p22, p23) -- line: 637
		-- upvalues: u21 (ref), n2 (ref), u53 (ref), t6 (ref), Main (ref)
		if p22 == Enum.UserInputState.Begin then
			u21 = false

			if p23 and p23.UserInputType == Enum.UserInputType.Gamepad1 then
				local v246 = p23.KeyCode ~= Enum.KeyCode.ButtonR1 and -1 or 1

				p21 = tostring(n2 % 5 + v246)

				if tonumber(p21) <= 0 then
					if u53 == 5 then
						p21 = tostring(4)
					else
						p21 = tostring(5)
					end
				end

				n2 = n2 + v246
			end

			if u53 == tonumber(p21) then
				for _, v in next, t6 do
					if v.keybind and Main.SkillsBar:FindFirstChild(v.keybind) then
						local v249 = Main.SkillsBar[v.keybind]

						u53 = nil
						v249.BorderSizePixel = 0
						v249:TweenPosition(UDim2.new(-0.025 + 0.175 * v.keybind, 0, 0.1, 0), "Out", "Quad", 0.1, true)
					end
				end

				return
			end

			for _, v in next, t6 do
				if v.keybind then
					local vkeybind = Main.SkillsBar:FindFirstChild(v.keybind)

					if vkeybind then
						if v.keybind == tonumber(p21) then
							u53 = v.keybind
							vkeybind:TweenPosition(UDim2.new(-0.025 + 0.175 * v.keybind, 0, 0.05, 0), "Out", "Quad", 0.1, true)
							vkeybind.BorderSizePixel = 2
						else
							vkeybind.BorderSizePixel = 0
							vkeybind:TweenPosition(UDim2.new(-0.025 + 0.175 * v.keybind, 0, 0.1, 0), "Out", "Quad", 0.1, true)
						end
					end
				end
			end
		end
	end

	local Tooltip = Main.Tooltip

	bindKeys()
	Mouse.Button1Up:connect(function() -- line: 692
		-- upvalues: u21 (ref)
		u21 = false
	end)
	Mouse.Button1Down:connect(function() -- line: 695
		-- upvalues: u21 (ref), Main (ref), u43 (ref), u53 (ref), t6 (ref), LocalPlayer (copy), Humanoid (ref), clone (copy), Enums (copy), v69 (copy), UserInputService (copy), Remotes (copy)
		u21 = true

		local g257 = nil
		local move = nil

		if Main.SelectSlot.Position.X.Offset > -1000 and not collides(Main.SelectSlot) then
			u43 = nil
			Main.SelectSlot.Position = UDim2.new(0, -1000, 0, 0)
		end

		local v253 = u53

		for _, v in next, t6 do
			if v253 == v.keybind then
				move = v.move
				g257 = true
			end

			if g257 then
				break
			end
		end

		if not g257 then
			move = nil
		end

		g257 = false

		local v258 = move

		if _G.PlayersData[LocalPlayer].Stunned or _G.safezoned or not v258 or _G.Cooldowns[v258.Type][3] or _G.BlockedMoves[v258.Type] or Humanoid.Health <= 0 or _G.Blocking then
			return
		end

		if _G.PlayersData[LocalPlayer].Mana < v258.EnergyCost then
			local v259 = _G.PlayersData[LocalPlayer].Mana / _G.PlayersData[LocalPlayer].MaxMana - v258.EnergyCost / _G.PlayersData[LocalPlayer].MaxMana

			clone.Size = UDim2.new(v259, 0, 1, 0)
			clone.Position = UDim2.new(_G.PlayersData[LocalPlayer].Mana / _G.PlayersData[LocalPlayer].MaxMana - v259, 0, 0, 0)
			clone.BackgroundTransparency = 0

			return
		end

		_G.Cooldowns[v258.Type] = {
			v258.MagicType,
			v258.Name,
			true
		}

		if v258.Type == Enums.MoveType.Ultimate then
			for i = 0, 8 do
				if i ~= Enums.MoveType.Ultimate then
					_G.BlockedMoves[i] = true
				end
			end
		end

		v69()
		wait(0)
		v258:ClientFunction(nil, function(p24) -- line: 722
			-- upvalues: UserInputService (copy), u53 (ref), Remotes (copy), v258 (copy)
			if UserInputService.TouchEnabled and u53 then
				selectAttack(u53, Enum.UserInputState.Begin)
			end

			return Remotes.DoMagic:InvokeServer(v258.MagicType, v258.Name, p24)
		end)
	end)

	function collides(p25) -- line: 731
		-- upvalues: Mouse (copy)
		local AbsolutePosition = p25.AbsolutePosition
		local AbsoluteSize = p25.AbsoluteSize

		return AbsolutePosition.x < Mouse.X and (AbsolutePosition.x + AbsoluteSize.x > Mouse.X and (AbsolutePosition.y < Mouse.Y and AbsolutePosition.y + AbsoluteSize.y > Mouse.Y))
	end

	local clone6 = Tooltip:Clone()

	clone6.Size = UDim2.new(0, 200, 0, 1000)
	clone6.Position = UDim2.new(0, -1000, 0, 0)
	clone6.Parent = Main

	local u72 = nil

	local function v73(p26) -- line: 742
		-- upvalues: HumanoidRootPart (ref), u12 (ref)
		local Part = Instance.new("Part")

		Part.Transparency = 1
		Part.Anchored = false
		Part.CanCollide = false
		Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)

		local Motor6D = Instance.new("Motor6D", Part)

		Motor6D.Part0 = Part
		Motor6D.Part1 = HumanoidRootPart

		local BodyPosition = Instance.new("BodyPosition")

		BodyPosition.maxForce = Vector3.new(0, 75000, 0)
		BodyPosition.position = p26
		BodyPosition.Parent = Part
		Part.Parent = u12

		return {
			aim = function(_, p28) -- line: 757
				-- upvalues: BodyPosition (copy)
				BodyPosition.position = p28
			end,
			kill = function(_) -- line: 760
				-- upvalues: Part (copy)
				Part:Destroy()
			end
		}
	end

	game:GetService("RunService").RenderStepped:connect(function(p30) -- line: 768
		-- upvalues: Mouse (copy), LocalPlayer (copy), CurrentCamera (copy), u21 (ref), t6 (ref), Magics (copy), Main (ref), v69 (copy), Tooltip (copy), clone6 (copy), t5 (copy), t3 (copy), HumanoidRootPart (ref), u12 (ref), v23 (copy), u72 (ref), v73 (copy), Humanoid (ref)
		local p = Mouse.Hit.p

		_G.ClientsData[LocalPlayer] = {
			Mouse = p,
			Camera = CurrentCamera.CFrame.p,
			Holding = u21,
			Cooldowns = _G.Cooldowns
		}

		for _, v in next, t6 do
			local v272 = _G.Cooldowns[v.move.Type]

			if v272 and v.keybind and type(v272[3]) == "number" and not _G.BlockedMoves[v.move.Type] then
				local v273 = tick() - v272[3]

				if Magics[v272[1]].Attacks[v272[2]].Cooldown - v273 > 0 then
					Main.SkillsBar[v.keybind].CD.Visible = true
					Main.SkillsBar[v.keybind].CD.Text = math.max(1, (math.ceil(Magics[v272[1]].Attacks[v272[2]].Cooldown - v273)))
				else
					Main.SkillsBar[v.keybind].CD.Visible = false
				end
			end
		end

		v69()

		if Main.Book.Visible and Main.Book.InfoFrame.Visible then
			for _, v in next, Main.Book.InfoFrame.Moves:GetChildren() do
				local v276, v277 = string.match(v.Name, "(.+)/(.+)")
				local v278 = Magics[v276]

				if v278 and collides(v) then
					local v279 = v278.Attacks[v277]

					if v279 then
						Tooltip.Title.Text = v279.Name
						Tooltip.Desc.Text = v279.Description
						clone6.Desc.Text = v279.Description

						local v280 = 30 + clone6.Desc.TextBounds.Y * 1.175

						Tooltip.Size = UDim2.new(0, 200, 0, v280)
						Tooltip.Position = UDim2.new(0, Mouse.X + 5, 0, Mouse.Y - v280 - 5)
						Tooltip.Visible = true

						break
					end
				else
					Tooltip.Visible = false
				end
			end
		elseif Main.Shop.Visible then
			for _, v in next, t5 do
				local v283 = t3[string.match(v.Name, "(.+)")]

				if v283 and v283.Name ~= "" and collides(v) then
					Tooltip.Title.Text = v283.Name
					Tooltip.Desc.Text = v283.Description
					clone6.Desc.Text = v283.Description

					local v284 = 30 + clone6.Desc.TextBounds.Y * 1.175

					Tooltip.Size = UDim2.new(0, 250, 0, v284)
					Tooltip.Position = UDim2.new(0, Mouse.X + 5, 0, Mouse.Y + 5)
					Tooltip.Visible = true

					break
				end

				Tooltip.Visible = false
			end
		else
			for _, v in next, t6 do
				if v.keybind and Main.SkillsBar:FindFirstChild(v.keybind) and collides(Main.SkillsBar[v.keybind]) then
					local move = v.move

					if move then
						Tooltip.Title.Text = move.Name
						Tooltip.Desc.Text = move.Description
						clone6.Desc.Text = move.Description

						local v288 = 30 + clone6.Desc.TextBounds.Y * 1.175

						Tooltip.Size = UDim2.new(0, 200, 0, v288)
						Tooltip.Position = UDim2.new(0, Mouse.X + 5, 0, Mouse.Y - v288 - 5)
						Tooltip.Visible = true

						break
					end
				elseif Main.Character.Visible and Main.Character.Available.ScrollingFrame.Frame:FindFirstChild(v.move.Name) and collides(Main.Character.Available.ScrollingFrame) and collides(Main.Character.Available.ScrollingFrame.Frame[v.move.Name]) then
					local move = v.move

					if move then
						Tooltip.Title.Text = move.Name
						Tooltip.Desc.Text = move.Description
						clone6.Desc.Text = move.Description

						local v290 = 30 + clone6.Desc.TextBounds.Y * 1.175

						Tooltip.Size = UDim2.new(0, 200, 0, v290)
						Tooltip.Position = UDim2.new(0, Mouse.X + 5, 0, Mouse.Y - v290 - 5)
						Tooltip.Visible = true

						break
					end
				else
					Tooltip.Visible = false
				end
			end
		end

		local ray = Ray.new(HumanoidRootPart.CFrame.p + Vector3.new(0, 3, 0), (Vector3.new(0, -4, 0)))
		local part, position = workspace:FindPartOnRayWithIgnoreList(ray, {
			u12,
			v23[".Attacks"],
			v23[".Floors"],
			v23[".LocalEffects"],
			v23[".ServerEffects"]
		})

		if part and part.Name == ".Water" and not u72 then
			u72 = v73(position)
		elseif part and part.Name == ".Water" and u72 then
			u72:aim(position)
		elseif not part and u72 then
			u72:kill()
			u72 = nil
		end

		if _G.KO > 0 then
			_G.KO = _G.KO - p30

			if _G.KO < 0 then
				_G.KO = 0
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

				return
			end

			Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
		end
	end)

	local CreateParty = Main:WaitForChild("CreateParty")
	local MembersFrame = Main:WaitForChild("MembersFrame")
	local InviteParty = Main:WaitForChild("InviteParty")
	local InviteFrame = Main:WaitForChild("InviteFrame")

	if workspace:FindFirstChild(".WavesMode") then
		CreateParty.Visible = false
	end

	local CreatePartyImage = CreateParty.Image
	local InvitePartyImage = InviteParty.Image
	local Copy = InviteFrame:WaitForChild("ScrollingFrame"):WaitForChild("Copy")
	local clone7 = Copy:Clone()

	Copy:Destroy()

	local Copy2 = MembersFrame:WaitForChild("Frame"):WaitForChild("Copy")
	local clone8 = Copy2:Clone()

	Copy2:Destroy()

	local u84 = false
	local u85 = false
	local s1 = ""
	local t13 = {}
	local u88 = nil

	local function upd_invites() -- line: 907
		-- upvalues: InviteFrame (copy), clone7 (copy), u84 (ref), Remotes (copy)
		for _, v in next, InviteFrame.ScrollingFrame:GetChildren() do
			v:Destroy()
		end

		local players = game.Players:GetPlayers()

		InviteFrame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #players * 25 + 5)

		for k, v in next, players do
			local clone9 = clone7:Clone()

			clone9.Position = UDim2.new(0, 5, 0, 10 + (k - 1) * 25)
			clone9.Text = v.Name

			if k == 1 then
				clone9.ImageButton:Destroy()
			else
				local u300 = false

				clone9.ImageButton.MouseButton1Up:connect(function() -- line: 921
					-- upvalues: u84 (ref), u300 (ref), clone9 (copy), Remotes (copy), v (copy)
					if u84 or u300 then
						return
					end

					u84 = true
					u300 = true
					clone9.ImageButton.Image = "rbxassetid://572347884"
					Remotes.ManageParty:InvokeServer("Invite", v)
					u84 = false
					wait(3)
					u300 = false

					if clone9:FindFirstChild("ImageButton") then
						clone9.ImageButton.Image = "rbxassetid://571048083"
					end
				end)
			end

			clone9.Parent = InviteFrame.ScrollingFrame
		end
	end
	local function v90(p31) -- line: 938
		-- upvalues: u88 (ref), t13 (ref), s1 (ref), u85 (ref), InviteParty (copy), InvitePartyImage (copy), MembersFrame (copy), InviteFrame (copy), CreateParty (copy), LocalPlayer (copy), upd_invites (copy), clone8 (copy), u84 (ref), Remotes (copy), CreatePartyImage (copy)
		u88 = p31
		t13 = p31 or {}

		if p31 then
			if s1 == "" then
				u85 = false
				InviteParty.Image = InvitePartyImage
				MembersFrame.Visible = true
				InviteFrame.Visible = false
			end

			s1 = "InParty"
			CreateParty.Image = "rbxassetid://571200296"

			if p31[1] == LocalPlayer then
				InviteParty.Visible = true
				upd_invites()
			else
				InviteParty.Visible = false
			end

			for _, v in next, MembersFrame.Frame:GetChildren() do
				v:Destroy()
			end

			for k, v in next, p31 do
				local clone10 = clone8:Clone()

				clone10.Name = v.Name
				clone10.Position = UDim2.new(0, 5, 0, 10 + (k - 1) * 25)
				clone10.Text = v.Name

				if k == 1 or v == LocalPlayer or p31[1] ~= LocalPlayer then
					clone10.ImageButton:Destroy()
				else
					clone10.ImageButton.MouseButton1Up:connect(function() -- line: 967
						-- upvalues: u84 (ref), Remotes (copy), v (copy)
						if u84 then
							return
						end

						u84 = true
						Remotes.ManageParty:InvokeServer("Kick", v)
						u84 = false
					end)
				end

				clone10.Parent = MembersFrame.Frame
			end

			return
		end

		s1 = ""
		InviteParty.Image = "rbxassetid://571200340"
		CreateParty.Image = CreatePartyImage
		MembersFrame.Visible = false
		InviteFrame.Visible = false
		InviteParty.Visible = false
	end

	CreateParty.MouseButton1Up:connect(function() -- line: 985
		-- upvalues: u84 (ref), s1 (ref), u85 (ref), Remotes (copy), v90 (copy)
		if u84 then
			return
		end

		u84 = true

		local v307 = s1

		if v307 == "" then
			u85 = false
			v307 = "Create"
		elseif v307 == "InParty" then
			v307 = "Leave"
		end

		local v308 = Remotes.ManageParty:InvokeServer(v307)

		v90(v308)
		u84 = false
	end)
	InviteParty.MouseButton1Up:connect(function() -- line: 999
		-- upvalues: u85 (ref), InviteParty (copy), InvitePartyImage (copy), v90 (copy), u88 (ref), MembersFrame (copy), InviteFrame (copy)
		u85 = not u85

		local v309 = InviteParty
		local s2

		if u85 then
			s2 = "rbxassetid://571200340"
		else
			s2 = InvitePartyImage
		end

		v309.Image = s2
		v90(u88)

		if u85 then
			MembersFrame.Visible = false
			InviteFrame.Visible = true

			return
		end

		MembersFrame.Visible = true
		InviteFrame.Visible = false
	end)

	local u91 = nil

	function Remotes.ManageParty.OnClientInvoke(p32, p33) -- line: 1012
		-- upvalues: Main (ref), u91 (ref), v90 (copy), upd_invites (copy)
		if p32 == "Invite" then
			Main.Invitation.TextLabel.Text = "PARTY INVITATION FROM " .. string.upper(p33.Name)
			Main.Invitation.Visible = true
			u91 = p33

			return
		end

		if p32 == "Update" then
			v90(p33)

			return
		end

		if p32 == "RefreshInvitations" then
			upd_invites()
		end
	end

	Main.Invitation.Accept.MouseButton1Up:connect(function() -- line: 1023
		-- upvalues: u84 (ref), Remotes (copy), u91 (ref), v90 (copy), Main (ref)
		if u84 then
			return
		end

		u84 = true

		local v313 = Remotes.ManageParty:InvokeServer("AcceptInvite", u91)

		v90(v313)
		Main.Invitation.Visible = false
		u84 = false
	end)
	Main.Invitation.Cancel.MouseButton1Up:connect(function() -- line: 1031
		-- upvalues: Main (ref)
		Main.Invitation.Visible = false
	end)

	local Graph = require(game.ReplicatedStorage.Graph)
	local Stats = _G.PlayersData[LocalPlayer].Data.Stats
	local v94, v95 = Graph.Start(Main.Character.Graph, {
		{
			"Power",
			Stats.Power
		},
		{
			"Defense",
			Stats.Defense
		},
		{
			"Speed",
			Stats.Speed
		},
		{
			"Max Health",
			Stats.MaxHP
		},
		{
			"Max Mana",
			Stats.MaxMP
		},
		{
			"Max Stamina",
			Stats.MaxSP
		}
	}, 100)

	local function updateCharMenu(p34) -- line: 1044
		-- upvalues: LocalPlayer (copy), Main (ref), v94 (copy)
		local v315 = p34 or _G.PlayersData[LocalPlayer].Data
		local Stats2 = v315.Stats

		Main.Character.Points.Text = "Available skill points: " .. v315.Points
		v94({
			{
				"Power",
				Stats2.Power
			},
			{
				"Defense",
				Stats2.Defense
			},
			{
				"Speed",
				Stats2.Speed
			},
			{
				"Max Health",
				Stats2.MaxHP
			},
			{
				"Max Mana",
				Stats2.MaxMP
			},
			{
				"Max Stamina",
				Stats2.MaxSP
			}
		})
	end

	function Remotes.SpendPoint.OnClientInvoke(p35) -- line: 1057
		-- upvalues: updateCharMenu (copy)
		updateCharMenu(p35)
	end

	local u97 = false

	coroutine.resume(coroutine.create(function() -- line: 1062
		-- upvalues: u97 (ref), Remotes (copy)
		u97 = Remotes.IsVipServer:InvokeServer()
	end))

	local MarketplaceService = game:GetService("MarketplaceService")

	for _, v in next, t5 do
		local match = string.match(v.Name, "(.+)")
		local v102 = t3[match]

		if v102 then
			v.MouseButton1Up:connect(function() -- line: 1071
				-- upvalues: v102 (copy), match (copy), u97 (ref), MarketplaceService (copy), LocalPlayer (copy)
				if v102.ProductId then
					if match == "RainDrop" and u97 then
						return
					end

					MarketplaceService:PromptProductPurchase(LocalPlayer, v102.ProductId)

					return
				end

				MarketplaceService:PromptPurchase(LocalPlayer, v102.PassId)
			end)
		end
	end

	Main.Character.Reset.MouseButton1Up:connect(function() -- line: 1083
		-- upvalues: MarketplaceService (copy), LocalPlayer (copy), t3 (copy)
		MarketplaceService:PromptProductPurchase(LocalPlayer, t3.ResetPoints.ProductId)
	end)
	Remotes.RefreshCharacterPage.OnClientEvent:connect(function() -- line: 1086
		-- upvalues: updateCharMenu (copy)
		updateCharMenu()
	end)
	Main.Frame1.Character.MouseButton1Up:connect(function() -- line: 1089
		-- upvalues: n1 (ref), Main (ref), updateAvailableMoves (copy), u53 (ref), updateCharMenu (copy), u43 (ref), UserInputService (copy)
		if n1 <= 1 then
			return
		end

		if not Main.Character.Visible then
			updateAvailableMoves()

			if u53 then
				selectAttack(u53, Enum.UserInputState.Begin)
			end

			updateCharMenu()
		else
			Main.SelectSlot.Position = UDim2.new(0, -1000, 0, 0)
			u43 = nil
			bindKeys()
		end

		Main.Character.Visible = not Main.Character.Visible

		if Main.Shop.Visible or Main.Book.Visible then
			Main.Shop.Visible = false
			Main.Book.Visible = false
		end

		if UserInputService.TouchEnabled then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not (Main.Character.Visible or (Main.Shop.Visible or Main.Book.Visible)))
		end
	end)
	Main.Frame1.Shop.MouseButton1Up:connect(function() -- line: 1112
		-- upvalues: n1 (ref), Main (ref), UserInputService (copy)
		if n1 <= 1 then
			return
		end

		Main.Shop.Visible = not Main.Shop.Visible

		if Main.Book.Visible or Main.Character.Visible then
			Main.Book.Visible = false
			Main.Character.Visible = false
		end

		if UserInputService.TouchEnabled then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not (Main.Character.Visible or (Main.Shop.Visible or Main.Book.Visible)))
		end
	end)

	local u103 = false
	local u104 = false

	Main.Book.UnlockFrame.Unlock.MouseButton1Up:connect(function() -- line: 1126
		-- upvalues: u103 (ref), u104 (ref), Remotes (copy), updateAvailableMoves (copy), t6 (ref)
		if u103 and not u104 then
			u104 = true

			local v318 = Remotes.UnlockElement:InvokeServer(u103)

			if v318 then
				_G.playSound("PurchaseSuccess")
				updateBookInfo()
				updateBookMagicInfo(not v318, u103)

				local v319 = nil

				for _, v in next, u103.Attacks do
					if v.Id == 1 then
						v319 = v

						break
					end
				end

				if v319 then
					updateAvailableMoves()

					local v322 = nil
					local t14 = {}

					for k, v in next, t6 do
						if v.keybind then
							t14[v.keybind] = true
						end

						if v.move.Name == v319.Name then
							v322 = k
						end
					end

					for i = 1, 5 do
						if not t14[i] then
							t14[i] = true
							t6[v322].keybind = i

							break
						end
					end

					bindKeys()
				end
			else
				_G.playSound("PurchaseFailure")
			end

			u104 = false
		end
	end)

	local t15 = {
		UDim2.new(0.175, 0, 0, 0),
		UDim2.new(0.65, 0, 0, 0),
		UDim2.new(0.175, 0, 0.35, 0),
		UDim2.new(0.65, 0, 0.35, 0),
		UDim2.new(0.425, 0, 0.7, 0)
	}
	local t16 = {}
	local u107 = false

	function updateBookMagicInfo(p36, p37) -- line: 1183
		-- upvalues: u103 (ref), Main (ref), Magics (copy), LocalPlayer (copy), t16 (copy), TypeImages (copy), t15 (copy), u107 (ref), Remotes (copy), updateAvailableMoves (copy), t6 (ref)
		u103 = p37
		Main.Book.Title2.Text = p37.Name
		Main.Book.InfoFrame.Visible = false
		Main.Book.UnlockFrame.Visible = false

		if p36 then
			Main.Book.UnlockFrame.Visible = true

			if not p37.Fusion then
				for _, v in next, Main.Book.UnlockFrame.Elements:GetChildren() do
					v.Visible = false
				end

				Main.Book.UnlockFrame.Elements.Second.ImageLabel.Visible = false
				Main.Book.UnlockFrame.Elements.Second.TextLabel.Visible = false
				Main.Book.UnlockFrame.Elements.Second.Visible = true
				Main.Book.UnlockFrame.Elements.Second.Image = p37.Image
				Main.Book.UnlockFrame.Unlock.Image = "rbxassetid://567304072"
				Main.Book.UnlockFrame.Diamonds.TextLabel.Text = p37.Cost or "?"
				Main.Book.UnlockFrame.Diamonds.Visible = true

				return
			end

			Main.Book.UnlockFrame.Unlock.Image = "rbxassetid://567304132"
			Main.Book.UnlockFrame.Diamonds.Visible = false

			for _, v in next, Main.Book.UnlockFrame.Elements:GetChildren() do
				v.Visible = true
			end

			Main.Book.UnlockFrame.Elements.First.Image = Magics[p37.Fusion[1]].Image
			Main.Book.UnlockFrame.Elements.First.TextLabel.Text = _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[1]] and "(" .. _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[1]].Unlocked .. "/5)" or "LOCKED"
			Main.Book.UnlockFrame.Elements.Second.Image = Magics[p37.Fusion[2]].Image
			Main.Book.UnlockFrame.Elements.Second.TextLabel.Text = _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[2]] and "(" .. _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[2]].Unlocked .. "/5)" or "LOCKED"
			Main.Book.UnlockFrame.Elements.Second.TextLabel.Visible = true
			Main.Book.UnlockFrame.Elements.Third.Image = p37.Image

			if _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[1]] and _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[1]].Unlocked >= 5 then
				Main.Book.UnlockFrame.Elements.First.ImageLabel.Visible = true
			else
				Main.Book.UnlockFrame.Elements.First.ImageLabel.Visible = false
			end

			if _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[2]] and _G.PlayersData[LocalPlayer].Data.Magics[p37.Fusion[2]].Unlocked >= 5 then
				Main.Book.UnlockFrame.Elements.Second.ImageLabel.Visible = true
			else
				Main.Book.UnlockFrame.Elements.Second.ImageLabel.Visible = false
			end

			if p37.Cost and p37.Cost > 0 then
				Main.Book.UnlockFrame.Unlock.Image = "rbxassetid://567304072"
				Main.Book.UnlockFrame.Diamonds.TextLabel.Text = p37.Cost or "?"
				Main.Book.UnlockFrame.Diamonds.Visible = true

				return
			end
		else
			for _, v in next, Main.Book.InfoFrame.Moves:GetChildren() do
				if v:IsA("ImageButton") then
					v:Destroy()
				end
			end

			Main.Book.InfoFrame.Visible = true
			Main.Book.InfoFrame.Moves["b" .. 1].Visible = false
			Main.Book.InfoFrame.Moves["b" .. 2].Visible = false
			Main.Book.InfoFrame.Moves["b" .. 3].Visible = false
			Main.Book.InfoFrame.Moves["b" .. 4].Visible = false
			Main.Book.InfoFrame.Moves["b" .. 5].Visible = false

			for _, v in next, t16 do
				v:disconnect()
			end

			for k, v in next, p37.Attacks do
				local clone11 = Main.Skill:Clone()

				clone11.BackgroundColor3 = Magics[v.MagicType].ImageColor
				clone11.Image = TypeImages[v.Type]
				clone11.ImageColor3 = Color3.new(0, 0, 0)
				clone11.Visible = true
				clone11.Name = p37.Name .. "/" .. k
				clone11.Position = t15[v.Id]
				clone11.Size = UDim2.new(0.2, 0, 0.2, 0)

				local v340 = Main.Book.InfoFrame.Moves["b" .. v.Id]

				if _G.PlayersData[LocalPlayer].Data.Magics[p37.Name].Unlocked >= v.Id then
					v340.Visible = false
					v340.ImageTransparency = 1
					v340.TextButton.Visible = false
					v340.TextLabel.Visible = false
					v340.Locked.Visible = false

					local ImageLabel = Instance.new("ImageLabel")

					ImageLabel.BackgroundTransparency = 1
					ImageLabel.Image = "rbxassetid://566634511"
					ImageLabel.Position = UDim2.new(0, 0, 0, 0)
					ImageLabel.Size = UDim2.new(1, 0, 1, 0)
					ImageLabel.ZIndex = clone11.ZIndex + 1
					ImageLabel.Parent = clone11
				elseif _G.PlayersData[LocalPlayer].Data.Magics[p37.Name].Unlocked + 1 >= v.Id then
					v340.Visible = true
					v340.ImageTransparency = 0
					v340.TextButton.Visible = true
					v340.TextLabel.Visible = true
					v340.TextLabel.Text = v.Cost
					v340.Locked.Visible = false
					t16[#t16 + 1] = v340.TextButton.MouseButton1Up:connect(function() -- line: 1269
						-- upvalues: u107 (ref), Remotes (copy), p37 (copy), v (copy), updateAvailableMoves (copy), t6 (ref)
						if u107 then
							return
						end

						u107 = true

						if Remotes.UnlockSpell:InvokeServer(p37.Name, v.Name) then
							_G.playSound("PurchaseSuccess")
							updateBookInfo()
							updateBookMagicInfo(false, p37)
							updateAvailableMoves()

							local v361 = nil
							local t17 = {}

							for k2, v9 in next, t6 do
								if v9.keybind then
									t17[v9.keybind] = true
								end

								if v9.move.Name == v.Name then
									v361 = k2
								end
							end

							for i = 1, 5 do
								if not t17[i] then
									t17[i] = true
									t6[v361].keybind = i

									break
								end
							end

							bindKeys()
						else
							_G.playSound("PurchaseFailure")
						end

						u107 = false
					end)
				else
					v340.Visible = true
					v340.ImageTransparency = 1
					v340.TextButton.Visible = false
					v340.TextLabel.Visible = false
					v340.Locked.Visible = true
				end

				clone11.Parent = Main.Book.InfoFrame.Moves
			end

			Main.Book.InfoFrame.Moves.Visible = true
		end
	end

	local t18 = {}

	function updateBookInfo() -- line: 1314
		-- upvalues: t18 (copy), Main (ref), Magics (copy), LocalPlayer (copy), u44 (ref)
		for _, v in next, t18 do
			v:disconnect()
		end

		Main.Book.Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

		for _, v in next, Main.Book.Scroll:GetChildren() do
			if v.Name ~= "CloneFrame" and not v:IsA("UIComponent") then
				v:Destroy()
			end
		end

		for k, v in next, Magics do
			local v348 = false or k == "Sans" and not _G.PlayersData[LocalPlayer].Data.Magics[k]

			if v.Index > 0 and not v348 then
				local v349 = u44 == false and not _G.PlayersData[LocalPlayer].Data.Magics[k] or u44 and v.Index > 3
				local clone12 = Main.Book.Scroll.CloneFrame:Clone()

				clone12.Name = k .. "Frame"
				clone12.Visible = true
				clone12.LayoutOrder = v.Index
				clone12.Icon.Image = v.Image
				clone12.Button.Text = k
				clone12.Icon.ImageColor3 = v349 and Color3.new() or Color3.new(1, 1, 1)
				clone12.Button.TextStrokeColor3 = v349 and Color3.new() or v.ImageColor:lerp(Color3.new(), 0.2)

				if v349 then
					local ImageLabel = Instance.new("ImageLabel")

					ImageLabel.BackgroundTransparency = 1
					ImageLabel.Image = "rbxassetid://566840786"
					ImageLabel.Position = UDim2.new(0, -9, 0, -9)
					ImageLabel.Size = UDim2.new(1, 14, 1, 14)
					ImageLabel.ZIndex = clone12.ZIndex + 1
					ImageLabel.Parent = clone12.Icon
				end

				t18[#t18 + 1] = clone12.Button.MouseButton1Up:connect(function() -- line: 1352
					-- upvalues: LocalPlayer (copy), k (copy), v (copy)
					updateBookMagicInfo(not _G.PlayersData[LocalPlayer].Data.Magics[k], v)
				end)
				t18[#t18 + 1] = clone12.Icon.MouseButton1Up:connect(function() -- line: 1355
					-- upvalues: LocalPlayer (copy), k (copy), v (copy)
					updateBookMagicInfo(not _G.PlayersData[LocalPlayer].Data.Magics[k], v)
				end)
				clone12.Parent = Main.Book.Scroll
			end
		end

		local n6 = 0

		for _, child in pairs(Main.Book.Scroll:GetChildren()) do
			if child:IsA("Frame") and child.Visible then
				n6 = n6 + 1
			end
		end

		Main.Book.Scroll.CanvasSize = UDim2.new(0, 0, n6 * 0.15, 0)
		Main.Book.Scroll.UIGridLayout.CellSize = UDim2.new(1, 0, 1 / n6, -1)
	end

	Main.Frame1.Book.MouseButton1Up:connect(function() -- line: 1372
		-- upvalues: n1 (ref), Main (ref), UserInputService (copy)
		if n1 <= 1 then
			return
		end

		if not Main.Book.Visible then
			updateBookInfo()
		end

		Main.Book.Visible = not Main.Book.Visible

		if Main.Shop.Visible or Main.Character.Visible then
			Main.Shop.Visible = false
			Main.Character.Visible = false
		end

		if UserInputService.TouchEnabled then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not (Main.Character.Visible or (Main.Shop.Visible or Main.Book.Visible)))
		end
	end)
	Main:WaitForChild("increase"):WaitForChild("Accept").MouseButton1Up:connect(function() -- line: 1387
		-- upvalues: Main (ref), Remotes (copy)
		Main.increase.Visible = false
		Remotes.IncreaseCap:FireServer()
	end)
	Main:WaitForChild("increase"):WaitForChild("Cancel").MouseButton1Up:connect(function() -- line: 1391
		-- upvalues: Main (ref)
		Main.increase.Visible = false
	end)

	local n7 = 0
	local n8 = 0
	local n9 = 0

	function _G.ShakeCamera(p38, _) -- line: 1482
		-- upvalues: n7 (ref), n8 (ref), n9 (ref)
		n7 = tick()
		n8 = math.clamp(n8 + 1, 0, 8)
		n9 = math.clamp(n9 + p38, 0, 10)
	end

	local u112 = nil
	local u113 = nil
	local v114 = _G.PlayersData[LocalPlayer]

	if not v114 then
		repeat
			v114 = _G.PlayersData[LocalPlayer]
			wait(0)
		until v114
	end

	local v115 = false
	local timestamp = tick()
	local timestamp2 = tick()

	while wait(0) do
		local v118 = tick() - timestamp2
		local v119 = _G.PlayersData[LocalPlayer]

		if tick() - timestamp > 3 then
			local v120 = _G.ClientsData[LocalPlayer]

			if type(v120.Cooldowns) == "table" then
				v120.Cooldowns = EncodeCooldowns(v120.Cooldowns)
				Remotes.ClientData:FireServer(v120)
			end

			v120.Cooldowns = DecodeCooldowns(v120.Cooldowns)
		end

		Health.TextLabel.Text = "HEALTH (" .. math.ceil(Humanoid.Health * 10) .. "/" .. math.ceil(Humanoid.MaxHealth * 10) .. ")"
		Health.Empty.Size = UDim2.new(1 - Humanoid.Health / Humanoid.MaxHealth, 0, 1, 0)
		Health.Empty.Position = UDim2.new(Humanoid.Health / Humanoid.MaxHealth, 0, 0, 0)
		Energy.TextLabel.Text = "MANA (" .. math.ceil(v119.Mana * 10) .. "/" .. math.ceil(v119.MaxMana * 10) .. ")"
		Energy.Empty:TweenSizeAndPosition(UDim2.new(1 - v119.Mana / v119.MaxMana, 0, 1, 0), UDim2.new(v119.Mana / v119.MaxMana, 0, 0, 0), "In", "Linear", 0.5, true)
		Stamina.TextLabel.Text = "STAMINA (" .. math.ceil(v119.Stamina * 10) .. "/" .. math.ceil(v119.MaxStamina * 10) .. ")"
		Stamina.Empty:TweenSizeAndPosition(UDim2.new(1 - v119.Stamina / v119.MaxStamina, 0, 1, 0), UDim2.new(v119.Stamina / v119.MaxStamina, 0, 0, 0), "In", "Linear", 0.5, true)
		clone.BackgroundTransparency = clone.BackgroundTransparency + v118
		RequiredBar.BackgroundTransparency = RequiredBar.BackgroundTransparency + v118
		TextLabel.Text = "Lvl. " .. v119.Data.Level

		local Empty = Experience.Empty
		local new = UDim2.new
		local Exp = v119.Data.Exp
		local Level = v119.Data.Level

		Empty.Size = new(1 - Exp / (41 + math.ceil(Level ^ 1.95 + Level * 8)), 0, 1, 0)

		local Empty2 = Experience.Empty
		local new2 = UDim2.new
		local Exp2 = v119.Data.Exp
		local Level2 = v119.Data.Level

		Empty2.Position = new2(Exp2 / (41 + math.ceil(Level2 ^ 1.95 + Level2 * 8)), 0, 0, 0)

		local TextLabel2 = Experience.TextLabel
		local Exp3 = v119.Data.Exp
		local Level3 = v119.Data.Level

		TextLabel2.Text = "EXP: " .. Exp3 .. "/" .. 41 + math.ceil(Level3 ^ 1.95 + Level3 * 8)
		Shards.TextLabel.Text = v119.Data.Shards
		Diamonds.TextLabel.Text = v119.Data.Diamonds

		if v119.Stamina <= 0 then
			v119.Running = false
			_G.running = false
		elseif v119.Blocking and _G.Blocking and v115 == false then
			v115 = true
			_G.PlayAnim("Block", 0.5, 10, 0.01)
		elseif not v119.Blocking and v115 == true then
			v115 = false
			_G.StopAnim("Block", 0.5)
			_G.Blocking = false
		end

		Humanoid.WalkSpeed = (not _G.running and 16 or 32) * v119.SpeedMultiplier * (0.6 + Humanoid.Health / Humanoid.MaxHealth * 0.4)

		local HumanoidRootPartVelocity = HumanoidRootPart.Velocity

		if n8 <= 0 and HumanoidRootPartVelocity.y < -120 then
			local ray = Ray.new(HumanoidRootPart.CFrame.p, (Vector3.new(0, -math.abs(HumanoidRootPartVelocity.y / 12), 0)))
			local part, _ = workspace:FindPartOnRayWithIgnoreList(ray, { u12 })

			if part then
				if part.Parent.Name == ".Water" then
					HumanoidRootPart.Velocity = HumanoidRootPart.Velocity - Vector3.new(0, HumanoidRootPart.Velocity.y / 2, 0)
					_G.playSound("WaterSplash", HumanoidRootPart)
				else
					_G.ShakeCamera(-HumanoidRootPartVelocity.y * 0.016666666666666666, -HumanoidRootPartVelocity.y * 0.016666666666666666 * 0.5)
					_G.playSound("GroundCrash", HumanoidRootPart)
				end
			end
		end

		if n8 > 0 and n7 > 0 then
			Humanoid.CameraOffset = Vector3.new(n9 * math.random() - n9 / 2, n9 * math.random() - n9 / 2, n9 * math.random() - n9 / 2) * n8
			n8 = n8 - v118
		elseif n9 < 0 or n8 < 0 then
			n9 = 0
			n8 = 0
			Humanoid.CameraOffset = Vector3.new()
		end

		if Main.Character.Visible then
			v95()
		end

		if v114.Data.Shards - v119.Data.Shards ~= 0 then
			local v136 = v119.Data.Shards - v114.Data.Shards
			local v137 = v136 > 0 and "+" .. v136 or v136

			if u112 then
				local v138 = u112

				v138:TweenPosition(UDim2.new(0.5, -140, 0, -75), "In", "Quad", 0.5, true, function() -- line: 1578
					-- upvalues: v138 (copy)
					v138:Destroy()
				end)
				u112 = nil
			end

			local clone13 = Main.NotifyShard:Clone()

			clone13.Position = UDim2.new(0.5, -180, 0, -75)
			clone13.TextLabel.Text = v137
			u112 = clone13
			clone13.Parent = Main
			clone13:TweenPosition(UDim2.new(0.5, -180, 0.075, 10), "Out", "Quad", 0.5, true, function() -- line: 1588
				-- upvalues: u112 (ref), clone13 (copy)
				wait(2)

				if u112 == clone13 then
					u112 = nil
					clone13:TweenPosition(UDim2.new(0.5, -180, 0, -75), "In", "Quad", 0.5, true, function() -- line: 1592
						-- upvalues: clone13 (copy)
						clone13:Destroy()
					end)
				end
			end)
		end

		if v114.Data.Diamonds - v119.Data.Diamonds ~= 0 then
			local v140 = v119.Data.Diamonds - v114.Data.Diamonds
			local v141 = v140 > 0 and "+" .. v140 or v140

			if u113 then
				local v142 = u113

				v142:TweenPosition(UDim2.new(0.5, 20, 0, -75), "In", "Quad", 0.5, true, function() -- line: 1603
					-- upvalues: v142 (copy)
					v142:Destroy()
				end)
				u113 = nil
			end

			local clone14 = Main.NotifyDiamond:Clone()

			clone14.Position = UDim2.new(0.5, 60, 0, -75)
			clone14.TextLabel.Text = v141
			u113 = clone14
			clone14.Parent = Main
			clone14:TweenPosition(UDim2.new(0.5, 60, 0.075, 10), "Out", "Quad", 0.5, true, function() -- line: 1613
				-- upvalues: u113 (ref), clone14 (copy)
				wait(2)

				if u113 == clone14 then
					u113 = nil
					clone14:TweenPosition(UDim2.new(0.5, 60, 0, -75), "In", "Quad", 0.5, true, function() -- line: 1617
						-- upvalues: clone14 (copy)
						clone14:Destroy()
					end)
				end
			end)
		end

		local v144 = false

		for _, v in next, t4 do
			if (v.pos - HumanoidRootPart.Position).magnitude < v.radius then
				v144 = true

				break
			end
		end

		_G.safezoned = v144
		Main.Safezone.Visible = _G.safezoned

		for _, v in next, t13 do
			local Character = v.Character

			if Character then
				local Humanoid2 = Character:FindFirstChild("Humanoid")

				Character:FindFirstChild("HumanoidRootPart")
				Character:FindFirstChild("Head")

				if Humanoid2 then
					for _, v10 in next, MembersFrame.Frame:GetChildren() do
						if v.Name == v10.Name then
							v10.Frame.Frame.Size = UDim2.new(Humanoid2.Health / Humanoid2.MaxHealth, 0, 1, 0)
						end
					end
				end
			end
		end

		v114 = v119
		timestamp2 = tick()
	end

return ClientApi
