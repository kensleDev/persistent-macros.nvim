
local h = require('persistent-macros.helpers')

local get_macros = function(file_path)
    if(not h.io.file_exists(file_path)) then
        h.notify.message("Writing macros.lua file to: " .. file_path, "info")
        h.io.file_write(file_path, "return { Test = \"yyp\"}")
    end
    
    local macros_string = h.io.file_read(file_path)
    
    local macros_table = load(macros_string)()

    return macros_table
end

local write_table_to_file = function(file_path, table)
    local macrosString = "return " .. h.table.to_string(table)
    h.io.file_write(file_path, macrosString)
end


local add_macro = function(file_path, name, macro)
    local macros = get_macros(file_path)
    local registerContents = tostring(vim.fn.getreg(macro))

    macros[name] = registerContents
    
    write_table_to_file(file_path, macros)

    return macros
end

local remove_macro = function(file_path, name)
    local macros = get_macros(file_path)
    
    macros[name] = nil

    write_table_to_file(file_path, macros)
end

local macros_to_commands = function(macros)
    for k, v in pairs(macros) do
        local string_func = "function!" .. h.string.firstToUpper(k) .. "() \n normal " .. v .. "\n endfunction"
        vim.api.nvim_exec(string_func, false)
    end
end

return {
    get_macros = get_macros,
    add_macro = add_macro,
    remove_macro = remove_macro,
    macros_to_commands = macros_to_commands
}

