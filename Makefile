%.z64: %.asm
	bass $<

all: *.z64

clean:
	rm *.z64