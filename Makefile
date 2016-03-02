.SUFFIXES:
FC = gfortran

FCFLAGS = -g -fbounds-check -O2 #-I/usr/include

LDFLAGS =

EXECUTABLE = ffuck 

TEST_EXECUTABLE = stack_test

SOURCES =  stack.f08  ffuck.f08

OBJECTS = $(SOURCES:.f08=.o)

TEST_SOURCES = stack.f08 stack_test.f08

TEST_OBJECTS = $(TEST_SOURCES:.f08=.o)

all: $(SOURCES) $(EXECUTABLE)

test: $(TEST_SOURCES) $(TEST_EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@

$(TEST_EXECUTABLE): $(TEST_OBJECTS)
	$(FC) $(LDFLAGS) $(TEST_OBJECTS) -o $@

clean:
	rm -f *.o *.mod *.MOD ffuck

%.o: %.f08
	$(FC) $(FCFLAGS) $< -c -o $@
