" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "" FILE: htocpp """"""""""""""""""""""""""""""""""""""""""""""
" "" VERSION: Alpha 1.0 -- not robust, but appears effective""""
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This ex script creates a .cpp implementation file from a
" given .h specification header file. 
" This file should be added to your personal bin directory
" (which is included in your path)
" Invoke by typing:
" 	:so htocpp
" 
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Features:
" .cpp file created will be titled analogously to the .h file
" i.e. my_file.h will produce my_file.cpp
" 
" .cpp file will contain commented c-style header which includes
" class name and private data members
" 
" All function prototypes will be prefixed with the necessary
" 'MyClass::' stamp
" 
" All default parameter value assignments will be removed
" 
" Any function prototypes that included their definitions in
" the .h file will not be included in the .cpp file
" 
" Braces will be added to all definitions
" 
" Keywords such as 'public:' and 'private:' will be removed
" 
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Requirements:
" The name of the header file must be declared (commented) 
" within the first two lines of the file. i.e. 
" // file.h -- file to do something
" 
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Limitations:
" Only one class may be declared
" Does not work for .c files (no classes in C, right?)
" Struct contents will not be moved to .cpp file
" No template support yet
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "" source """"""""""""""""""""""""""""""""""""""""""""""""""""

" go to first line
1

" find first declaration of 'class'
/^class 

" yank class title into buffer b
ya b

" copy all class info into buffer a
.;+2 , /};/-1 ya a		

" save file
w						

" get current file name and write it to next line with .cpp suffix and e! cmd
1,2g/.h/ s/\(.*\) \(.*\).h\(.*\)/e! \2.cpp/

" copy as command ( e! file.cpp )
ya d					

" execute buffer d without saving modifications to orig file
@d						

" clear contents of .cpp skeleton
1,$d

" put class title
pu b

" put contents from header into new cpp file
pu a					


" delete lines ending with ':' ( pubic: private: )
g/:$/d					

" remove all c++ style comments
g://: s:\(.*\)//\(.*\):\1:	

" remove all nested c++ style comments
g://: s:\(.*\)//\(.*\):\1:	

" remove default parameter values ( int value = 0 ) ==> (int value )
g/=[ [:alnum:]]/ s/\(.*\)=[ [:alnum:]]*\(.*\)/\1\2/

" delete header functs that were implemented in .h file
g/}[ 	]*$/d			

" delete all blank lines
g/^[ 	]*$/d 			

" comment all lines that are not function protos
g!;(; s;\(.*\);// \1; 	

" remove all tabs
%s/[ 	][ 	]*/ /g

" remove all opening whitespace
%s/^[ 	]*//			

" insert {, }, and newlines after every func proto
g!:^//: s:$:{}: 


" remove semicolons from commented lines
g:^//: s:;:		//:		

1s/\(.*\)/\1::/

" add a newline after first word of each proto
g/;/ s/ \(.*\)$/\1/

" join any lines to the prev line if ends in (
g/($/j					

1s/^\(.*\) \(.*\)/\2 

" get classname:: into buffer c and restore
1 ya c 					

" insert classname:: on all lines with ;
g/;/ -1pu c				

" insert newlines before first func implementation
1/::/ s/\(.*\)/ *\/\1/	

" remove semicolons from protos
g/;/ s/;//				

1s:^: * :				" comment out first line

1s/::/ Class Implementation * * private data:/

" start commented block
1s:\(.*\):/*\1:		

" substitute comment type
g://$: s://\(.*\)//: *\1:	


"" EOF """""""""""""""""""""""""""""""""""""""""""""""""""""""
