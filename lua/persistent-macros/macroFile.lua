local helpers = require('persistent-macros.helpers')

local M = {}

M.get_macros = function(macro_file_path)
    print(macro_file_path)

    if (not helpers.file_exists(macro_file_path)) then
        helpers.file_write(macro_file_path, "{}")
    end

    local macro_json_file = helpers.file_read(macro_file_path)
    local macro_table = helpers.json_decode(macro_json_file)

    return { macros = macro_table, macro_filepath = macro_file_path }
end

M.set_macros = function(macroObj)
    -- write table to macros.json
    local newJsonFileString = helpers.json_encode(macroObj.macros)
    helpers.file_write(macroObj.macro_filepath, newJsonFileString)
end

M.register_to_json = function(register, funcName)
    local contents = tostring(vim.fn.getreg(register))

    -- Convert macros.json to table
    local macroObj = M.get_macros()

    -- Alert if overwriting existing macro
    if (helpers.table_contains(macroObj.macros, funcName)) then
        print("Overwriting macro: " + funcName)
    end

    -- Add macros to table
    macroObj.macros[funcName] = contents

    -- write macros to file
    M.set_macros(macroObj)

    -- return macro table for further processing
    return macroObj.macros
end

M.json_macros_to_commands = function(macros)
    for k, v in pairs(macros) do
        local string_func = "function!" .. k .. "() \n normal " .. v .. "\n endfunction"
        vim.api.nvim_exec(string_func, false)
    end
end

return M
