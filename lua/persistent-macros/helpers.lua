local json = require("persistent-macros.libs.dkjson")

local M = {}

M.set = function(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

M.table_contains = function(table, key)
    local _set = M.set(table)
    if _set[key] then return true end
    return false
end

M.file_read = function(filepath)
    local f = assert(io.open(filepath, "w"))
    local content = f:read("*all")
    f:close()
    return tostring(content)
end

M.file_write = function(filepath, content)
    local file = io.open(filepath, "w+")
    if file ~= nil then
        file:write(content)
        file:close()
    end
end

M.file_exists = function(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

M.dir_exists_v1 = function(path)
    if (lfs.attributes(path, "mode") == "directory") then
        return true
    end
    return false
end

M.json_decode = function(json_file_string)
    local currentJsonFileTable = {}

    local obj, pos, err = json.decode(json_file_string, 1, nil)

    if err then
        print("Error:", err)
    else
        if (type(obj) == "table") then
            currentJsonFileTable = obj
        end
    end

    return currentJsonFileTable
end

M.json_encode = function(lua_table)
    return json.encode(lua_table)
end

M.str_split = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

return M
