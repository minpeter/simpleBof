FROM ubuntu:20.04

RUN apt-get update && apt-get install socat build-essential gcc-multilib -y

WORKDIR /app

COPY bof.c ./bof.c
COPY flag.txt ./flag.txt

RUN gcc -fno-stack-protector -fcf-protection=none -m32 -o bof bof.c
RUN chmod +x ./bof

ENV PORT 1337

CMD socat -T60 -dd -v -v TCP-LISTEN:$PORT,reuseaddr,fork EXEC:./bof,pty,stderr,setsid,sigint,sane