local function openFile(path)
    if SERVER then
        AddCSLuaFile(path)
    else
        include(path)
    end
end

local function openFolder(path)
    local files, folders = file.Find(path .. "/*", "LUA")
    
    for i = 1, #files do
        openFile(path .. "/" .. files[i])
    end

    for i = 1, #folders do
        openFolder(path .. "/" .. folders[i])
    end
end

openFolder("shadcn")