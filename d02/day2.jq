def solve($regex):
    split(",") 
        | map(
              split("-") 
            | map(tonumber)
            | range(.[0]; .[1] + 1)
            | tostring
            | if test($regex) then . | tonumber else 0 end
        )
        | add;

solve("^(.+?)\\1$"),
solve("^(.+?)\\1+$")