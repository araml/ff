.SUFFIXES:
FC = gfortran
FCFLAGS = -g -fbounds-check -O2 
LDFLAGS =

EXECUTABLE = ffuck 
TEST_EXECUTABLE = stack_test

OBJECTS = stack.o utility.o ffuck.o 
TEST_OBJECTS = stack.o stack_test.o

#delete intermediate files
.INTERMEDIATE: $(OBJECTS) $(TEST_OBJECTS) 

all: $(EXECUTABLE) 

test: $(TEST_EXECUTABLE) 

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@

$(TEST_EXECUTABLE): $(TEST_OBJECTS)
	$(FC) $(LDFLAGS) $(TEST_OBJECTS) -o $@

clean:
	rm -f *.o *.mod *.MOD ffuck stack_test

%.o: %.f08
	$(FC) $(FCFLAGS) $< -c -o $@

