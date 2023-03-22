local macroFile = require('persistent-macros.macroFile')
local helpers = require('persistent-macros.helpers')

local _macro_file_path = ""

vim.cmd('command! -nargs=1 RegToMacro lua require("persistent-macros").reg_to_macro(<f-args>)')
vim.cmd('command! -nargs=1 RegToReg lua require("persistent-macros").reg_to_reg(<f-args>)')
vim.cmd('command! -nargs=1 MacroToReg lua require("persistent-macros").macro_to_reg(<f-args>)')
vim.cmd('command! -nargs=1 ShowMacros lua require("persistent-macros").show_macros(<f-args>)')
-----------------

local function setup(macro_file_path)
    local firstLetter = macro_file_path:sub(0, 1)
    local withoutDriveLetter = macro_file_path:sub(1, 3)

    if (firstLetter == "/" or withoutDriveLetter == ":\\") then
        _macro_file_path = macro_file_path
    else
        _macro_file_path = helpers.assemble_home_path(macro_file_path)
    end

    local macroObj = macroFile.get_macros(_macro_file_path)
    for i, v in ipairs(macroObj.macros) do print(i, v) end
    macroFile.json_macros_to_commands(macroObj.macros)
end

-----------------

local function reg_to_macro(args)
    local _args = helpers.str_split(args)
    local register = _args[1]
    local funcName = tostring(_args[2])

    -- Add macro to json file
    local macros = macroFile.register_to_json(register, funcName, _macro_file_path)

    -- Convert macro into vimscript command
    macroFile.json_macros_to_commands(macros)
end

local function reg_to_reg(args)
    local _args = helpers.str_split(args)
    local regFrom = _args[1]
    local regTo = _args[2]

    local fromContents = tostring(vim.fn.getreg(regFrom))
    local toContents = tostring(vim.fn.getreg(regTo))

    vim.fn.setreg(regTo, fromContents)
    vim.fn.setreg(regFrom, toContents)
end

local function show_macros()
    if vim.g.vscode then
        os.execute('code ' .. _macro_file_path)
        -- VSCode extension
    else
        -- ordinary Neovim
        vim.api.nvim_exec('e ' .. _macro_file_path, false)
    end
end

local function macro_to_reg(args)
    local _args = helpers.str_split(args)

    local macroName = tostring(_args[1])
    local register = tostring(_args[2])

    local macroObj = macroFile.get_macros(_macro_file_path)
    local macros = macroObj.macros

    local valueInTable = helpers.table_contains_key(macros, macroName)

    local macro = tostring(macros[macroName])

    if (valueInTable) then
        vim.fn.setreg(register, macro)
    end
end
-----------------

return {
    setup = setup,
    reg_to_macro = reg_to_macro,
    reg_to_reg = reg_to_reg,
    show_macros = show_macros,
    macro_to_reg = macro_to_reg
}
