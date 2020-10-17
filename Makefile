%.z64: %.asm
	bass -o $@ $<

all: *.z64

clean:
	rm *.z64