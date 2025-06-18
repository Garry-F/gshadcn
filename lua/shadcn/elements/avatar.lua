local PANEL = {}

function PANEL:Init()
    self:SetSize(0, 0)

    self.avatar = self:Add("AvatarImage")
    self.avatar:SetPaintedManually(true)
    self.avatar:Dock(FILL)
end

function PANEL:SetPlayer(p, s)
    self.avatar:SetPlayer(p, s)
end

function PANEL:PerformLayout(w, h)
    self.poly = SHADCN.Circle(w * .5, h * .5, h * .5, h * .5)
end

function PANEL:Paint(w, h)
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
        surface.SetDrawColor(color_white)
        surface.DrawPoly(self.poly)

	    render.SetStencilCompareFunction(STENCIL_EQUAL)
	    render.SetStencilFailOperation(STENCIL_KEEP)

        self.avatar:PaintManual(w, h)

	    render.SetStencilEnable(false)
    end

vgui.Register("SHADCN.Avatar", PANEL, "Panel")