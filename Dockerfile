FROM ubuntu:20.04

RUN apt-get update && apt-get install socat -y

WORKDIR /app

COPY bof .
COPY flag.txt .

RUN chmod +x ./bof

ENV PORT 1337

CMD socat -T60 -dd -v -v TCP-LISTEN:$PORT,reuseaddr,fork EXEC:./bof,pty,stderr,setsid,sigint,sane