" text ftplugin

" Mimic previous line
set autoindent

set ignorecase

" For reStructuredText
set syntax=rest

" Convery literal <Tab>s into spaces according to `shiftwidth'
set expandtab

" Show found string as it's being typed
set incsearch

" Join lines with only one space.
set nojoinspaces

" Wrap long lines according to `breakat' -- do not insert <EOL>s
"   Only affects the way the file is displayed
set nolinebreak

" How many spaces for a `>>' or `<<'
set shiftwidth=4

" How many spaces for a <Tab>
set tabstop=4

" Too smart for text
set nosmartindent

" Too smart for text
set nosmarttab

" Insert <EOL> when reaching this column
"set textwidth=70

" Display long lines wrapped
set wrap

" Similar to `textwidth' but use it instead (measured from right border)
set wrapmargin=0

" Allos gq to see these as bullets.
set comments-=s1:/*,mb:*,ex:*/
set comments+=:..:+,fb:*

" Spell checking.
set spell

" Underline with `='
map U= o=60I=khljlD0

" Underline with `-'
map U- o-60I-khljlD0

" Underline with `~'
map U~ o~60I~khljlD0

" Underline with `''
map U' o'60I'khljlD0

" Overline with `_'
map U_ O_60I_jhlklDj0

" Codetags
"map <Leader>f :r !date +\%F<CR>O.. FIXME: . <MDE<Esc>JA><Esc>BBBi
"map <Leader>t :r !date +\%F<CR>O.. TODO: . <MDE<Esc>JA><Esc>BBBi
"map <Leader>b :r !date +\%F<CR>O.. BUG: . <MDE<Esc>JA><Esc>BBBi
"map <Leader>n :r !date +\%F<CR>O.. NOTE: . <MDE<Esc>JA><Esc>BBBi
"map <Leader>g :r !date +\%F<CR>O.. GLOSS: . <MDE<Esc>JA><Esc>BBBi

" Wiki Done/Deletion
"map <Leader>d 0WWi--(A)-- @DATE@ddG{P

"hi ExtraWhitespace ctermbg=9
"match ExtraWhitespace /\s\+$/

