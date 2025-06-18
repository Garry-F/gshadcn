local PANEL = {}

function PANEL:Init()
    self:SetTall(22)
    self:SetRound(11)
    self:SetBGColor("white")
    self:SetDrawOutline(false)

    self.text = ""
    self.textColorTo = "black"
    self.textColor = SHADCN.GetColor(self.textColorTo)
end

function PANEL:SetText(text)
    self.text = text

    surface.SetFont("SHADCN.B14")
    local w, _ = surface.GetTextSize(text)

    self:SetWide(w + 16)
end

function PANEL:OverPaint(w, h)
    local animationsEnabled = SHADCN.Config.Animations:GetBool()
    local ft 

    if animationsEnabled then
        ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()
        self.textColor = SHADCN.LerpColor(ft, self.textColor, SHADCN.GetColor(self.textColorTo))
    end

    draw.SimpleText(self.text, "SHADCN.B14", w * .5, h * .5, self.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("SHADCN.Badge", PANEL, "SHADCN.Base.RoundedBox")