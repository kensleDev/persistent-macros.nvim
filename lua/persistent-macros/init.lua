local h = require('persistent-macros.helpers')
local macro_store = require('persistent-macros.store.macro_store')

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
        _macro_file_path = h.io.assemble_home_path(macro_file_path)
    end

    print(_macro_file_path)
    local macros = macro_store.get_macros(_macro_file_path)
    macro_store.macros_to_commands(macros)

    print(h.table.to_string(macros))
end

-----------------

local function show_macros()
    if vim.g.vscode then
        os.execute('code ' .. _macro_file_path)
        -- VSCode extension
    else
        -- ordinary Neovim
        vim.api.nvim_exec('e ' .. _macro_file_path, false)
    end
end

local function reg_to_macro(args)
    local _args = h.string.split(args)
    local register = _args[1]
    local funcName = tostring(_args[2])

    local registerValue = tostring(vim.fn.getreg(register))

    if(registerValue.len == 0) then
        print("Register: " .. register .. " is empty")
        return
    end

    local macros = macro_store.add_macro(_macro_file_path, funcName, register)
    macro_store.macros_to_commands(macros) -- TODO: Optimise

    print("Macro added: " .. funcName)
end

local function reg_to_reg(args)
    local _args = h.string.split(args)
    local regFrom = _args[1]
    local regTo = _args[2]

    local fromContents = tostring(vim.fn.getreg(regFrom))
    local toContents = tostring(vim.fn.getreg(regTo))

    if(fromContents.len == 0 and toContents == 0) then
        print("Registers are empty: from: " ..regFrom .. " to: " .. regTo)
        return
    end

    vim.fn.setreg(regTo, fromContents)
    vim.fn.setreg(regFrom, toContents)
end

local function macro_to_reg(args)
    local _args = h.string.split(args)
    local macroName = tostring(_args[1])
    local register = tostring(_args[2])

    local macros = macro_store.get_macros(_macro_file_path)

    if (h.table.contains_key(macros, macroName)) then
        vim.fn.setreg(register, macros[macroName])
    else
        print("Macro not found: " .. macroName)
    end
end

local remove_macro = function(args)
    local _args = h.string.split(args)
    local macroName = tostring(_args[1])

    local macros = macro_store.get_macros(_macro_file_path)

    if (h.table.contains_key(macros, macroName)) then
        macro_store.remove_macro(_macro_file_path, macroName)
        macro_store.macros_to_commands(macros) -- TODO: Optimise
        print("Macro removed: " .. macroName)
    else
        print("Macro not found: " .. macroName)
    end
    
end
-----------------

return {
    setup = setup,
    reg_to_macro = reg_to_macro,
    reg_to_reg = reg_to_reg,
    show_macros = show_macros,
    macro_to_reg = macro_to_reg,
    remove_macro = remove_macro
}
