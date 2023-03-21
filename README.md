# Persistent Macros

An very simple plugin to provide extra functionality around macros. 

## ✨ Features

- 💾 Save named macros from registers and expose them via a command
- 🏭 Convert named macros to registers
- 🔀 Swap register positions
- 🔁 Sync macros across instances
- 🔧 Works with VSCode Neovim

## 📦 Install

- 💤Lazy.nvim config

```
{
    "kensleDev/persistent-macros.nvim",
    event = "VeryLazy",
    config = function()
        local macroFileLocation = "C:\\Users\\Administrator\\.config\\macros.json"
        require('persistent-macros').setup(macroFileLocation)
    end
}
```

## 🧑‍🏭  Usage

> **Before use make sure to pass the macroFileLocation to the setup function**: 

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

1. Call the command with the Macro name and register
```
:call RegToMacro Test g
```

### RegToReg

Swaps the position of the 2 specified registers

| arg          | type   | info         |
| ------------ | ------ | ------------ |
| fromRegister | string | Position one |
| toRegister   | string | Position two |
|              |        |              |

1. Call RegToReg from command mode to swap the contents of each register
```
:RegToReg a b
```

#### ShowMacros()

Opens the macros file in the current editor. Works with neovim or VSCode

1. Call the command
```
:call ShowMacros()
```


### Sync across instances

As the plugin is driven from a external json file json file it can easily be backed up for use on other instances.

To trial different configs, update the macro file location in the setup function.


## Dependencies

- Uses dkjson.lua for json encoding
