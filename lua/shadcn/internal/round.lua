function SHADCN.Round(size)
    if isnumber(size) then
        return size
    else
        return SHADCN.Rounds[size]
    end
end