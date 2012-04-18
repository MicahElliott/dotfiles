""" FILE: cpprc """""""""""""""""""""""""""""""""""""""""""""""

""" sets """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cindent					" replaces smartindent and autoindent
" set cinkeys=  			// not necessary
set cinoptions=g0,:0,=8,t0	" see :h cinoptions
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcrq		" see :h fo
" set comments=				// not necessary for now
set incsearch				" immediately show search result while typing
set exrc					" use local _exrc file
set nowrap					" don't word wrap
set ignorecase			" search case sensitive
set tabstop=2				" tab chars (ts)
set expandtab				" `tab's becomes spaces
set shiftwidth=2			"
"let c_comment_strings=1		" highlight strings inside C comments
set hlsearch				" search pattern highlighting
set syntax=cpp
"set foldmethod=indent

""" maps """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I use =-keys for my user-defines
map =- o72a-
map =/ o72a/
"map =- o75a-
"map =- o75a-
"map =- o75a-
"map =- o75a-
"map =- o75a-

" good candidates for map!...
"map! 
"map! 
"map! 
"map! 
"map! 

" up arrow in ins mode
"map!  ki
" down arrow in ins mode
"map!  ja
" left arrow in ins mode
"map!  lli
" right arrow in ins mode
"map!  ha

map =c 0i//j
map =k 0xxk
" REMEMBER: SH-K IS MAN-PAGE ACCESS ON KEYWORD
" wrap current line in C-style comments
"map K A*/0i/*j
" undo C-style comments
"map  0xx$xxj
" wrap current line in C++ comments
map  0i//j
" uncomment
"map  0xxk
" append when going to end of word
map e ea

""" abbreviations """"""""""""""""""""""""""""""""""""""""""""""""""""
"ab { {}kA
ab c< cout << << endl;BBhi
ab p< printf("\n" );T(a
ab sop System.out.println( );hhi

"ab #< #include <.h>hhi
"ab #in< #include <.h>hhi
"ab #in" #include ".h"hhi

ab fori for (int i = 0; i <; ++i) {}kf<a
ab forj for (int j = 0; j <; ++j) {}kf<a
"ab for{ for ( ) {}kt)i
"ab while{ while ( ) {}kt)i
"ab do{ do {} while ( )hi
"ab if{ if ( ) {}kt)i
"ab elseif{ else if ( ) {}kt)i
"ab else{ else {}ki	

"ab fori{ for( int i = 0; i <; ++i ) { x>>i}kkf<a
"ab fori( for( int i = 0; i <; ++i ) x>>ikf<a
"ab forj{ for( int j = 0; j <; ++j ) { x>>i}kkf<a
"ab forj( for( int j = 0; j <; ++j ) x>>ikf<a
"ab for{ for( ) { x>>i}kkt)i

"ab while{ while( ) { x>>i}kkt)i
"ab do{ do {} while ( )hi

"ab class{ class{	// PRIVATE MEMBERSxxipublic:// CTOR/DTORxxi	// MODIFIERSxxi	// CONSTANTSxxi};kkkkkkkkkA

"ab tclass{ template< >class

ab tclass{ template<typename>class{// private membersxxipublic:	// ctor/dtorxxi	// operator overloadsxxi	// core methodsxxi	// ext methodsxxiprivate:xxi};kkkkkkkkkkkkkkkkf>i

ab #i< #include <A
ab #i" #include".h"hhhi

ab switch( switch ( ) {case a:break;case b:break;case c:break;default:break;}kkkkkkkkkf(a
""" 

ab B{ #ifdef DEBUGfprintf(stderr,"DEBUG:");#endif // DEBUGk$hhi
ab V{ #ifdef VERBOSEprintf("VERBOSE:");#endif // VERBOSEk$hhi

""" at commands """"""""""""""""""""""""""""""""""""""""""""""""""""""
