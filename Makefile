%.z64: %.asm
	bass $<
	chksum64 $@

all: *.z64

clean:
	rm *.z64