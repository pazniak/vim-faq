"Wrap quotes
"BUG: if the cursor is after closing " and it's the end of current line right 
"     under the cursor ($), the mapping works as if the cursor was inside the
"     double quotes.
"     However, from the second glance, it's even helpful.
"
"BUG: this breaks down existing automatic indentation
"     so you'd better use some mapping to toggle this feature on/off when
"     needed or use some kind of <s-cr> key instead of <cr>.
"
"BUG: if you also use some auto-pair plugin, the behavior of this script
"     will be messed up. An extra quote will appear so you'll need to delete
"     it by hand.
function! WrapQuotes()

    if search('"','bn',line(".")) != 0 &&
    \  search('"','cn',line(".")) != 0
        "Want beautiful indentation? " will appear on the next
        "line right at the same column as opening " on current line.
        let [lnum, col] = searchpos('"', 'bn', line("."))
        exec "normal! i\""
        let ind = col - col(".") 
        if ind != 0
            exec "normal! " . ind . "i "
            exec "normal! a\""
            "l to move into quotes
            "x to compensate the bug with extra space
            exec "normal! lx" 
        else
            "already inside quotes
            exec "normal! a\""
        endif
    else
        exec "normal! a"
    endif
endfunction
inoremap <s-cr> <c-o>:call WrapQuotes()<cr>
