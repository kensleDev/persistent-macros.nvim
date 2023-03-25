local M = {}

M.is_mac_unix = function()
    return vim.fn.has('macunix')
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
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        io.close(f)
        return false
    end
end

M.dir_exists_v1 = function(path)
    if (lfs.attributes(path, "mode") == "directory") then
        return true
    end
    return false
end

M.get_home_dir = function()
    local home_dir = ""
    local is_mac_unix = M.is_mac_unix()

    if (is_mac_unix) then
        home_dir = vim.fn.expand('~/')
    else
        home_dir = vim.fn.expand('$HOME\\')
    end

    return home_dir
end

M.assemble_home_path = function(path)
    local home_dir = M.get_home_dir()
    local newPath = ""

    if (vim.fn.has('macunix') == true) then
        newPath = home_dir .. path
    else
        local reaplced = path:gsub("/", "\\")
        newPath = home_dir .. reaplced
    end

    return newPath
end

return M