# RegToMacro

[x] Tested, working as expectd
[x] Convert to Lua tables
[/] Re-Test - working as expected in terms of writing to the file. The Macro name is surrounded by square brackets.

# RegToReg

[x] Tested, working as expected
[x] Convert to Lua tables
[x] Re-Test - Working

# ShowMacros

[x] Tested, Working but sometimes causes VSCode to crash
[x] Convert to Lua tables
[x] Re-Test - Working, not had a crash since raising the below

---

**ISSUE**: Investigate VSCode crashes and launch method (calling `code` from the terminal currently)

**RESOLUTION**:

---

# MacroToReg

[x] Tested, working as expected
[x] Convert to Lua tables
[/] Re-Test - Not working, most likley due to the issue with it inserting square brackets. Will resolved and re-test

---

**ISSUE**: Command completes without error but macro is not inserted into the register

**RESOLUTION**: The table contains function was being used which checks the values of a talbe. A new function was added to check keys of table: table_contains_key

---

# Macro file location

[x] Relative paths working on Windows, needs checking on unix
[x] Absolute paths have been used up until now so should work without issue, will check on systems to confirm.
