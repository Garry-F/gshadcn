local PANEL = {}
local oneVector = Vector(1, 1, 1)
local zeroVector = Vector(0, 0, 0)

local function _paint(self, w, h)
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

function PANEL:Init()
    self:SetRound("md")

    self.animationType = "none"
    self.drawedSize = .75
    self.opened = false
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

function PANEL:SetAnimation(anim)
    self.animationType = anim
    if anim == "none" then return end
    self.opened = false
    self.drawedSize = .75
    self:SetAlpha(0)
end

function PANEL:Open()
    self.opened = true
    self:AlphaTo(255, .25 * SHADCN.Config.AnimationsSpeed:GetFloat(), 0)
end

function PANEL:Close()
    if self.animationType == "none" then self:OnClose() self:Remove() return end
    self.opened = false
    self:AlphaTo(0, .25 * SHADCN.Config.AnimationsSpeed:GetFloat(), 0, function()
        self:OnClose()
        self:Remove()
    end)
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
    self.round = SHADCN.Round(round)-0.5
    self:CachePoly(self:GetWide(), self:GetTall())
end

function PANEL:CachePoly(w, h)
    self.poly = SHADCN.RoundedBox(self.round, 0, 0, w-1, h-1) -- subtract one so that the stroke is done correctly
end

function PANEL:OnClose()
end

function PANEL:OnPerformLayout()
end

function PANEL:OverPaint(w, h)
end

function PANEL:PerformLayout(w, h)
    if self.cachedW == w and self.cachedH == h then return end

    self.cachedW, self.cachedH = w, h
    self:CachePoly(w, h)
    self:OnPerformLayout(w, h)
end

function PANEL:Paint(w, h)
    local animationsEnabled = SHADCN.Config.Animations:GetBool()
    local ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()

    if self.animationType == "verticalOpen" and animationsEnabled then
        self.drawedSize = Lerp(ft, self.drawedSize, self.opened and 1 or .75)

        local matrix = Matrix()
        local x, _ = self:LocalToScreen(w * .5, 0)
        local pos = Vector(x, 0, 0)
        matrix:Translate(pos)
        matrix:Scale(oneVector * self.drawedSize)
        matrix:Translate(-pos)

        render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	    render.PushFilterMin(TEXFILTER.ANISOTROPIC)

        cam.PushModelMatrix(matrix, true)
            _paint(self, w, h)
    elseif self.animationType == "centerOpen" and animationsEnabled then
        self.drawedSize = Lerp(ft, self.drawedSize, self.opened and 1 or .75)

        local matrix = Matrix()
        local x, y = self:LocalToScreen(w * .5, h * .5)
        local pos = Vector(x, y, 0)
        matrix:Translate(pos)
        matrix:Scale(oneVector * self.drawedSize)
        matrix:Translate(-pos)

        render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	    render.PushFilterMin(TEXFILTER.ANISOTROPIC)

        cam.PushModelMatrix(matrix, true)
            _paint(self, w, h)
            
            --local childs = self:GetChildren()
            --for i = 1, #childs do
            --    childs[i]:PaintAt(self:LocalToScreen(childs[i]:GetPos()))
            --end
    elseif self.animationType == "leftTopCorner" and animationsEnabled then
        self.drawedSize = Lerp(ft, self.drawedSize, self.opened and 1 or .75)

        local matrix = Matrix()
        matrix:Translate(zeroVector)
        matrix:Scale(oneVector * self.drawedSize)

        render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	    render.PushFilterMin(TEXFILTER.ANISOTROPIC)

        cam.PushModelMatrix(matrix, true)
            _paint(self, w, h)    
    elseif self.animationType == "leftBottomCorner" and animationsEnabled then
        self.drawedSize = Lerp(ft, self.drawedSize, self.opened and 1 or .75)

        local matrix = Matrix()
        local _, y = self:LocalToScreen(0, h)
        local pos = Vector(0, y, 0)
        matrix:Translate(pos)
        matrix:Scale(oneVector * self.drawedSize)
        matrix:Translate(-pos)

        render.PushFilterMag(TEXFILTER.ANISOTROPIC)
	    render.PushFilterMin(TEXFILTER.ANISOTROPIC)

        cam.PushModelMatrix(matrix, true)
            _paint(self, w, h)
    else
        _paint(self, w, h)
    end
end

function PANEL:PaintOver(w, h)
    local animationsEnabled = SHADCN.Config.Animations:GetBool()
    if self.animationType == "none" or !animationsEnabled then return end
    
    cam.PopModelMatrix()

    render.PopFilterMin()
    render.PopFilterMag()
end

vgui.Register("SHADCN.Base.RoundedBox", PANEL, "EditablePanel")