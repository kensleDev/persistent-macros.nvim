local macroFile = require('persistent-macros.macroFile')
local helpers = require('persistent-macros.helpers')

local _macro_file_path = ""

vim.cmd('command! -nargs=1 RegToMacro lua require("persistent-macros").reg_to_macro(<f-args>)')
vim.cmd('command! -nargs=1 RegToReg lua require("persistent-macros").reg_to_reg(<f-args>)')
vim.cmd('command! -nargs=1 ShowMacros lua require("persistent-macros").show_macros(<f-args>)')
-----------------

local function setup(macro_file_path)
    _macro_file_path = macro_file_path
    local macroObj = macroFile.get_macros(macro_file_path)
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
    local _args = helpers.split(args)
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
    local _args = helpers.split(args)

    local macroName = _args[1]
    local register = _args[2]

    local macroObj = macroFile.get_macros(_macro_file_path)
    local macros = macroObj.macros
    local currentMacroValue = tostring(macros[macroName])

    if (currentMacroValue.len > 0) then
        vim.fn.setreg(register, currentMacroValue)
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
