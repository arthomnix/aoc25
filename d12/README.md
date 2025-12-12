# Day 12

|                   |                                               |
|-------------------|-----------------------------------------------|
| Language          | fasmg macros                                  |
| Input Method      | File                                          |
| Output Method     | File (raw 16-bit little endian binary number) |

## Running
```sh
fasmg -i'include "day12.inc"' <path to input file>
```

## Notes
This relies on a particular property of real inputs which doesn't hold for the example, so this will not provide the correct answer for
the example input.

The output will be left in a binary file with the same name as the input file but with the extension removed. The output file will be a
2-byte binary, which is the puzzle answer as a 16-bit little endian number. Note that the output file will be left in the same directory
as the input file, not the current working directory.