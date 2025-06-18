local PANEL = {}

function PANEL:Init()
    self:SetTall(36)

    self:SetRound("lg")
    self:SetBGColor("white")
    self:SetHoverColor("whiteHover")
    self:SetDrawOutline(false)
    self:SetDrawHover(true)

    self.text = ""
    self.textColorTo = "primary"
    self.textColor = SHADCN.GetColor(self.textColorTo)
end

function PANEL:OnMouseReleased(keyCode)
    if keyCode == MOUSE_LEFT then
        self:OnClick()
    elseif keyCode == MOUSE_RIGHT then
        self:OnRightClick()
    end
end

function PANEL:SetTextColor(color)
    self.textColor = SHADCN.GetColor(color)
    self.textColorTo = color
end

function PANEL:SetText(text)
    self.text = text

    surface.SetFont("SHADCN.SB16")
    local w, _ = surface.GetTextSize(self.text)

    self:SetWide(w + 32)
end

function PANEL:OnClick()
end

function PANEL:OnRightClick()
end

function PANEL:OverPaint(w, h)
    local animations = SHADCN.Config.Animations:GetBool()

    if animations then
        self.textColor = SHADCN.LerpColor(FrameTime() * 12, self.textColor, SHADCN.GetColor(self.textColorTo))
    end

    draw.SimpleText(self.text, "SHADCN.SB16", w * .5, h * .5, animations and self.textColor or SHADCN.GetColor(self.textColorTo), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("SHADCN.Button", PANEL, "SHADCN.Base.RoundedBox")