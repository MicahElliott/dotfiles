" ruby
"
"echo "Loading Micah's ruby plugin..."

source ~/.vim/syntax/comments.vim
source ~/gitcontainer/vim/Rainbow-Parenthesis/syntax/RainbowParenthsis.vim

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

iabbrev unless unless<CR>end<Esc>kA

let ruby_operators = 1
let ruby_space_errors = 1

set omnifunc=rubycomplete#Complete 
let g:rubycomplete_buffer_loading = 1 
let g:rubycomplete_classes_in_global = 1
" See rubycomplete.vim
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails_proactive = 1

" omnicompletion : words
"inoremap <leader>, <C-x><C-o>

" Omni
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
