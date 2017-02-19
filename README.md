# vim-faq

Still not using VIM as your main IDE? Read this page!

# Table of contents

## Everyday vim

 + Mouse
 + Select with mouse, --(visual)-- , copy and paste with y p yy [p ]p P
 + Undo/redo with u and Ctrl+R, backup and swap files
 + Auto-saving
 + Let vim hint you with :set wildmenu
 + Spell checking with :set spell and z=
 + Building projects and error messages with :set makeprg and :cw, :cc, :cn and @:
 + Building on external host, virtual machine, from Windows on Linux
 + Searching everywhere and jumping to locations with :lvim, :lwin, :ll, :lne and @:
 + Searching current buffer with / /\v and n N
 + Searching current line with f and ;
 + Tabs to hold several views with :tabn, :tabc and gt gT for cycling
 + Windows to create views with :new :vnew :q :split :vsplit :resize ZZ ZQ
 + Buffers for editing multiple files with :ls :e :b :bd :bn :bp Ctrl-^ Ctrl-o Ctrl-i
 + Run multiple VIM instances and switch between them with Ctrl-z and bash's fg and jobs
 + View project files vith NERDTreeView and NERDTreeAllTabs
 + Highlight a word with :let @/="" and \<c-r\>\<c-w\>; use :noh to switch off
 + Highlight whatever you want to read logs comfortably with :match and :matchgroup
 + Get rid of trailing spaces with :call TrimWhitespace() and autocmd!
 + Paste formatted text with :set paste
 + Use :set list to show the characters that are normally not shown: space, linefeed, tab
 + Browse source with gg G gf gd gD # * g# g\* / n N
 + Browse source with Ctags Ctrl-[ Ctrl-] :tn :ts :tp Ctrl-Shift-]
 + Browse source with Cscope and CCTree
 + Position current line on top with zt, in the center with zz, bottom zb
 + Read long code easier with code folding: --VISUAL-- zf, zo, zc
 + Jump between H and CPP files with a.vim
 
## Refactoring
 + Rename in all buffers with :bufdo and :s with flags ge
 + Rename in a single block with Shift-v and :'<,'>s with flags gc
 + Move pieces of code with --VISUAL-- and :m
 + Extract a function with --VISUAL-- "fc and "fp
 
## Formatting
 + Comment // with Ctrl-v and Shift+i
 + Uncomment // with Ctrl-v x or X
 + Change indentation with --VISUAL--  > and .
 + Change indentation of single line with >> << and .

## Vim and git

First of all you definitely need to give a try to [fugitive.vim by Tim Pope](https://github.com/tpope/vim-fugitive).

+ [Vim as 'git diff' and 'git show' tool](#vim-as-git-diff-and-git-show-tool)

## Coding assistance

First of all try search the needed feature at [vimawesome][1]

+ [Wrap string literal while typing in insert mode](#wrap-string-literal-while-typing-in-insert-mode)

## Links

First of all you might to give a chance to these resources dedicated to VIM. It's always a good idea to have them at hand.

+ [http://vimawesome.com/][1]
+ http://learnvimscriptthehardway.stevelosh.com/ 
+ http://vimcasts.org 
+ http://vim.wikia.com/wiki/Vim_Tips_Wiki 
+ and don't forget of the built-in vim tutorial "vimtutor". Just type in command line

```
vimtutor
```

or for GUI version of VIM

```
gvimtutor
```

To learn more about different ways of how to run vim tutor 

```
vim -c 'help tutor | only'
```

## Vim as 'git diff' and 'git show' tool
### git diff

```
git config --global diff.tool vimdiff
git config --global difftool.prompt false 
git config --global alias.d difftool
```

`vimdiff` is simply vim with -d: `vim -d <file> <file>`

Now command `git d` will show you what `git diff` does, except it shows it in vimdiff.

### git show

As for `git show`, there's no direct way to make it work with vimdiff.
On the other hand you can still make a hack and use an alias like

```
git config --global alias.s difftool\ HEAD^\ HEAD
```

Now just give it a try `git s`! To quit use `:qa` or `:qa!` to discard the changes you've made.

It's simply a shorthand for

```
git difftool HEAD^ HEAD
```

More generic alias should accept <revision> as an argument. For details see [this](http://jondavidjohn.com/git-aliases-parameters/).

```
git config --global alias.s '!f() { rev=${1-HEAD}; git difftool $rev^ $rev; }; f'
```

## Wrap string literal while typing in insert mode
Some IDE allow you to type multiline string literals without bothering you with how to break the literal enclosed in quotes into multiple lines, preserving quotes. Some IDE even fix the indentation when wrapping the literal. I just suggest you a small script, not impecable, yet useful and powerful.

Note: ^M means what `<cr>` produces literally. So to paste it into your script, use `<c-v><cr>`. If you just copy-paste the text from the box below, it won't work. You need to replace ^M with `<c-v><cr>` by hand.
```vim
"BUG: if the cursor is after closing " and it's the end of current line right 
"     under the cursor ($), the mapping works as if the cursor was inside the
"     double quotes.
"     However, from the second glance, it's even helpful.
"
"BUG: this breaks down existing automatic indentation
"     so you'd better use some mapping to toggle this feature on/off when
"     needed or use some kind of <s-cr> key instead of <cr>.
function! WrapQuotes()

    if search('"','bn',line(".")) != 0 &&
    \  search('"','cn',line(".")) != 0
        "Want beautiful indentation? " will appear on the next
        "line right at the same column as opening " on current line.
        let [lnum, col] = searchpos('"', 'bn', line("."))
        exec "normal! i\"^M"
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
        exec "normal! a^M"
    endif
endfunction
inoremap <s-cr> <c-o>:call WrapQuotes()<cr>
```


[1]: http://vimawesome.com/
