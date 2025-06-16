function SHADCN.LerpColor(f, from, to)
    return Color(Lerp(f, from.r, to.r), Lerp(f, from.g, to.g), Lerp(f, from.b, to.b), Lerp(f, from.a, to.a))
end