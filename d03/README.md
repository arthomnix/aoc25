# Day 3

|                   |                   |
|-------------------|-------------------|
| Language          | PostScript        |
| Input Method      | file              |
| Output Method     | PDF document      |

## Running
```
gs -sDEVICE=pdfwrite -sOutputFile=out.pdf -dNOSAFER -- day3.ps <input file path>
```

(this code uses `.shellarguments` to read the name of the input file from the CLI arguments,
which I believe is a GhostScript-only thing, so this probably won't work on other PostScript
interpreters without some modification.)

## Notes
I think this one was better than day 1 again. It took me a while due to never having used PostScript before, but stack-based languages are always fun.