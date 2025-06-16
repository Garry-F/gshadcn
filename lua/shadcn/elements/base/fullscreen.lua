local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW(), ScrH())
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 128)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("SHADCN.Base.FullScreen", PANEL)