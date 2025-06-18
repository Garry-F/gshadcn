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

local function createFont(fontType, size)
    surface.CreateFont("SHADCN." .. fontType .. size, {
    	font = "Geist" .. (fontTypes[fontType] and fontTypes[fontType] or ""),
    	extended = true,
    	size = size
    })
end

createFont("R", 14)
createFont("R", 16)
createFont("SB", 16)
createFont("B", 14)
createFont("B", 18)
createFont("B", 20)