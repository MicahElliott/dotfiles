source ~/.vim/ftplugin/text.vim

let b:docbk_type="xml"|setf docbk

set shiftwidth=2
set tabstop=2
set dictionary=~/.vim/dict/docbook.dict

" Maps =================================================================

" Used for wrapping inline previously typed text with tags
vmap \e va</emphasis>`<i<emphasis>l
vmap \f va</filename>`<i<filename>l
vmap \a va</application>`<i<application>l
vmap \p va</para>`<i<para>l
vmap \c va</command>`<i<command>l
vmap \k vi--`<a!--l

nmap \p I<para>}kA</para>{gq}
nmap \l O<programlisting>}O</programlisting>
nmap \c O<cmdsynopsis>}O</cmdsynopsis>
nmap \s O<screen>}O</screen>

" Used for new insertion of tags that wrap bodies of text
iabbrev p <para></para>kA

iabbrev e <example>	<title></title><programlisting></programlisting><BS><BS></example>----f<i

"iabbrev <TAB>

iabbrev s1 <section id=""><title></title><BS><BS></section>--f<i
"iabbrev s <section>	<title></title><BS><BS></section>--f<i

" vim:set syntax=vim:
