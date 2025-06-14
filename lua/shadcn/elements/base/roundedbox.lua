local PANEL = {}

function PANEL:Init()
    self.cachedW, self.cachedH = 0, 0
end

function PANEL:CachePoly()
    self.poly = SHADCN.RoundedBox(...)
end

function PANEL:PerformLayout(w, h)
    if self.cachedW == w and self.cachedH == h then return end

    self.cachedW, self.cachedH = w, h
    self:CachePoly()
end

function PANEL:Paint(w, h)
end

vgui.Register("SHADCN.Base.RoundedBox", PANEL)