
# **Boosting Your Neovim Workflow: A Guide to the "Persistent Macros Neovim" plugin**

- [**Boosting Your Neovim Workflow: A Guide to the "Persistent Macros Neovim" plugin**](#boosting-your-neovim-workflow-a-guide-to-the-persistent-macros-neovim-plugin)
  - [👋 Intro](#-intro)
  - [💾 **Saving Named Macros**](#-saving-named-macros)
  - [🏭 **Converting Named Macros to Registers**](#-converting-named-macros-to-registers)
  - [🔀 **Swapping Register Positions**](#-swapping-register-positions)
  - [🔁 **Syncing Macros Across Instances**](#-syncing-macros-across-instances)
  - [👀 **Viewing Saved Macros**](#-viewing-saved-macros)
  - [⌨️ Using custom commands with keybindings](#️-using-custom-commands-with-keybindings)
    - [Neovim Mappings](#neovim-mappings)
    - [VSCode Keyboard Shortcut](#vscode-keyboard-shortcut)
    - [Which key binding (VSCode)](#which-key-binding-vscode)
  - [🍴 Gimme Gimme Gimme](#-gimme-gimme-gimme)
  - [🙋‍♂️ **Conclusion**](#️-conclusion)


## 👋 Intro

If you're a Neovim user, you're probably familiar with macros: a way to record and replay a sequence of keystrokes. Macros can be incredibly useful for automating repetitive tasks or applying the same editing commands across multiple lines.

I love macros and they can help save a ton of time but managing them can get tricky. There’s only a limited number of registers and remembering their positions gets harder as they start to fill up.

This inspired me to try my hand at creating my first Neovim plugin (be gentle 😝). 

Enter the "Persistent Macros Neovim" plugin. This simple plugin provides extra functionality around macros, making them more powerful and persistent. Here's an overview of the main features:

- 💾 Save an unlimited amount of named macros from registers and expose them via a command
- 🏭 Convert named macros to registers
- 🔀 Swap register positions
- 🔁 Easy syncing of macros across instances
- 💻 Works with VSCode Neovim

Let's take a closer look at each of these features.

## 💾 **Saving Named Macros**

The plugin allows you to save named macros from registers and expose them via a command. This means that you can create a macro, give it a name, and then use that name to execute the macro later on. To save a macro, simply record it in a register using the **`q`** command, and then use the **`RegToMacro`** command to save it to a local JSON file and give it a name. For example:

```bash
:RegToMacro a MyFirstMacro
```

This saves the contents of register **`a`** as a macro named **`MyFirstMacro`**. You can then execute the macro by calling the command

```bash
:call MyFirstMacro()
```

One thing to note is that Vim expects functions to be in PascalCase, so make sure the first character of the macro name is uppercase.

## 🏭 **Converting Named Macros to Registers**

The plugin also allows you to convert named macros back to registers. This is useful if you want to modify a macro or use it in a different context. To convert a macro to a register, use the **`MacroToReg`** command, passing in the name of the macro and the register you want to store it in. For example:

```bash
:call MacroToReg MyFirstMacro a
```

This converts the **`MyFirstMacro`** macro to register **`a`**.

## 🔀 **Swapping Register Positions**

The **`RegToReg`** command allows you to swap the contents of two registers. This can be useful if you want to copy the contents of one register to another, or if you want to rearrange the order of your registers. To swap two registers, simply call the **`RegToReg`** command and pass in the names of the registers you want to swap. For example:

```bash
:RegToReg a b
```

This swaps the contents of registers **`a`** and **`b`**.

## 🔁 **Syncing Macros Across Instances**

A useful feature of the plugin is its ability to sync macros across instances. Since macros are stored in a local JSON file, you can easily back up the file and use it on different machines or instances. This means that you can have a consistent set of macros across all of your machines, making your workflow more efficient.

## 👀 **Viewing Saved Macros**

To view the saved macros in the file, use the **`:ShowMacros`** command. This will open the macros file in the current editor (supported in VSCode)

## ⌨️ Using custom commands with keybindings

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

## 🍴 Gimme Gimme Gimme

Persistent macros can be installed with your favorite package manger, see below for an example of how to install with [Lazy.nvim]([https://github.com/folke/lazy.nvim](https://github.com/folke/lazy.nvim))

```bash
{
    "kensleDev/persistent-macros.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
        require('persistent-macros').setup(".config/macros.json")
    end
}
```

For more information see the [README]([https://github.com/kensleDev/persistent-macros.nvim](https://github.com/kensleDev/persistent-macros.nvim)) on [Github]([https://github.com/kensleDev/persistent-macros.nvim](https://github.com/kensleDev/persistent-macros.nvim)). 

I would really appreciate it if you decide to give the plugin a go, and if you do come across any problems please raise an [Issue]([https://github.com/kensleDev/persistent-macros.nvim/issues](https://github.com/kensleDev/persistent-macros.nvim/issues)). 

## 🙋‍♂️ **Conclusion**

That’s it! It’s really quite simple and has been a joy to develop and I hope you give it a try. I’ve enjoyed getting familiar with Lua and it will hopefully be a springboard for many more plugins to come!