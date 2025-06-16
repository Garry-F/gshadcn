local PANEL = {}

function PANEL:Init()
    self:MakePopup()
    self:SetBGColor("frame")
    self:SetRound("lg")
end

vgui.Register("SHADCN.Frame", PANEL, "SHADCN.Base.RoundedBox")