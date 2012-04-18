0pu %
1s/\(.*\).h/\1
ya a
4
pu %
4
join
join
5
read !date +"\%Y\%m\%d"
5
join
10
pu a
10
join
join
11
pu a
11
join
join
20
put a
20
join
1,2d
8,9s/ //g
"6,7s/\(.*\)_\(.*\)_\(.*\)/\1 _\2_\3/
8,9s/\*/ /
5
15 mark s
18 mark c
29 mark i
append
//		- 
