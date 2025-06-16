local frame = nil

local function open()
    if IsValid(frame) then frame:Remove() return end

    frame = vgui.Create("SHADCN.Frame")
    frame:SetSize(980, 640)
    frame:Center()
    
    local button = frame:Add("SHADCN.Button")
    button:SetPos(32, 32)
    button:SetText("Button")
end

concommand.Add("_shadcn_test", open)