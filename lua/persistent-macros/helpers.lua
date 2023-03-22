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
    local file = assert(io.open(filepath, "r"))
    local content = file:read("*all")
    file:close()
    return tostring(content)
end

M.file_write = function(filepath, content)
    local file = assert(io.open(filepath, "w+"))
    file:write(content)
    file:close()
end

M.file_exists = function(name)
    print(name)
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

M.str_firstToUpper = function(str)
    return (str:gsub("^%l", string.upper))
end

return M
