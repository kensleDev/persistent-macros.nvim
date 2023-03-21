# Persistent Macros

An very simple plugin to provide extra functionality around macros. 

## ✨ Features

- 💾 Save named macros from registers and expose them via a command
- 🔀 Swap register positions
- 🔄 Sync macros across instances

## 📦 Install

 - Packer Config
 - Lazy Config

## 🗺️ API

### Functions

- RegToMacro(register, macroName) - Allows you to save named macros and exposes them via command. 

- RegToReg(fromRegister, toRegister) - Swaps the position of the 2 specified registers

### Config

- MacroFileLocation - Sets the local location of the macros.json file

## 🧑‍🏭  Usage

### Setup

TODO: Make sure to to set MacroFileLocation in setup function


### RegToMacro

RegToMacro takes the value of a register, saves it to a local json file and makes it avalible as a command. For example:

1. Save a macro to a register using q

2. Call the reg to macro command and pass in the register and a name for the new macro:
```
:RegToMacro a MyFirstFunction
```

> **Wanring! Vim expections these functions to be Pascal Case so make sure the first character of the function is uppercase**: 

3. Call the function from command mode
```
:call MyFirstFunction()
```

### RegToReg

1. Call RegToReg from command mode to swap the contents of each register
```
:RegToReg a b
```

### Sync across instances

1. Set 

## Dependencies

- Uses dkjson.lua for json encoding
