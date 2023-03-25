local M = {}

M.contains = function(table, key)
    for _, v in pairs(table) do
        if v == key then return true end
    end
    return false
end

M.contains_key = function(table, key)
    local contains_key = false

    for k, v in pairs(table) do
        if (k == key) then
            contains_key = true
        end
    end

    return contains_key
end

M.to_string = function (tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

M.print = function(tbl)
    print(M.to_string(tbl))
end


return M