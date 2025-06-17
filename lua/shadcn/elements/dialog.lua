local PANEL = {}

function PANEL:Init()
    self.dialog = vgui.Create("SHADCN.Base.RoundedBox", self)
    self.dialog:SetRound("lg")
    self.dialog:SetAnimation("centerOpen")
    self.dialog.closeButton = self.dialog:Add("Panel")
    self.dialog.closeButton:SetSize(16, 16)
    self.dialog.closeButton:SetCursor("hand")
    self.dialog.closeButton.colorTo = "white"
    self.dialog.closeButton.color = SHADCN.GetColor(self.dialog.colorTo)
    self.dialog.closeButton.Paint = function(s, w, h)
        local animationsEnabled = SHADCN.Config.Animations:GetBool()
        local ft

        if animationsEnabled then
            ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()
            s.color = Lerp(ft, s.color, SHADCN.GetColor(s.colorTo))
        end

        surface.SetDrawColor(animationsEnabled and s.color or SHADCN.GetColor(s.colorTo))
        surface.DrawLine(0, 0, w, h)
        surface.DrawLine(w, 0, 0, h)
    end
    self.dialog.closeButton.OnMouseReleased = function(s)
        self:Close()
    end
    self.dialog.PerformLayout = function(s, w, h)
        s.closeButton:SetPos(w - 40, h - 40)
    end
    self.dialog.OnClose = function()
        self:Close(true)
    end
    self.dialog.OverPaint = function(s, w, h)
        self.OverPaint(s, w, h)
    end
end

function PANEL:Open()
    self.dialog:Open()
end

function PANEL:OnClose()
    self.dialog:Close()
end

function PANEL:Add(element)
    return self.dialog:Add(element)
end

function PANEL:SetSize(w, h)
    self.dialog:SetSize(w, h)
end

function PANEL:SetWide(w)
    self.dialog:SetWide(w, h)
end

function PANEL:SetTall(h)
    self.dialog:SetTall(h)
end

function PANEL:GetWide()
    return self.dialog:GetWide()
end

function PANEL:GetTall()
    return self.dialog:GetTall()
end

function PANEL:SetBGColor(color)
    self.alertDialog:SetBGColor(color)
end

function PANEL:SetHoverColor(color)
    self.alertDialog:SetHoverColor(color)
end

function PANEL:SetDrawHover(bool)
    self.alertDialog:SetDrawHover(bool)
end

function PANEL:SetDrawOutline(bool)
    self.alertDialog:SetDrawOutline(bool)
end

function PANEL:SetRound(round)
    self.alertDialog:SetRound(round)
end

function PANEL:CachePoly(w, h)
    self.alertDialog:CachePoly(w, h)
end

vgui.Register("SHADCN.Dialog", PANEL, "SHADCN.Base.FullScreen")