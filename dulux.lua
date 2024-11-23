local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local ply = game:GetService("Players").LocalPlayer 
local Character = ply.Character or ply.CharacterAdded:Wait()
local rootpart : BasePart = Character:FindFirstChild("HumanoidRootPart")


local Window = Fluent:CreateWindow({
	Title = "Bentendev Hub " .. Fluent.Version,
	SubTitle = "by Teerapon Sukkul",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = false, 
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl 
})

local Tabs = {
	Main = Window:AddTab({ Title = "ตกปลา", Icon = "" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local gg1 = false
local Options = Fluent.Options


local tween = game:GetService("TweenService")
local GuiService = game:GetService('GuiService')
local TeleportList = {}

for i,v in pairs(game:GetService("Workspace").world.spawns.TpSpots:GetChildren()) do
    if v:IsA("BasePart") then
        table.insert(TeleportList, v.Name)
    end
end

local function color(color1)
	local Highlight = Instance.new("Highlight",Character)
	Highlight.OutlineTransparency = 1
	Highlight.FillTransparency = 0
	Highlight.FillColor = color1

	tween:Create(Highlight,TweenInfo.new(1),{
		FillTransparency = 1
	}):Play()

	task.delay(1,function()
		Highlight:Destroy()
	end)
end



do
	Fluent:Notify({
		Title = "Notification",
		Content = "This is a notification",
		SubContent = "SubContent", 
		Duration = 5 
	})



	local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "ออโต้ตกปลา", Default = false })

	Toggle:OnChanged(function()
		if Options.MyToggle.Value then
			gg1 = true
			for i = 0,math.huge do
				if not gg1 then
					return
				end
				rootpart.Anchored = false


				for i,v in next, ply.Backpack:GetChildren() do
					if string.find(v.Name, "Rod") then
						Character.Humanoid:EquipTool(v)
					end
				end

				color(Color3.new(1, 1, 1))


				local VirtualInputManager = game:GetService('VirtualInputManager')

				for i = 0,math.huge do
					if not gg1 then
						return
					end

					if not ply.PlayerGui:FindFirstChild("shakeui") then


						repeat
							task.wait()
						until Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("lure").Value == 0


						if Character:FindFirstChildOfClass("Tool") then
							Character:FindFirstChildOfClass("Tool").events.cast:FireServer(100, 1)



						else
							for i,v in next, ply.Backpack:GetChildren() do
								if string.find(v.Name, "Rod") then
									Character.Humanoid:EquipTool(v)
								end
							end
						end
					end


					if Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("casted").Value then
						break
					end

					task.wait()
				end


				repeat
					task.wait()
				until Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("casted").Value == true


				color(Color3.new(1, 0.509804, 0.0196078))

				local gui = ply.PlayerGui:WaitForChild("shakeui",math.huge)


				for i = 0,math.huge do
					if not gg1 then
						return
					end
					if Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("bite").Value then
						break
					end


					local button : ImageButton = gui:FindFirstChild("safezone"):FindFirstChild("button")

					rootpart.Anchored = true

					if  gui then
						GuiService.SelectedObject = button
						GuiService.SelectedObject = button
						VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
						VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
						task.wait(.001)
						GuiService.SelectedObject = nil
					else
						break
					end

				end

				repeat
					task.wait()
				until Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("bite").Value == true

				color(Color3.new(1, 0, 0))

				for i = 0,math.huge do
					if not gg1 then
						return
					end

					game.ReplicatedStorage:WaitForChild("events"):WaitForChild("reelfinished"):FireServer(100, true)


					if Character:FindFirstChildOfClass("Tool"):FindFirstChild("values"):FindFirstChild("lure").Value == 0 then
						break
					end

					task.wait()
				end


				task.wait()
			end

			rootpart.Anchored = false
		end
		if not Options.MyToggle.Value  then
			rootpart.Anchored = false
			gg1 = false
		end
		
		
		
	end)

Tabs.Main:AddToggle("Sell", { 
    Title = "ขายทั้งหมด",
    Default = false,
    Callback = function(v)
        getgenv().sellall = v

        local npcName = "Marc Merchant"
        local merchant = workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild(npcName)
        local lp = game.Players.LocalPlayer
        local hrp = lp.Character:WaitForChild("HumanoidRootPart")

        local function moveMerchantToPlayer()
            if merchant and merchant:FindFirstChild("HumanoidRootPart") then
                merchant.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
            end
        end

        local function sellEverything()
            local sellall = merchant:FindFirstChild("merchant") and merchant.merchant:FindFirstChild("sellall")
            if sellall then
                sellall:InvokeServer()
            end
        end

        local function interactWithMerchant()
            moveMerchantToPlayer()
            task.wait(0.5)
            if merchant:FindFirstChild("dialogprompt") and merchant.dialogprompt.Enabled then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(0.5)
                sellEverything()
            end
        end

        task.spawn(function()
            while getgenv().sellall do
                interactWithMerchant()
                task.wait(5)
            end
        end)
    end
})




   Tabs.Main:AddDropdown("Teleport", {
    Title = "เลือกวาป",
    Values = TeleportList,  
    Multi = false,
    Default = nil,
    Callback = function(Value)
        local teleportSpot = Value  
        
        if teleportSpot then
            for i, v in pairs(game:GetService("Workspace").world.spawns.TpSpots:GetChildren()) do
                if v.Name == teleportSpot and v:IsA("BasePart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 5, 0)
                    return  
                end
            end
        end
    end
})

Options.MyToggle:SetValue(false)



end


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
	Title = "Fluent",
	Content = "The script has been loaded.",
	Duration = 8
})

SaveManager:LoadAutoloadConfig()
