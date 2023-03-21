local macroFile = require('macroHelper.macroFile')
local helpers = require('macroHelper.helpers')

vim.cmd('command! -nargs=1 RegToMacro lua require("macroHelper").reg_to_macro(<f-args>)')
vim.cmd('command! -nargs=1 RegToReg lua require("macroHelper").reg_to_reg(<f-args>)')

-----------------

local function reg_to_macro(args)
    local _args = helpers.str_split(args)
    local register = _args[1]
    local funcName = tostring(_args[2])

    -- Add macro to json file
    local macros = macroFile.register_to_json(register, funcName)

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

-----------------

local function setup()
    local macroObj = macroFile.get_macros()
    macroFile.json_macros_to_commands(macroObj.macros)
end

return {
    setup = setup,
    reg_to_macro = reg_to_macro,
    reg_to_reg = reg_to_reg,
}
