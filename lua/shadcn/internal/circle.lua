local math_Approach, sin, cos, rad = math.Approach, math.sin, math.cos, math.rad
function SHADCN.Circle(x, y, radius, quality)
    local circle = {}
    local tmp = 0
    local s, c

    for i = 1, quality do
        tmp = rad(i * 360) / quality
        s = sin(tmp)
        c = cos(tmp)

        circle[i] = {
            x = x + c * radius,
            y = y + s * radius,
            u = (c + 1) / 2,
            v = (s + 1) / 2
        }
    end

    return circle
end