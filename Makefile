CC = gcc
AR = ar 
OBJECTS_MAIN = main.o 
OBJECTS_BASIC = basicMath.o 
OBJECTS_POWER = power.o 
FLAGS = -Wall -g 

all: mymaths mymathd maind mains

maind: $(OBJECTS_MAIN)
	$(CC) $(FLAGS) -o maind $(OBJECTS_MAIN) ./libmyMath.so 
mains: $(OBJECTS_MAIN) libmyMath.a 
	$(CC) $(FLAGS) -o mains $(OBJECTS_MAIN) libmyMath.a 
mymathd: libmyMath.so
libmyMath.so: $(OBJECTS_BASIC) $(OBJECTS_POWER)
	$(CC) -shared -o libmyMath.so $(OBJECTS_BASIC) $(OBJECTS_POWER)
mymaths: libmyMath.a
libmyMath.a: $(OBJECTS_BASIC) $(OBJECTS_POWER)
	$(AR) -rcs libmyMath.a $(OBJECTS_BASIC) $(OBJECTS_POWER)
basicMath.o: basicMath.c myMath.h
	$(CC) $(FLAGS) -c basicMath.c
power.o: power.c myMath.h
	$(CC) $(FLAGS) -c power.c
main.o: main.c myMath.h
	$(CC) $(FLAGS) -c main.c

.PHONY: clean all

clean:
	rm -f *.o *.a *.so mains maind


