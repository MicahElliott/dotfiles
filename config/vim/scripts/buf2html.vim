" buf2html.vim - generate HTML/XHTML+CSS from a Vim buffer
"      (using the current syntax highlighting colorscheme)
"
" *********************************************************************
" ** Now mutated (maintained) by: Soren Andersen [perlspinr]          *
" **                              (<somian08 ^AT^ gmail com>)         *
" ** with contribution by Christian Hujer                             *
" **                              (Christian.Hujer ^AT^ itcqis com)   *
" ** ---------------------------------------------------------------  *
" **  See for updates / latest version:   http://vim.sourceforge.net/ *
" *********************************************************************
" --------------------------------------------------------------------*
" Previous Credits (when named "2html.vim", as distributed with Vim): *
" Maintainer: Bram Moolenaar <Bram@vim.org>                           *
"       (modified by David Nečas (Yeti) <yeti@physics.muni.cz>)       *
" --------------------------------------------------------------------*

" Last modified: 18 Oct 2008 17:37:41 EDT
" Last edited on: highbottom
" Version: ('VIM Online' versioning scheme): 2.0b2
"     internal version: 2.0_beta2

" ---------------------------------------------------------------------
" Usage:  :[<various settings>] | source buf2html.vim
" Options:
"       The following global ("g:") variables can be used to configure
"        the script's output. 'b2h_use_css' should nearly always be
"        defined, for example in .vimrc: let b2h_use_css = 1.  Using
"        plain HTML could be helpful if only a snippet of the output
"        is needed for something.
"
"  * b2h_use_css       - use CSS instead of HTML tag attributes markup.
"  * b2h_use_inlstyle  - use CSS but only in style="..." attributes
"            inside HTML element tags XXX CURRENTLY UNIMPLEMENTED.
"  * b2h_output_xhtml  - try to output correct XHTML-1.1 instead of HTML.
"  * b2h_number_lines  - toggles output of line-numbering. Defaults to the buffer
"            setting currently in effect.
"  * b2h_meta_expires  - if this is true and VIM can find /bin/date on the system,
"            use a header meta-http-equiv line to set an expiry (so that browsers
"            or maybe proxy servers will request new document after that date).
"  * b2h_no_display_credit  - do NOT write an inconspicuous string at the bottom
"            of the page, like:
"      'code syntax highlighting by GVIM, using the "[color scheme name]" theme.'
"
"---- The following script-behavior controller vars are unlikely to be of
"     concern more than 'seldom to never':
"  * b2h_relaxed_sec  - write out the complete (fully-qualified) path to the
"            source file in a comment near the top of the HTML head section.
"            By default it no longer does this but merely writes the basename.
"-----------------------------------------------------------------------

" various and sundry script-scoped variables
let s:sourcefilepathname = substitute(expand("%:p"),'\\','/','g')
" Save the file basename + extension (the 'tail'):
let s:srcfile_bnsuff = expand('%:t')
" Save the filetype:
let s:source_ft = &filetype
" Work out the encoding:
if   &fileencoding != ""
	  let s:quoted_enc = "\"" . &fileencoding . "\""
	  let s:unquoted_e = &fileencoding
  elseif &encoding != ""
	  let s:quoted_enc = "\"" . &encoding . "\""
	  let s:unquoted_e = &encoding
endif

" Work out what to name the new buffer when created:
if s:srcfile_bnsuff == ""
  let s:synhl_HTMLfile = 'Untitled.html'
elseif  s:srcfile_bnsuff[-5:-1] =~ '\.html'
  let s:synhl_HTMLfile = substitute(s:srcfile_bnsuff
         \ , '\c\.HTML$', '_HTML_', '') .'.html'
else
  let s:synhl_HTMLfile = s:srcfile_bnsuff . '.html'
endif

" Work out what a suitable tmp directory might be:
let s:badfnchars = "\t\n'".' "*?[{`$\\%#|!<>'
let s:mytmpdir = ''
let s:dex = ( exists($TMP)      ?  '$TMP'
   \        : exists($TEMP)     ?  '$TEMP'
   \        : exists($TMPDIR)   ?  '$TMPDIR' : '')
if s:dex && isdirectory(s:dex)
    let s:mytmpdir = escape(expand(s:dex), s:badfnchars)
else
    let s:mytmpdir = '/tmp'
endi


" Options governing script operations.
let s:useCSS   = 0
let s:inlstyle = 0
if exists('g:b2h_use_css') && g:b2h_use_css
    let s:useCSS = 1
    if exists('g:b2h_use_inlstyle') && g:b2h_use_inlstyle
        let s:inlstyle = 1
    endif
endif

let s:use_XHTML = 0
" Setup what flavor of DTD we are doing.
if exists('g:b2h_output_xhtml') && g:b2h_output_xhtml
  let s:use_XHTML = 1
  let s:emptag_close = ' />'
 else
  let s:emptag_close = '>'
endif

" Number lines when explicitly requested or when `number' is set
if exists("g:b2h_number_lines")
    if g:b2h_number_lines | let s:numblines = 1
    else                  | let s:numblines = 0 |endif
else
    let s:numblines = &number
endif

" Added on 2008-08-27  - compute and record a sha1sum for this data stream
" Thanks to jamessan, godlygeek and others on #vim@freenode for their helpful
" discussion of the working-out of this code with me.
let s:perlsha1sum_noworkie = 0
function! s:GetSHA1( buffern )
  let b:fretvalu = ""
  let safename = escape(a:buffern, s:badfnchars)

  if (has('perl') && ! s:perlsha1sum_noworkie)

      function! s:SHA1_via_perlinterp(thatbuf)
       " Jump back to previous buffer.
          exec "normal \<C-W>p"
          let sep   = (&ff == 'dos' ? "\r\n" : (&ff == 'mac' ? "\r" : "\n")) 
          let bdata = join(getbufline('%', 1, '$'), sep)
          if &eol | let bdata .= sep | endif
          let sbno  = bufnr('')
       " Jump back to our output buffer.
          exec "normal \<C-W>p"
      perl <<ENDOFperl
      {
          use strict;
          my ($Eval_ok, $buff_to_digest, $buff_to_digest_num, $outer_f_farg, $bufferdata);

          eval 'require Digest::SHA1;' ;
          if ($@) {
              my $Ok;
              ($Ok, $outer_f_farg) = VIM::Eval('a:thatbuff');
	      VIM::Msg(
      'It looks like Digest::SHA1 is not installed. Cannot compute SHA1 checksum.', 'ErrorMsg');
              VIM::DoCommand( qq/let s:perlsha1sum_noworkie = 1/ );
              # call our Vim function over again
              goto DIS_IS_DONE;
          }

          ($Eval_ok, $bufferdata)          = VIM::Eval('bdata');

          if (0) {
              ($Eval_ok, $buff_to_digest_num)  = VIM::Eval('sbno');
              VIM::DoCommand( q/let l:nada = inputdialog('Perl diagnostics:
Buffer to operate on is buffer number /. $buff_to_digest_num .q/;
the buffer data has a length of /. length($bufferdata) .q/ bytes;
the version of Digest::SHA1 we have is /. Digest::SHA1->VERSION .q/; ')/ );
          }

          my $cs = Digest::SHA1::sha1_hex $bufferdata;
          VIM::DoCommand( qq/let b:fretvalu = '$cs'/ );
      }
          if (0) {
DIS_IS_DONE: {
              VIM::DoCommand( 'call s:GetSHA1('. $outer_f_farg .')' );  # untested so far XXX
             }
          }
ENDOFperl
      endfunc
      call s:SHA1_via_perlinterp(a:buffern)

  elseif executable("sha1sum") != 1
    return ''  " XXX BAIL OUT

  else

    let extn = 'sha1sum -t '

    let tmpfile = s:mytmpdir .'/'. safename .'~'
    exec ":w! " . tmpfile
    let sha1sum = system(extn . tmpfile)
    if ! strlen(sha1sum) <= 39 " checksum is 160-bits, 40 hex digit bytes, + filename etc.
      exec ":!rm ". tmpfile
      let parts = split( sha1sum , '[[:blank:]]')
      let b:fretvalu = parts[0]
    endif
  endif
  return b:fretvalu
endfu


" When not in gui we can only guess the colors.
if has("gui_running")
 let s:whatterm = "gui"
else
  let s:whatterm = "cterm"
  if &t_Co == 8
    let s:cterm_color0  = "#808080"
    let s:cterm_color1  = "#ff6060"
    let s:cterm_color2  = "#00ff00"
    let s:cterm_color3  = "#ffff00"
    let s:cterm_color4  = "#8080ff"
    let s:cterm_color5  = "#ff40ff"
    let s:cterm_color6  = "#00ffff"
    let s:cterm_color7  = "#ffffff"
  else
    let s:cterm_color0  = "#000000"
    let s:cterm_color1  = "#c00000"
    let s:cterm_color2  = "#008000"
    let s:cterm_color3  = "#804000"
    let s:cterm_color4  = "#0000c0"
    let s:cterm_color5  = "#c000c0"
    let s:cterm_color6  = "#008080"
    let s:cterm_color7  = "#c0c0c0"
    let s:cterm_color8  = "#808080"
    let s:cterm_color9  = "#ff6060"
    let s:cterm_color10 = "#00ff00"
    let s:cterm_color11 = "#ffff00"
    let s:cterm_color12 = "#8080ff"
    let s:cterm_color13 = "#ff40ff"
    let s:cterm_color14 = "#00ffff"
    let s:cterm_color15 = "#ffffff"
  endif
endif

" Return good color specification: in GUI no transformation is done, in
" terminal return RGB values of known colors and empty string on unknown
if s:whatterm == "gui"
  function! s:HtmlColor(color)
    return a:color
  endfun
else
  function! s:HtmlColor(color)
    if exists("s:cterm_color" . a:color)
      execute "return s:cterm_color" . a:color
    else
      return ""
    endif
  endfun
endif

" Added 2008-08-26 ---------------------------------------
function! s:BrightAverage(hexspec)
    let triplet = strpart(a:hexspec, 1)
    let bfact = 1.10
    let R = str2nr(triplet[0:1],16)
    let G = str2nr(triplet[2:3],16)
    let B = str2nr(triplet[4:5],16)
    if R + G + B == 0|let s:abitbrighter = '#403040'|return 0|endif
    if R == 0|let Rs = 2|endif
    if G == 0|let Gs = 2|endif
    if B == 0|let Bs = 2|endif
    let rv = printf( '%d', ( R + G + B ) / 3 )
    let factrRGB =
      \ [ printf('%02x', bfact * (R || Rs))
      \ , printf('%02x', bfact * (G || Gs))
      \ , printf('%02x', bfact * (B || Bs)) ]
    let s:abitbrighter = '#'.factrRGB[0].factrRGB[1].factrRGB[2]
    return rv
endfu
" --------------------------------------------------------

if ! s:useCSS
  " Return opening HTML tag for given highlight id
  function! s:HtmlOpening(id)
    let a = ""
    if synIDattr(a:id, "inverse")
      " For inverse, we always must set both colors (and exchange them)
      let x = s:HtmlColor(synIDattr(a:id, "fg#", s:whatterm))
      let a = a . '<span style="background-color: ' . ( x != "" ? x : s:fgc ) . '">'
      let x = s:HtmlColor(synIDattr(a:id, "bg#", s:whatterm))
      let a = a . '<font color="' . ( x != "" ? x : s:bgc ) . '">'
    else
      let x = s:HtmlColor(synIDattr(a:id, "bg#", s:whatterm))
      if (x != "" && x != s:bgc) " do not create a tag if the bgc is simply the document/default/normal bgc
	  let a = a . '<span style="background-color: ' . x . '">'
      endif
      let x = s:HtmlColor(synIDattr(a:id, "fg#", s:whatterm))
      if x != "" | let a = a . '<font color="' . x . '">' | endif
    endif
    if synIDattr(a:id, "bold") | let a = a . "<b>" | endif
    if synIDattr(a:id, "italic") | let a = a . "<i>" | endif
    if synIDattr(a:id, "underline") | let a = a . "<u>" | endif
    return a
  endfun

  " Return closing HTML tag for given highlight id
  function s:HtmlClosing(id)
    let a = ""
    if synIDattr(a:id, "underline")  | let a = a . "</u>" | endif
    if synIDattr(a:id, "italic")     | let a = a . "</i>" | endif
    if synIDattr(a:id, "bold")       | let a = a . "</b>" | endif
    if synIDattr(a:id, "inverse")
      let a = a . '</font></span>'
    else
      let x = s:HtmlColor(synIDattr(a:id, "fg#", s:whatterm))
      if x != "" | let a = a . '</font>' | endif
      let x = s:HtmlColor(synIDattr(a:id, "bg#", s:whatterm))
      if ( x != "" && x != s:bgc ) | let a = a . '</span>' | endif
    endif
    return a
  endfun
endif

" Return CSS style describing given highlight id (can be empty)
function! s:CSS1(id)
    let a = ""
    if synIDattr(a:id, "inverse")
      " For inverse, we always must set both colors (and exchange them)
      let x = s:HtmlColor(synIDattr(a:id, "bg#", s:whatterm))
      let a = a . "color: " . ( x != "" ? x : s:bgc ) . "; "
      let x = s:HtmlColor(synIDattr(a:id, "fg#", s:whatterm))
      let a = a . "background-color: " . ( x != "" ? x : s:fgc ) . "; "
    else
      let x = s:HtmlColor(synIDattr(a:id, "fg#", s:whatterm))
      if x != "" | let a = a . "color: " . x . "; " | endif
      let x = s:HtmlColor(synIDattr(a:id, "bg#", s:whatterm))
      if x != "" | let a = a . "background-color: " . x . "; " | endif
    endif
    if synIDattr(a:id, "bold")        | let a = a . "font-weight: bold;"          | endif
    if synIDattr(a:id, "italic")      | let a = a . "font-style: italic;"         | endif
    if synIDattr(a:id, "underline")   | let a = a . "text-decoration: underline;" | endif
    return a
endfun

" Set some options to make it work faster.
" Expand tabs in original buffer to get 'tabstop' correctly used.
" Don't report changes for :substitute, there will be many of them.
let s:old_title    = &title
let s:old_icon     = &icon
let s:old_et       = &l:et
let s:old_report   = &report
set notitle noicon
setlocal et
set report=1000000

" >>>> NEW BUFFER / WINDOW CREATED HERE -- % NOW MEANS SOMETHING ELSE!  <<<<
exec 'new '.s:mytmpdir .'/'. s:synhl_HTMLfile
set modifiable
%d
let s:old_paste = &paste
set paste

" Begin creating the new document.
"--------------------------------
" The XML declaration. There are problems with using this (IE 6). It is only
" a real advantage when we need to edit a file as XML.  Let's not do it.
" if (s:use_XHTML) " let b2h_output_xhtml be true
"   exe "normal a<?xml version=\"1.0\" encoding=" . s:quoted_enc ." ?>\n\e"
" If we did this then we'd need to also do the head tag similar to folllowing:
"   <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
" endif

" The DTD declaration.
if (s:use_XHTML)
  exe "normal a<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n"
             \."   \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
             \."<html xml:lang=\"en\" lang=\"en\">\n\e"
  
 else " not using XHTML
  exe "normal a<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n"
	     \."          \"http://www.w3.org/TR/html4/strict.dtd\">\n\e"
endif

" HTML head.  CSS to be filled at the end.
exe "normal a\n<head>\n\e"

" The http-equiv meta + charset tag.
if (s:use_XHTML)
  " trouble: if we are serving as XML, *The meta charset declaration should
  "        always be used for HTML or XHTML served as HTML. It should never
  "        be used for XHTML served as XML.*

  exe "normal a  <meta http-equiv=\"Content-Type\" content=\"text/html;charset="
               \ . s:unquoted_e . "\"" . s:emptag_close . "\n\e"

 else " HTML should also have encoding infomation and content type according to W3C.

  exe "normal a  <meta http-equiv=\"Content-Type\" content=\"text/html;charset="
               \ . s:unquoted_e . "\"" . s:emptag_close . "\n\e"
endif


" Record generator application software in a meta tag.
exe "normal a  <meta name=\"Generator\"\n        "
               \. "content=\"buffer2html.vim - run with colorscheme '"
               \.  g:colors_name ."', on Vim/"
               \.  version/100 .".". version %100 . "\"" . s:emptag_close . "\n\e"


" Also create a meta tag for timestamping the generation moment
let s:TiSt = system('date -u --rfc-3339=seconds')
let s:TiSt = strpart(s:TiSt, 0, strlen(s:TiSt) - 1)
exe "normal a  <meta name=\"Generated-On\" content=\"". s:TiSt ."\">\n\e"

" Set the expiry date in the future based on a variable existing to tell how
" far forward to set it. But it's considered FAR BETTER to do this on the server):
if ( exists('b2h_meta_expires') && executable('/bin/date') )
 let s:futurexpire = substitute(system('date -uR -d ' . "'+" . b2h_meta_expires ." day'")
\ ,"\n",'','')
 if strlen(s:futurexpire)
   exe "normal a  <meta Http-Equiv=" . '"expires" content="'
           \. s:futurexpire . "\"" . s:emptag_close . "\n\e"
 endif
endif

exe "normal a  <title>"
     \. substitute(expand("%:t"),'\.html$','','') . "</title>\n\e"

" WARNING. The following addition does what might be considered a
" SECURITY CONCERN by some people (violation of 'security via
" obscurity' principle): it might write a fully-qualified (absolute)
" file path of the source file to a comment in the HTML.  Anyone
" with enough interest to look at the source of the HTML file would
" be able to see this. DISABLE THIS FEATURE if this is unacceptable
" by making sure that global var 'g:b2h_relaxed_sec' is not defined.

if exists('g:b2h_relaxed_sec')
  exe "normal a<!--   absolute location: " . s:sourcefilepathname . "   -->\n\e"
else
  exe "normal a<!--   source filename: "   . s:srcfile_bnsuff . "   -->\n\e"
end

" IF we can get a sha1 checksum then write a comment line here:
let s:sourceSHA1cs = s:GetSHA1(s:srcfile_bnsuff)
if strlen( s:sourceSHA1cs ) > 0
    exe "normal a<!-- source sha1 checksum: ". s:sourceSHA1cs ." -->\n\e"
endi

" Start the CSS STYLE defs block.
if s:useCSS && ! s:inlstyle
   exe "normal a<style type=\"text/css\">\n<!--\n\e"

 " Only do the following if b2h_no_display_credit is not defined.
   if ! exists('g:b2h_no_display_credit')
	 exe "normal a  .credits { font: smaller \"avant-garde\", \"verdana\", "
                 \."\n                           \"helvetica\", \"arial\", sans-serif;"
                 \."\n             padding: 0.4ex 2ex; text-align : right;"
                 \."\n             background-color: #3A1E24;    color: #CCCC99; }\n\e"
   endif
  let s:stylesstart_at = line(".")
" Close the CSS style definitions block.
  exe "normal a\n -->\n</style>\n\e"
endif

" Now that we have our HEAD on straight... NOTE do NOT do a NEWLINE after
" <pre> or will get a silly empty line at top of output HTML.
exe "normal a</head>\n\n\n<body>\n\n<div id=\"main_code\"><pre>\e"

" Jump back to previous buffer.
exe "normal \<C-W>p"

" List of all id's
let s:idlist = ","

" Find the background and foreground colors.
let s:fgc = s:HtmlColor(synIDattr(highlightID("Normal"), "fg#", s:whatterm))
let s:bgc = s:HtmlColor(synIDattr(highlightID("Normal"), "bg#", s:whatterm))
if s:fgc == ""
  let s:fgc = ( &background == "dark" ? "#ffffff" : "#000000" )
endif
if s:bgc == ""
  let s:bgc = ( &background == "dark" ? "#000000" : "#ffffff" )
endif

" Have a way to represent a (invisible) TAB char for makefiles:
let s:TAB_Repr = '<span class="tabchar">|-TAB-\&gt;|</span>'


" Loop over all lines in the original text
let s:end = line("$")
let s:lnum = 1
while s:lnum <= s:end
  " Get the current line, with tabs expanded to spaces when needed
  " FIXME: What if it changes syntax highlighting?
  let s:line = getline(s:lnum)
  if stridx(s:line, "\t") >= 0
    if s:source_ft != 'make'
      exe s:lnum . "retab!"
      let s:did_retab = 1
      let s:line = getline(s:lnum)
    endif
  else
      let s:did_retab = 0
  endif

  let s:len = strlen(s:line)
  let s:new = ""
  if s:numblines
    let s:new = '<span class="lnr">'
     \ . strpart('        ', 0, strlen(line("$")) - strlen(s:lnum)) . s:lnum . '</span>  '
  endif

  " Loop over each character in the line
  let s:col = 1
  while s:col <= s:len
      let s:startcol = s:col " The start column for processing text
      let s:id = synID(s:lnum, s:col, 1)
      let s:col = s:col + 1

 " Speed loop (it's small - that's the trick)
   " Go along till we find a change in synID
      while s:col <= s:len && s:id == synID(s:lnum, s:col, 1) | let s:col = s:col + 1 | endwhi
      let s:backedup = s:col
      if ' ' == matchstr(getline(s:lnum), '.\{' . -1 + s:backedup . '}\zs.')
          while ' ' == matchstr(getline(s:lnum), '.\{' . s:backedup . '}\zs.')|let s:backedup -= 1|endwhi
      endi

      let nonblank = ( s:backedup < s:col ? s:backedup : s:col )

   " Output the text with the same synID, with class set to c{s:id}
      let s:id = synIDtrans(s:id)
      let s:new = s:new . '<span class="c' . s:id . '">' . 
	  \ substitute(substitute(substitute(substitute(substitute(substitute(strpart(s:line, s:startcol - 1,
	  \ nonblank - s:startcol), '&', '\&amp;', 'g'), '<', '\&lt;', 'g'), '>', '\&gt;', 'g'), '"',
	  \ '\&quot;', 'g'), "\x0c", '<hr class="page-break">', 'g'), "\x09", s:TAB_Repr, 'g')
	  \ . '</span>'

      while s:backedup < s:col
	  let s:new = s:new . ' '
	  let s:backedup += 1
      endwhi
   " Add the class to class list if it's not there yet
      if stridx(s:idlist, "," . s:id . ",") == -1
	  let s:idlist = s:idlist . s:id . ","
      endif
      if s:col > s:len | break | endif
  endwhile

  if s:did_retab | undo | endif
  exe "normal \<C-W>pa" . strtrans(s:new) . "\n\e\<C-W>p"
  let s:lnum = s:lnum + 1
  +
endwhile



" Finish with the last lines, write credit.
exe "normal \<C-W>pa</pre>\n</div>\e"
  if !exists('g:b2h_no_display_credit')
	exe 'normal a<div class="credits">'
  \.        "\ncode syntax highlighting by "
  \.        "<a name=vimhome href=\"http://vim.sourceforge.net/\">GVIM</a>,\n"
  \.        "using the &quot;" .g:colors_name
  \.        "&quot; theme. &nbsp;</div>\n\e"
  endif
exe "normal a\n</body>\n</html>\e"

" Now, when we finally know which, we define the colors and styles.
" First return to the STYLE block in document HEAD.
if s:useCSS
  call cursor(s:stylesstart_at,0)
"  exe "normal a\n/* DEFINITION START */\n\e"
endif

" Normal/global attributes:
" For Netscape 4, set <body> attributes too, though, strictly speaking, it's
" incorrect.
if s:useCSS

" Added 2008-08-26
  if s:BrightAverage( s:bgc ) < 15
      let s:tabc_co = s:abitbrighter " set as a side-effect of calling s:BrightAverage
  else
      let s:tabc_co = '#040106'
  endif

  if ! s:inlstyle 
   " let s:ourfontstyle = WhatGuiFonts()
    let s:ourfontstyle = substitute(getfontname(), '\(.\+\) \(\d\+$\)', '\2pt "\1"', '')

    exec "normal a\n  body { margin: -1.7ex 0 0 0;"
              \. "\n                    color: " . s:fgc .";"
              \. "\n         background-color: " . s:bgc ."; }\n\e"

    exec "normal a\n   pre {          color: "   . s:fgc . ";"
              \. "\n       background-color: "   . s:bgc . ";"
              \. "\n                   font: "   . s:ourfontstyle . ", monospace;"
              \. "\n                padding: 0 6 0 0; }\n\e"
    exec "normal a\n  .lnr { padding: 0 3px; " . s:CSS1(highlightID("LineNr")) . " }\n\e"
    exec "normal a\n  #main_code { margin: -9 3 0 1; }\n\e"
    exec "normal a\n  .c0  { color: inherit; background-color: inherit; }\n\e"

    if s:source_ft == 'make'
      exec "normal a\n  .tabchar { color : " . s:tabc_co . "; background-color: ". s:bgc .";"
                 \."\n             font-weight: 400;  font-style: oblique; }\n\e"
    endif

  " Re-mark a spot to resume adding CSS declarations (definitions?).
    let s:stylesstart_at = line(".")

  endif
   " TODO : write body and pre using inline CSS

 else " get the HTML tag attributes for line numbers

   if s:numblines
       let s:LineNo_to =  s:HtmlOpening(highlightID("LineNr"))
       let s:LineNo_tc =  s:HtmlClosing(highlightID("LineNr"))
   " and make substitutions globally
       exec '%s+<span class="lnr">\([^<]*\)</span>+' . s:LineNo_to .'\1'. s:LineNo_tc . '+g'
   endif

   exec '%s:<body\( *[^>]*\)>:<body \1 ' . 'bgcolor="' . s:bgc . '" text="' . s:fgc . '">'

endif


if s:useCSS && ! s:inlstyle
 " Return to the marked spot for the STYLE block in document HEAD.
  call cursor(s:stylesstart_at,0)
endif


" Gather attributes for all other classes
let s:idlist = strpart(s:idlist, 1)
while s:idlist != ""
    let s:attr     = ""
    let s:col      = stridx(s:idlist, ",")
    let s:id       = strpart(s:idlist, 0, s:col)
    let s:id2name  = synIDattr(s:id, "name")
    let s:idlist   = strpart(s:idlist, s:col + 1)
    let s:attr     = s:CSS1(s:id)
    " [If the class has some attributes, export the style, otherwise DELETE all
    " its occurences to make the HTML shorter.] <-- NOPE, for some reason this is
    " malfunctioning now, have to comment it out.
    if strlen(s:attr) != 0

        if s:useCSS && ! s:inlstyle
	    let s:padme = ""
	    if strlen(s:id)<2 | let s:padme = " " | endif
	    call cursor(s:stylesstart_at,0)
	  " note about "normal A": "A" goes to end of current line and
	  " starts insert mode.
	    exec "normal A\n  .c" . s:id . s:padme " { " . s:attr . "/* \"". s:id2name ."\" */}"
	    let s:padme = ""
        else
	    let s:Tag_attr_id_to = s:HtmlOpening(s:id)
	    let s:Tag_attr_id_tc = s:HtmlClosing(s:id)
	    exec '%s+<span class="c'. s:id .'">\([^<]*\)</span>+'. s:Tag_attr_id_to .'\1'. s:Tag_attr_id_tc .'+g'
	    let s:Tag_attr_id_to = ''
	    let s:Tag_attr_id_tc = ''
        endif

    else | if s:id == 0 |exec '%s+<span class="c0">\([^<]*\)</span>+\1+g'| endif
	" clean attribute-less syn id segments
      " exec '%s+<span class="c\d\+">\([^<]*\)</span>+\1+g'
    endif
endwhile

        "  s:HtmlClosing(s:id)

" Cleanup (we've already lost last user's pattern match highlighting)
%s:\s\+$::e
if has("extra_search") | nohlsearch | endif

" Restore old settings
let &report   = s:old_report
let &title    = s:old_title
let &icon     = s:old_icon
let &paste    = s:old_paste
exe "normal \<C-W>p"
let &l:et     = s:old_et
exe "normal \<C-W>p"

" Save a little bit of memory (Is this worth doing?)
unlet s:old_et s:old_paste s:old_icon s:old_report s:old_title
unlet s:TiSt s:whatterm s:idlist s:lnum s:end s:fgc s:bgc
unlet! s:col s:id s:attr s:len s:line s:new s:did_retab s:numblines
delfunc s:HtmlColor
delfunc s:CSS1
if ! s:useCSS
  delfunc s:HtmlOpening
  delfunc s:HtmlClosing
endif
unlet s:useCSS
