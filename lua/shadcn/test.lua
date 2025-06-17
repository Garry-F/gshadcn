local frame = nil

local function open()
    if IsValid(frame) then frame:Close() return end

    frame = vgui.Create("SHADCN.Frame")
    frame:SetSize(980, 640)
    frame:Center()
    frame.OnClose = function(s)
        if !IsValid(s.alertDialog) then return end
        s.alertDialog:Close()
    end
     
    local button = frame:Add("SHADCN.Button")
    button:SetPos(32, 32)
    button:SetText("Button")
    button.OnClick = function(s)
        --frame.alertDialog = vgui.Create("SHADCN.Dialog")
        --frame.alertDialog:SetSize(512, 256)
        --frame.alertDialog:Open()
        frame.alertDialog = vgui.Create("SHADCN.AlertDialog")
        frame.alertDialog:SetTitle("Are you absolutely sure?")
        frame.alertDialog:SetSubTitle("This action cannot be undone. This will permanently delete your account\nand remove your data from our servers.")
        frame.alertDialog:AddCancelButton("Cancel")
        frame.alertDialog:AddActionButton("Continue", function()
            print("Continue")
        end)
        frame.alertDialog:Open()
    end

    local slider = frame:Add("SHADCN.Slider")
    slider:SetPos(128, 32)
    slider:SetWide(96)
end

concommand.Add("_shadcn_test", open)