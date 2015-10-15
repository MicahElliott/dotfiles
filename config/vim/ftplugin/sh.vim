" sh.vim

"source ~/.vim/ftplugin/defaults.vim

"echo "in mde's sh.vim"
"sleep 2

" Mimic previous line
set autoindent

" Convery literal <Tab>s into spaces according to `shiftwidth'
set expandtab

" Show found string as it's being typed
set incsearch

" Wrap long lines according to `breakat' -- do not insert <EOL>s
"   Only affects the way the file is displayed
set nolinebreak

" How many spaces for a `>>' or `<<'
set shiftwidth=2

" Too smart for text
""set nosmartindent
""set nosmarttab

" How many spaces for a <Tab>
set tabstop=2

" Insert <EOL> when reaching this column
"set textwidth=0

" Display long lines wrapped
set wrap

" Similar to `textwidth' but use it instead (measured from right border)
set wrapmargin=0

set nospell

"UniCycleOff

let b:commentary_format = '#%s'

" Useless.
let b:is_bash = 1
