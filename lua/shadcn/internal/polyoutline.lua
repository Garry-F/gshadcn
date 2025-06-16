function SHADCN.DrawOutline(poly, color)
    surface.SetDrawColor(color.r, color.g, color.b)
    for i = 1, #poly-1 do
        surface.DrawLine(poly[i].x, poly[i].y, poly[i+1].x, poly[i+1].y)
    end
    surface.DrawLine(poly[1].x, poly[1].y, poly[#poly].x, poly[#poly].y)
end