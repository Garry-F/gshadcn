local sqrt = math.sqrt

local function f1(x, s)
    return s*(sqrt(1-(sqrt(1-x/s))^4))
end

local function f2(x, s)
    return s*(sqrt(1-(sqrt(x/s))^4))
end

local function f3(x, s)
    return s+(-s*(sqrt(1-(sqrt(1-x/s))^4)))
end

local function f4(x, s)
    return s+(-s*(sqrt(1-(sqrt(x/s))^4)))
end

local function reverseArray(array)
    local buffer = array
    local array = {}
    for i = 0, #buffer-1 do
        array[i] = buffer[#buffer-i]
    end

    return array
end

local function addPolyQLB(tbl, x, y, size, quality)
    local a = size / quality
    local currX = a
    local poly = {
        {
            x = x,
            y = y
        }
    }

    for i = 0, quality-1 do
        poly[#poly+1] = {
            x = x + currX,
            y = y + f1(currX, size)
        }

        currX = currX + a
    end

    poly = reverseArray(poly)

    poly[#poly+1] = {
        x = x + size,
        y = y + size
    }

    for i = 1, #poly do
        tbl[#tbl+1] = poly[i]
    end

    return tbl
end

local function addPolyQRB(tbl, x, y, size, quality)
    local a = size / quality
    local currX = a
    local poly = {
        {
            x = x,
            y = y + size
        }
    }

    for i = 0, quality-1 do
        poly[#poly+1] = {
            x = x + currX,
            y = y + f2(currX, size)
        }

        currX = currX + a
    end

    poly[#poly+1] = {x = x + size, y = y}

    poly = reverseArray(poly)

    for i = 1, #poly do
        tbl[#tbl+1] = poly[i]
    end

    return tbl
end

local function addPolyQLT(tbl, x, y, size, quality)
    local a = size / quality
    local currX = a
    local poly = {
        {
            x = x,
            y = y+size
        }
    }
    for i = 1, quality-1 do
        poly[#poly+1] = {
            x = x + currX,
            y = y + f3(currX, size)
        }

        currX = currX + a
    end

    poly[#poly+1] = {x = x+size, y = y}

    for i = 1, #poly do
        tbl[#tbl+1] = poly[i]
    end

    return tbl
end

local function addPolyQRT(tbl, x, y, size, quality)
    local tbl = tbl or {}
    local a = size / quality
    local currX = a
    local poly = {
        {
            x = x,
            y = y
        }
    }

    for i = 1, quality-1 do
        poly[#poly+1] = {
            x = x + currX,
            y = y + f4(currX, size)
        }

        currX = currX + a
    end

    poly[#poly+1] = {x = x + size, y = y + size}

    for i = 1, #poly do
        tbl[#tbl+1] = poly[i]
    end

    return tbl
end

local function roundedBoxPoly(round, x, y, w, h, quality, lt, rt, rb, lb)
    local wideIsBig = w > h
    local round = round or 0
    if !wideIsBig then
        round = math.Clamp(round, 0, ((lt && !rt && !lb && rb) || (!lt && rt && lb && !rb)) && w || w * .5)
    else
        round = math.Clamp(round, 0, ((lt && !rt && !lb && rb) || (!lt && rt && lb && !rb)) && h || h * .5)
    end

    local poly = {}

    if (lt && round != 0) then
        poly = addPolyQLT(poly, x, y, round, quality)
    else
        poly[1] = {x=x, y=y} 
    end

    if (rt && round != 0) then
        poly = addPolyQRT(poly, x+w-round, y, round, quality)
    else
        poly[#poly+1] = {x=x+w, y=y} 
    end

    if (rb && round != 0) then
        poly = addPolyQRB(poly, x+w-round, y+h-round, round, quality)
    else
        poly[#poly+1] = {x=x+w, y=y+h} 
    end

    if (lb && round != 0) then
        poly = addPolyQLB(poly, x, y+h-round, round, quality)
    else
        poly[#poly+1] = {x=x, y=y+h} 
    end

    poly[#poly] = nil

    return poly
end

function SHADCN.RoundedBox(round, x, y, w, h)
    return roundedBoxPoly(round, x, y, w, h, round, true, true, true, true)
end

--function SHADCN.RoundedBox(round, x, y, w, h)
--    local poly = {}
--
--    
--end