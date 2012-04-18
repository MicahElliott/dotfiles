CC =
CXX =
INTEL_CFLAGS =
GCC_CFLAGS =
CFLAGS =
ALL_CFLAGS = $(INTEL_CFLAGS) $(GCC_FLAGS) $(CFLAGS)
LDFLAGS =

sources =
cobjects = $(sources:.c=.o)
cppobjects = $(sources:.cpp=.o)
objects := $(cobjects) $(cppobjects)

prog : $(objects)
	@ echo $(objects) DELETE THIS LINE
	$(CC) $(ALL_CFLAGS) $(LDFLAGS) -o $@ $^

%.o : %.cpp
	@ echo $(objects) DELETE THIS LINE
	$(CXX) -c $(ALL_CFLAGS) -o $@ $<

%.o : %.c
	@ echo $(objects) DELETE THIS LINE
	$(CC) -c $(ALL_CFLAGS) -o $@ $<

clean :
	@ echo "Cleaning up after ${CC}..."
	- $(RM) $(objects) prog core
