local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Anime Reborn" .. Fluent.Version,
    SubTitle = "by dulux sharkped",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
}

--local Options = Fluent.Options

do

    Fluent:Notify({
        Title = "Notification",
        Content = "This is a notification",
        SubContent = "SubContent", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
end


local codes = {
    "2MVisits",
    "200kMembers",
    "50KLikes",
    "1MVisits",
    "Release",
    "MozKing",
    "SubtoRlxsage",
    "SubtoZillas",
    "SorryforShutdown"
}

Tabs.Main:AddButton({
    Title = "Redeem ALL Code",
    Description = nil,
    Callback = function()
        if getgenv().Redeem then
            for _, code in ipairs(codes) do
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UiCommunication"):FireServer("Codes/RedeemCode", code)
                wait()
            end
        end
    end
})

Tabs.Main:AddDropdown("va_1", {
    Title = "Select Summon",
    Values = {"Open x1 [50 GEM]", "Open x10[500 GEM]"},
    Multi = false,
    Default = nil,
    Callback = function(Value)
        getgenv().Summon = nil

        if Value == "Open x1 [50 GEM]" then
            local args = {
                [1] = "Summon1"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Summoning"):WaitForChild("SummonEvent"):FireServer(unpack(args))
        
        elseif Value == "Open x10[500 GEM]" then
            local args = {
                [1] = "Summon10"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Summoning"):WaitForChild("SummonEvent"):FireServer(unpack(args))
        end
    end
})


Fluent:Notify({
    Title = "You dick so small.",
    Content = "The script has been loaded.",
    Duration = 5
})

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("nigga56")
Window:SelectTab(1)
