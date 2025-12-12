macro count_hashes: res*, line*
    match ## , line
        res = 2
    else match #., line
        res = 1
    else match .#, line
        res = 1
    else match .., line
        res = 0
    else match # rest , line
        local recursive_res
        count_hashes recursive_res, rest
        res = 1 + recursive_res
    else match . rest , line
        count_hashes res, rest
    end match
end macro

macro sum_areas: res*, count*, line*
    match n rest, line
        local tmp
        sum_areas tmp, count + 1, rest
        repeat 1, i:count
            res = tmp + (area#i * n)
        end repeat
    else 
        repeat 1, i:count
            res = area#i * line
        end repeat
    end match
end macro

ans = 0

macro ? line
    match num:, line
        current_shape = num
        repeat 1, i:current_shape
            area#i = 0
        end repeat
    else match # rest, line
        local tmp
        count_hashes tmp, rest
        repeat 1, i:current_shape
            area#i = area#i + tmp + 1
        end repeat
    else match . rest, line
        local tmp
        count_hashes tmp, rest
        repeat 1, i:current_shape
            area#i = area#i + tmp
        end repeat
    else match dims: rest, line
        virtual at 0
            db `dims
            load tmp:byte from $-5
            a = 10 * (tmp - $30)
            load tmp:byte from $-4
            a = a + (tmp - $30)
            load tmp:byte from $-2
            b = 10 * (tmp - $30)
            load tmp:byte from $-1
            b = b + (tmp - $30)
        end virtual
        
        local area
        sum_areas area, 0, rest
        if area <= (a * b)
            ans = ans + 1
        end if
    else
        line
    end match
end macro

postpone
    dw ans
end postpone