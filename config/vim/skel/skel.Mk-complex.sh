" skel.mk.sh

" print file info at top
1delete
read !pwd
3
pu %
1
join! 4

/^cpps
mark c
read !ls *.cpp 2> /dev/null
"
/^cs
mark d
'c,'d-1 join
'd
read !ls *.c 2> /dev/null
" 
/^sources
mark s
'd,'s-1 join
's
read !ls *.c?? *.c *.h?? *.h 2> /dev/null
's
/^objects
mark o
'o
's,'o-1 join

/# START
"24
read !g++ -MM *.cpp *.c *.C *.cc *.cxx 2> /dev/null
