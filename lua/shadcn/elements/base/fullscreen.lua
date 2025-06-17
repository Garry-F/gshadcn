local PANEL = {}

function PANEL:Init()
    self:MakePopup()
    self:SetSize(ScrW(), ScrH())
    self.alphaBG = 1
end

function PANEL:Close(removePanel)
    if removePanel then self:Remove() return end
    self.alphaBG = 0
    self:OnClose()
end

function PANEL:OnClose()
end

function PANEL:OverPaint()
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 128 * self.alphaBG)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("SHADCN.Base.FullScreen", PANEL, "EditablePanel")