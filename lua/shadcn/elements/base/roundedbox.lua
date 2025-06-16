local PANEL = {}

function PANEL:Init()
    self:SetRound("md")

    self.cachedW, self.cachedH = 0, 0
    self.drawOutline = true
    self.drawHover = false
    self.poly = nil

    self.bgColorTo = "primary"
    self.bgColor = SHADCN.GetColor(self.bgColorTo)

    self.outlineColorTo = "outline"
    self.outlineColor = SHADCN.GetColor(self.outlineColorTo)

    self.hoverColor = "hover"
end

function PANEL:SetBGColor(color)
    self.bgColor = SHADCN.GetColor(color)
    self.bgColorTo = color
end

function PANEL:SetHoverColor(color)
    self.hoverColor = color
end

function PANEL:SetDrawHover(bool)
    self.drawHover = bool

    if bool then
        self:SetCursor("hand")
    else
        self:SetCursor("arrow")
    end
end

function PANEL:SetDrawOutline(bool)
    self.drawOutline = bool
end

function PANEL:SetRound(round)
    self.round = SHADCN.Round(round)
end

function PANEL:CachePoly(w, h)
    self.poly = SHADCN.RoundedBox(self.round, 0, 0, w-1, h-1) -- subtract one so that the stroke is done correctly
end

function PANEL:OverPaint(w, h)
end

function PANEL:PerformLayout(w, h)
    if self.cachedW == w and self.cachedH == h then return end

    self.cachedW, self.cachedH = w, h
    self:CachePoly(w, h)
end

function PANEL:Paint(w, h)
    local animations = SHADCN.Config.Animations:GetBool()
    local ft

    if animations then
        ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()
        self.bgColor = SHADCN.LerpColor(ft, self.bgColor, (self:IsHovered() and self.drawHover) and SHADCN.GetColor(self.hoverColor) or SHADCN.GetColor(self.bgColorTo))
        self.outlineColor = SHADCN.LerpColor(ft, self.outlineColor, SHADCN.GetColor(self.outlineColorTo))
    end

    local bgColor = animations and self.bgColor or ((self:IsHovered() and self.drawHover) and SHADCN.GetColor(self.hoverColor) or SHADCN.GetColor(self.bgColorTo))
    local outlineColor = animations and self.outlineColor or SHADCN.GetColor(self.outlineColorTo)
    if SHADCN.Config.HighQualityRounds:GetBool() then
        draw.NoTexture()
        surface.SetDrawColor(bgColor)
        surface.DrawPoly(self.poly)
    else
        draw.RoundedBox(self.round, 0, 0, w, h, bgColor)
    end

    if self.drawOutline then
        SHADCN.DrawOutline(self.poly, outlineColor)
    end

    self:OverPaint(w, h)
end

vgui.Register("SHADCN.Base.RoundedBox", PANEL)