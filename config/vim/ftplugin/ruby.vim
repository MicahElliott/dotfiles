" ruby
"
"echo "Loading Micah's ruby plugin..."
"sleep 1

source ~/.vim/ftplugin/defaults.vim

" These don't quite work; simple full words get used often in comments.
"iabbrev def def<CR>end<Esc>kA
"iabbrev if if<CR>end<Esc>kA
"iabbrev for for<CR>end<Esc>kA
"iabbrev class class<CR>end<Esc>kA
"iabbrev module module<CR>end<Esc>kA
"iabbrev case case<CR>end<Esc>kA

"iabbrev unless unless<CR>end<Esc>kA

let ruby_operators = 1
let ruby_space_errors = 1

" Seealso: ~/.vim/plugin/mdeneo.vim
"set omnifunc=rubycomplete#Complete
"let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"" See rubycomplete.vim
"let g:rubycomplete_rails = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails_proactive = 1

" omnicompletion : words
"inoremap <leader>, <C-x><C-o>

" Omni
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Ruby rcodecomplete
" http://vootey.wordpress.com/2010/03/28/ruby-code-completion-with-vim/
" fri is a pain to install (if possible)
let g:rct_completion_use_fri = 0  " not really working

" Rails (MVCh)
" There are several more of these available; see rails.txt.
nmap <Leader>m :Rmodel<CR>
nmap <Leader>v :Rview<CR>
nmap <Leader>c :Rcontroller<CR>
nmap <Leader>h :Rhelper<CR>
nmap <Leader>s :Rspec<CR>
nmap <Leader>j :Rjavascript<CR>
