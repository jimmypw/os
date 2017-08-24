all:
	nasm -f bin -o boot.bin boot.asm
clean:
	rm -f boot.bin
