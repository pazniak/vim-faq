# vim-faq

Still not using VIM as your main IDE? Read this page!

# Table of contents

## Vim and git

First of all you definitely need to give a try to [fugitive.vim by Tim Pope](https://github.com/tpope/vim-fugitive).

+ [Vim as 'git diff' and 'git show' tool](#vim-as-git-diff-and-git-show-tool)

## Links

First of all you might to give a chance to these resources dedicated to VIM. It's always a good idea to have them at hand.

+ http://vimawesome.com/
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
