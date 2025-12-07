#!/usr/bin/sed -Enf

# Start the beam going
s/S/|/; h

: outer
    g          # get the contents of the hold space
    s/\n//g    # remove newlines
    s/H/H\n/g  # split on the letter H
    s/[^\n]//g # remove everything except newlines
    s/\n/a/g   # replace newlines with a letter a

    # stolen from section 7.12 of the sed manual (counting characters)
    t a
    : a;  s/aaaaaaaaaa/b/g; t b; b loop
    : b;  s/bbbbbbbbbb/c/g; t c; b loop
    : c;  s/cccccccccc/d/g; t d; b loop
    : d;  s/dddddddddd//g
    : loop
        /a/! s/[b-d]*/&0/
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
        y/bcd/abc/
        /[a-d]/ b loop
    # on the last line, print out the answer
    $p
    
    g          # get the contents of hold space, again
    s/.*\n//   # only get the last line
    N          # we want to operate on pairs of lines, so read in another line
    : inner
        # We hardcode the grid size here
        # We actually replace '|'s we have processed with 'D's and then replace them back
        # at the end, because otherwise the regexes (regices?) would only ever match the
        # first occurence
        s/\|(.{141})\./D\1D/g        # A '.' below a '|' should be replaced by a '|'
        s/\|(.{140}).\^./D\1DHD/g    # A '.^.' below a '|' should be repalced with '|^|'
                                     # but we actually replace the '^' with 'H'
                                     # as a marker that this splitter has been hit
    t inner  # keep looping these substitutions until they no longer match anything

    s/D/|/g    # replace the intermediate "D" marker we used in the loop with '|'
    s/.*\n//   # get rid of the first line in the current pair
    H          # put the line in hold space
b outer        # and loop
