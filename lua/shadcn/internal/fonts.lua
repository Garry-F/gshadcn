local fontTypes = {
    ["BL"] = " Black",
    ["EB"] = " ExtraBold",
    ["B"]  = " Bold",
    ["SB"] = " SemiBold",
    ["M"]  = " Medium",
    ["L"]  = " Light",
    ["EL"] = " ExtraLight",
    ["T"]  = " Thin"
}

local function createFont(size, fontType)
    surface.CreateFont("SHADCN." .. fontType .. size, {
    	font = "Geist" .. (fontTypes[fontType] and fontTypes[fontType] or ""),
    	extended = true,
    	size = size
    })
end

createFont(16, "SB")