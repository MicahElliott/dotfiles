" ruby
"
"echo "Loading Micah's ruby plugin..."

source ~/.vim/syntax/comments.vim
source ~/.vim/bundle/Rainbow-Parenthesis/syntax/RainbowParenthsis.vim

set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set textwidth=72
set nospell

" These don't quite work; simple full words get used often in comments.
iabbrev def def<CR>end<Esc>kA
"iabbrev if if<CR>end<Esc>kA
"iabbrev for for<CR>end<Esc>kA
"iabbrev class class<CR>end<Esc>kA
"iabbrev module module<CR>end<Esc>kA
"iabbrev case case<CR>end<Esc>kA
"iabbrev unless unless<CR>end<Esc>kA
