#!/usr/bin/sed -Enf

s/S/a/

N
    # separate the columns for our shenanigans later
    s/(\.|([a-z]+)|\^)/\1|/g; s/\|+/|/g

    # propagation
    : step-loop
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){140})\./\U\1\E|\2\1/g
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){140})([a-z]+)/\U\1\E|\2\5\1/g
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){139})\.\|\^\|\./\U\1\E|\2\1|^|\1/g                               
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){139})([a-z]+)\|\^\|\./\U\1\E|\2\1\5|^|\1/g                    
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){139})\.\|\^\|([a-z]+)/\U\1\E|\2\1|^|\1\5/g                    
        s/([a-z]+)\|((\n?([a-zA-Z]+|\.|\^)\|\n?){139})([a-z]+)\|\^\|([a-z]+)/\U\1\E|\2\1\5|^|\1\6/g         
    t step-loop
    s/(.)/\L\1/g

    # addition, sed-style
    : sort-loop
        s/(o+)([^o\|]+)(o+)/\1\3\2/g
        s/(n+)([^n\|]+)(n+)/\1\3\2/g
        s/(m+)([^m\|]+)(m+)/\1\3\2/g
        s/(l+)([^l\|]+)(l+)/\1\3\2/g
        s/(k+)([^k\|]+)(k+)/\1\3\2/g
        s/(j+)([^j\|]+)(j+)/\1\3\2/g
        s/(i+)([^i\|]+)(i+)/\1\3\2/g
        s/(h+)([^h\|]+)(h+)/\1\3\2/g
        s/(g+)([^g\|]+)(g+)/\1\3\2/g
        s/(f+)([^f\|]+)(f+)/\1\3\2/g
        s/(e+)([^e\|]+)(e+)/\1\3\2/g
        s/(d+)([^d\|]+)(d+)/\1\3\2/g
        s/(c+)([^c\|]+)(c+)/\1\3\2/g
        s/(b+)([^b\|]+)(b+)/\1\3\2/g
        s/(a+)([^a\|]+)(a+)/\1\3\2/g
    t sort-loop

    s/([a-n]+)(o+)/\2\1/g
    s/([a-m]+)(n+)/\2\1/g
    s/([a-l]+)(m+)/\2\1/g
    s/([a-k]+)(l+)/\2\1/g
    s/([a-j]+)(k+)/\2\1/g
    s/([a-i]+)(j+)/\2\1/g
    s/([a-h]+)(i+)/\2\1/g
    s/([a-g]+)(h+)/\2\1/g
    s/([a-f]+)(g+)/\2\1/g
    s/([a-e]+)(f+)/\2\1/g
    s/([a-d]+)(e+)/\2\1/g
    s/([a-c]+)(d+)/\2\1/g
    s/([a-b]+)(c+)/\2\1/g
    s/(a+)(b+)/\2\1/g

    : merge-loop
        s/aaaaaaaaaa/b/g
        s/bbbbbbbbbb/c/g
        s/cccccccccc/d/g
        s/dddddddddd/e/g
        s/eeeeeeeeee/f/g
        s/ffffffffff/g/g
        s/gggggggggg/h/g
        s/hhhhhhhhhh/i/g
        s/iiiiiiiiii/j/g
        s/jjjjjjjjjj/k/g
        s/kkkkkkkkkk/l/g
        s/llllllllll/m/g
        s/mmmmmmmmmm/n/g
        s/nnnnnnnnnn/o/g
    t merge-loop

    # final calculation and printing
    $ {
        s/.*\n//    # get only the second of the pair of lines we're looking at
        s/[^a-z]//g # remove everything that isn't a letter
                    # (i.e. concatenate all the numbers on the bottom row)

        # same addition code as above
        : sort-loop-final
            s/(o+)([^o\|]+)(o+)/\1\3\2/g
            s/(n+)([^n\|]+)(n+)/\1\3\2/g
            s/(m+)([^m\|]+)(m+)/\1\3\2/g
            s/(l+)([^l\|]+)(l+)/\1\3\2/g
            s/(k+)([^k\|]+)(k+)/\1\3\2/g
            s/(j+)([^j\|]+)(j+)/\1\3\2/g
            s/(i+)([^i\|]+)(i+)/\1\3\2/g
            s/(h+)([^h\|]+)(h+)/\1\3\2/g
            s/(g+)([^g\|]+)(g+)/\1\3\2/g
            s/(f+)([^f\|]+)(f+)/\1\3\2/g
            s/(e+)([^e\|]+)(e+)/\1\3\2/g
            s/(d+)([^d\|]+)(d+)/\1\3\2/g
            s/(c+)([^c\|]+)(c+)/\1\3\2/g
            s/(b+)([^b\|]+)(b+)/\1\3\2/g
            s/(a+)([^a\|]+)(a+)/\1\3\2/g
        t sort-loop-final

        s/([a-n]+)(o+)/\2\1/g
        s/([a-m]+)(n+)/\2\1/g
        s/([a-l]+)(m+)/\2\1/g
        s/([a-k]+)(l+)/\2\1/g
        s/([a-j]+)(k+)/\2\1/g
        s/([a-i]+)(j+)/\2\1/g
        s/([a-h]+)(i+)/\2\1/g
        s/([a-g]+)(h+)/\2\1/g
        s/([a-f]+)(g+)/\2\1/g
        s/([a-e]+)(f+)/\2\1/g
        s/([a-d]+)(e+)/\2\1/g
        s/([a-c]+)(d+)/\2\1/g
        s/([a-b]+)(c+)/\2\1/g
        s/(a+)(b+)/\2\1/g

        : merge-loop-final
            s/aaaaaaaaaa/b/g
            s/bbbbbbbbbb/c/g
            s/cccccccccc/d/g
            s/dddddddddd/e/g
            s/eeeeeeeeee/f/g
            s/ffffffffff/g/g
            s/gggggggggg/h/g
            s/hhhhhhhhhh/i/g
            s/iiiiiiiiii/j/g
            s/jjjjjjjjjj/k/g
            s/kkkkkkkkkk/l/g
            s/llllllllll/m/g
            s/mmmmmmmmmm/n/g
            s/nnnnnnnnnn/o/g
        t merge-loop-final

        # convert the result to decimal and print
        : decimal-loop
            /a/! s/[b-o]*/&0/
            s/aaaaaaaaa/9/
            s/aaaaaaaa/8/
            s/aaaaaaa/7/
            s/aaaaaa/6/
            s/aaaaa/5/
            s/aaaa/4/
            s/aaa/3/
            s/aa/2/
            s/a/1/
            : next
            y/bcdefghijklmno/abcdefghijklmn/
            /[a-o]/ b decimal-loop
        p
    }
D