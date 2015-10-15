" Markdown Filetype Plugin

source ~/.vim/ftplugin/text.vim

"echo "in micah's markdown" | sleep 1

set syntax=markdown
set shiftwidth=4
set tabstop=4
set textwidth=78
set noic

" http://stackoverflow.com/questions/3828606/vim-markdown-folding
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction

" Turning off folding for now.
"au BufEnter *.md setlocal foldexpr=MarkdownLevel()
"au BufEnter *.md setlocal foldmethod=expr
