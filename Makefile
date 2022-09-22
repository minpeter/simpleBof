build : flag.txt bof.c
	gcc -fno-stack-protector -fcf-protection=none -m32 -o bof bof.c
	docker build -t bof .

run :
	docker run --rm -p 1337:1337 bof

clear :
	rm bof