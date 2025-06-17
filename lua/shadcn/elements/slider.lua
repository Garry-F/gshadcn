local PANEL = {}

function PANEL:Init()
    self:SetSize(0, 16)
    self:SetCursor("hand")

    self.bgColorTo = "secondary"
    self.bgColor = SHADCN.GetColor(self.bgColorTo)
    self.progressColorTo = "white"
    self.progressColor = SHADCN.GetColor(self.progressColorTo)
    self.progress = 0
    self.cachedW, self.cachedH = 0, 16
    self.poly = SHADCN.RoundedBox(8, 0, 5, 0, 6)

    self.knob = self:Add("Panel")
    self.knob:SetSize(16, 16)
    self.knob:SetCursor("hand")
    self.knob.poly = SHADCN.Circle(8, 8, 7.5, 16)
    self.knob.outlineColorTo = "white"
    self.knob.outlineColor = SHADCN.GetColor(self.knob.outlineColorTo)
    self.knob.bgColorTo = "black"
    self.knob.bgColor = SHADCN.GetColor(self.knob.bgColorTo)
    self.knob.OnCursorMoved = function(s, x, y)
        if !input.IsMouseDown(MOUSE_LEFT) then return end
        local x = math.Clamp(s:GetX() + x - 8, 0, self:GetWide() - 16)
        s:SetX(x)
        self.progress = x / (self:GetWide() - 16)
    end
    self.knob.Paint = function(s, w, h)
        local animationsEnabled = SHADCN.Config.Animations:GetBool()
        local ft

        if animationsEnabled then
            ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()
            s.outlineColor = SHADCN.LerpColor(ft, s.outlineColor, SHADCN.GetColor(s.outlineColorTo))
            s.bgColor = SHADCN.LerpColor(ft, s.bgColor, SHADCN.GetColor(s.bgColorTo))
        end

        draw.NoTexture()
        surface.SetDrawColor(animationsEnabled and s.bgColor or SHADCN.GetColor(s.bgColorTo))
        surface.DrawPoly(s.poly)

        --surface.DrawCircle(w * .5, h * .5, h-1, animationsEnabled and s.outlineColor or SHADCN.GetColor(s.outlineColorTo))
        SHADCN.DrawOutline(s.poly, animationsEnabled and s.outlineColor or SHADCN.GetColor(s.outlineColorTo))
    end
end

function PANEL:GetValue()
    return self.progress
end

function PANEL:OnMouseReleased(keyCode)
    if keyCode != MOUSE_LEFT then return end
    local x, _ = self:CursorPos()
    x = math.Clamp(x - 8, 0, self:GetWide() - 16)
    self.knob:SetX(x)
    self.progress = x / (self:GetWide() - 16)
end

function PANEL:PerformLayout(w, h)
    if self.cachedW == w and self.cachedH == h then return end

    self.cachedW, self.cachedH = w, h
    self.poly = SHADCN.RoundedBox(8, 0, 5, w, 6)
end

function PANEL:Paint(w, h)
    local animationsEnabled = SHADCN.Config.Animations:GetBool()
    local ft

    if animationsEnabled then
        ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()
        self.progressColor = SHADCN.LerpColor(ft, self.progressColor, SHADCN.GetColor(self.progressColorTo))
        self.bgColor = SHADCN.LerpColor(ft, self.bgColor, SHADCN.GetColor(self.bgColorTo))
    end

    draw.NoTexture()
    surface.SetDrawColor(animationsEnabled and self.bgColor or SHADCN.GetColor(self.bgColorTo))
    surface.DrawPoly(self.poly)

    render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()

	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(1)
	render.SetStencilCompareFunction(STENCIL_NEVER)
	render.SetStencilFailOperation(STENCIL_REPLACE)

    draw.NoTexture()
    surface.SetDrawColor(255, 255, 255)
    surface.DrawPoly(self.poly)

	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilFailOperation(STENCIL_KEEP)

    surface.SetDrawColor(self.progressColor)
    surface.DrawRect(0, 0, w * self.progress, h)

	render.SetStencilEnable(false)
end

vgui.Register("SHADCN.Slider", PANEL)