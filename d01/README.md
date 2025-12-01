# Day 1

|                   |                   |
|-------------------|-------------------|
| Language          | LLVM IR           |
| Input Method      | File              |
| Output Method     | stdout            |

## Running
```sh
llc -filetype=obj day1.ll -o day1.o
clang day1.o -o day1
./day1 <path to input file>
```

Part 1 is the first number output, Part 2 is the second number output.

## Notes
Requires a POSIX C standard library. Tested on Linux x86_64 and written assuming `ssize_t` is 64 bits; YMMV on other systems.

Most of my time on this one was spent debugging all the edge cases in part 2.