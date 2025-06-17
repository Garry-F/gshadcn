local PANEL = {}

function PANEL:Init()
    self.title = "Title"
    self.subTitle = "Subtitle"
    self.titleColorTo = "white"
    self.titleColor = SHADCN.GetColor(self.titleColorTo)
    self.subTitleColorTo = "lightGray"
    self.subTitleColor = SHADCN.GetColor(self.subTitleColorTo)
    self.buttons = 0

    self.alertDialog = self:Add("SHADCN.Base.RoundedBox")
    self.alertDialog:SetSize(0, 0)
    self.alertDialog:SetRound("lg")
    self.alertDialog:SetAnimation("centerOpen")
    self.alertDialog.buttons = self.alertDialog:Add("Panel")
    self.alertDialog.buttons:SetSize(0, 36)
    self.alertDialog.OnClose = function()
        self:Close(true)
    end
    self.alertDialog.OverPaint = function(s, w, h)
        local animationsEnabled = SHADCN.Config.Animations:GetBool()
        local ft

        if animationsEnabled then
            ft = FrameTime() * 12 * SHADCN.Config.AnimationsSpeed:GetFloat()

            self.titleColor = SHADCN.LerpColor(ft, self.titleColor, SHADCN.GetColor(self.titleColorTo))
            self.subTitleCoor = SHADCN.LerpColor(ft, self.subTitleColor, SHADCN.GetColor(self.subTitleColorTo))
        end

        surface.SetFont("SHADCN.B20")
        surface.SetTextColor(animationsEnabled and self.titleColor or SHADCN.GetColor(self.titleColorTo))
        surface.SetTextPos(24, 24)
        surface.DrawText(self.title)

        draw.DrawText(self.subTitle, "SHADCN.R16", 24, 50, animationsEnabled and self.subTitleColor or SHADCN.GetColor(self.subTitleColorTo), TEXT_ALIGN_LEFT)

        --self:GetParent().OverPaint(s, w, h)
    end
end

function PANEL:Open()
    self.alertDialog:Open()
end

function PANEL:OnClose()
    self.alertDialog:Close()
end

function PANEL:SetTitle(title)
    self.title = title
    surface.SetFont("SHADCN.B20")
    local w, h = surface.GetTextSize(title)
    if w + 48 > self.alertDialog:GetWide() then
        self.alertDialog:SetWide(w + 48)
        self.alertDialog:Center()
    end
end

function PANEL:SetSubTitle(subTitle)
    self.subTitle = subTitle
    surface.SetFont("SHADCN.R16")
    local w, h = surface.GetTextSize(subTitle)
    if w + 48 > self.alertDialog:GetWide() then
        self.alertDialog:SetWide(w + 48)
        self.alertDialog:Center()
    end
    if h + 112 > self.alertDialog:GetTall() then
        self.alertDialog:SetTall(h + 112)
        self.alertDialog:Center()
    end
    self.alertDialog.buttons:SetY(self.alertDialog:GetTall() - 50)
end

function PANEL:AddCancelButton(text)
    local button = self.alertDialog.buttons:Add("SHADCN.Button")
    --button:SetAlpha(0)
    button:SetPos(self.buttons == 0 and 0 or self.alertDialog.buttons:GetWide() + 8)
    button:SetBGColor("primary2")
    button:SetHoverColor("primary2Hover")
    button:SetTextColor("white")
    button:SetDrawOutline(true)
    button:SetText(text)
    button.OnClick = function(s)
        self:Close()
    end

    self.alertDialog.buttons:SetWide(self.alertDialog.buttons:GetWide() + button:GetWide() + 8)
    if self.alertDialog.buttons:GetWide() + 48 > self.alertDialog:GetWide() then
        self.alertDialog:SetWide(self.alertDialog.buttons:GetWide() + 48)
        self.alertDialog:Center()
    end
    self.alertDialog.buttons:SetX(self.alertDialog:GetWide() - self.alertDialog.buttons:GetWide() - 24)
    self.buttons = self.buttons + 1
end

function PANEL:AddActionButton(text, onClick)
    local button = self.alertDialog.buttons:Add("SHADCN.Button")
    --button:SetAlpha(0)
    button:SetPos(self.buttons == 0 and 0 or self.alertDialog.buttons:GetWide() + 8)
    button:SetText(text)
    button.OnClick = function(s)
        onClick(s)
        self:Close()
    end

    self.alertDialog.buttons:SetWide(self.alertDialog.buttons:GetWide() + button:GetWide() + 8)
    if self.alertDialog.buttons:GetWide() + 48 > self.alertDialog:GetWide() then
        self.alertDialog:SetWide(self.alertDialog.buttons:GetWide() + 48)
        self.alertDialog:Center()
    end
    self.alertDialog.buttons:SetX(self.alertDialog:GetWide() - self.alertDialog.buttons:GetWide() - 24)
    self.buttons = self.buttons + 1
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

vgui.Register("SHADCN.AlertDialog", PANEL, "SHADCN.Base.FullScreen")