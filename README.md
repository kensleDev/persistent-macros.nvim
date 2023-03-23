# Persistent Macros Neovim 

A simple plugin to provide extra functionality around macros. 

[Blog post](https://dev.to/juliani/boosting-your-neovim-workflow-a-guide-to-the-persistent-macros-neovim-plugin-34p3-temp-slug-9609331/edit#-%E2%8C%A8%EF%B8%8F-using-custom-commands-with-key-bindings)

## Contents

- [Persistent Macros Neovim](#persistent-macros-neovim)
  - [Contents](#contents)
  - [✨ Features](#-features)
  - [📦 Install](#-install)
  - [🧑‍🏭  Usage](#--usage)
    - [RegToMacro](#regtomacro)
    - [MacroToReg](#macrotoreg)
    - [RegToReg](#regtoreg)
    - [ShowMacros()](#showmacros)
    - [Sync across instances](#sync-across-instances)
  - [Using custom commands with keybindings](#using-custom-commands-with-keybindings)
    - [Neovim Mappings](#neovim-mappings)
    - [VSCode Keyboard Shortcut](#vscode-keyboard-shortcut)
    - [Which key binding (VSCode)](#which-key-binding-vscode)
  - [Dependencies](#dependencies)


## ✨ Features

- 💾 Save named macros from registers and expose them via a command
- 🏭 Convert named macros to registers
- 🔀 Swap register positions
- 🔁 Sync macros across instances
- ✏️ Edit macros in your current editor
- 🗺 Map macro commands to key binds in your current editor
- 🔧 Works with VSCode Neovim

## 📦 Install

- 💤Lazy.nvim config

```
{
    "kensleDev/persistent-macros.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
        require('persistent-macros').setup(".config/macros.json")
    end
}
```

## 🧑‍🏭  Usage

> **Before use make sure to pass the macroFileLocation to the setup function as above. The default location is relative to the users home folder. If not using a location relative to the home folder pass the absolute path**

```
config = function()
    -- relative to home directory (unix or windows)
    require('persistent-macros').setup(".config/macros.json")

    -- absolute unix
    require('persistent-macros').setup("/home/{USERNAME}/.config/macros.json")

    -- absolute windows
    require('persistent-macros').setup("C:\\Users\\{USERNAME}\\.config\\macros.json")
end
```


### RegToMacro

RegToMacro takes the value of a register, saves it to a local json file and makes it avalible as a command.

| arg       | type   | info                             |
| --------- | ------ | -------------------------------- |
| register  | string | The register to convert          |
| macroName | string | A name to reference the macro by |
|           |        |                                  |

1. Save a macro to a register using q

2. Call the reg to macro command and pass in the register and a name for the new macro:
```
:RegToMacro a MyFirstFunction
```

> **Warning! Vim expections these functions to be Pascal Case so make sure the first character of the function is uppercase**: 

3. Call the function from command mode
```
:call MyFirstFunction()
```

### MacroToReg

Convert a named function to a register. 

| arg       | type   | info                             |
| --------- | ------ | -------------------------------- |
| macroName | string | The named macro to convert       |
| register  | string | The register to put the macro in |
|           |        |                                  |

1. Call the command with the Macro name and register to store it in
```
:call RegToMacro Test g
```

### RegToReg

Swaps the position of the 2 specified registers.

| arg          | type   | info         |
| ------------ | ------ | ------------ |
| fromRegister | string | Position one |
| toRegister   | string | Position two |
|              |        |              |

1. Call RegToReg from command mode to swap the contents of each register
```
:RegToReg a b
```

### ShowMacros()

Opens the macros file in the current editor. Works with Neovim or VSCode.

1. Call the command
```
:call ShowMacros()
```


### Sync across instances

As the plugin is driven from a external json file json file it can easily be backed up for use on other instances/machines via source control.


## Using custom commands with keybindings

When you save a macro the plugin registers a command that can be called via Neovim. For example if you save a macro called “Test” then the following command will be available:

```bash
:call Test()
```

These commands can then be used in: 

### Neovim Mappings

```bash
vim.keymap.set("n", "<leader>m", function()
    vim.cmd([[:ShowMacros()]])
end, { noremap = true, silent = true })
```

### VSCode Keyboard Shortcut

```json
{
    "key": "ctrl+m",
    "command": "vscode-neovim.send",
    "args": ":ShowMacros()<cr>",
    "when": "editorTextFocus && neovim.mode != insert"
}
```

### Which key binding (VSCode)

```json
"whichkey.bindings": [
  ...
  {
    "name": "Neovim test",
    "key": "m",
    "command": "vscode-neovim.send",
    "args": ":ShowMacros()<cr>",
    "when": "editorTextFocus && neovim.mode != insert"
  },
  ...
]
```


## Dependencies

- Uses dkjson.lua for json encoding
