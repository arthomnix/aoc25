# Day 9

|                   |                   |
|-------------------|-------------------|
| Language          | Picat             |
| Input Method      | File              |
| Output Method     | stdout            |

## Running
Obtain Picat from [here](https://picat-lang.org/download.html) and add it to your PATH,
then
```sh
picat day9.pi <path to input file>
```

## Notes
This solution is based on constraint programming, which is what Picat was designed for.
This is of course nowhere near as fast as a bespoke optimised solution; this code takes
~15 minutes to solve both parts on my laptop.