" text ftplugin

" Mimic previous line
set autoindent

set ignorecase

" Join lines with only one space.
set nojoinspaces

" Wrap long lines according to `breakat' -- do not insert <EOL>s
"   Only affects the way the file is displayed
set nolinebreak

" How many spaces for a `>>' or `<<'
set shiftwidth=4

" How many spaces for a <Tab>
set tabstop=4

" Display long lines wrapped
set wrap

" Similar to `textwidth' but use it instead (measured from right border)
set wrapmargin=0

set textwidth=80

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
