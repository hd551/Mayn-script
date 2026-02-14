--[[ 
   DIVINE DUALITY - LUCK PREDICTOR
   وظيفته: كشف المهارة التي حصلت عليها قبل انتهاء الأنيميشن.
]]

local NotificationService = game:GetService("StarterGui")

-- دالة لإرسال إشعار على شاشتك بالنتيجة
local function Notify(title, text)
    NotificationService:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 5;
    })
end

print("--- PREDICTOR ACTIVE: WATCHING FOR ROLLS ---")

-- اعتراض البيانات القادمة من السيرفر
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- نحن نبحث عن اللحظة التي يخبرك فيها السيرفر بما فزت به
    -- ملاحظة: OnClientEvent هو ما يستقبله جهازك من السيرفر
    if method == "FireClient" or method == "OnClientEvent" then
        -- السكربت سيطبع أي بيانات تصل لجهازك في الـ Output (F9)
        warn("ROLL DATA DETECTED!")
        for i, v in pairs(args) do
            print("Argument ["..i.."]: ", v)
        end
        
        -- محاولة إظهار إشعار سريع بالنتيجة (إذا كانت النتيجة نصاً)
        if typeof(args[1]) == "string" then
            Notify("النتيجة القادمة:", args[1])
        end
    end

    return oldNamecall(self, ...)
end)
