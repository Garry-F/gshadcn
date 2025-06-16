local themes = {}
local currentTheme = nil

function SHADCN.CreateTheme(name, colors)
    themes[name] = colors
end

function SHADCN.SelectTheme(name)
    currentTheme = name
end

function SHADCN.GetColor(color)
    return themes[currentTheme][color]
end