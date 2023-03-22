# RegToMacro

[x] Tested, working as expectd

# RegToReg

[x] Tested, working as expected

# ShowMacros

[x] Tested, Working but sometimes causes VSCode to crash

*****
**ISSUE**: Investigate VSCode crashes and launch method (calling ```code``` from the terminal currently) 

**RESOLUTION**: 
*****

# MacroToReg

[x] Tested, working as expected

*****
**ISSUE**: Command completes without error but macro is not inserted into the register

**RESOLUTION**: The table contains function was being used which checks the values of a talbe. A new function was added to check keys of table: table_contains_key
*****

# Macro file location

[/] Relative paths working on Windows, needs checking on unix
[x] Absolute paths have been used up until now so should work without issue, will check on systems to confirm.


# Misc

[ ] - 
