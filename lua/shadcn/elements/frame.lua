local PANEL = {}

function PANEL:Init()
    self:MakePopup()
    self:SetBGColor("black")
    self:SetRound("lg")
end

vgui.Register("SHADCN.Frame", PANEL, "SHADCN.Base.RoundedBox")