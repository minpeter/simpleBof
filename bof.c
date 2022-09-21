#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void func(int key){
	char target[32];
	printf("overflow me : ");
	gets(target);
	if(key == 0xbbafdadc){
		system("cat ./flag.txt");
	}
	else{
		printf("em... YoU LoSeRRRR! oK?!?! You LOsE! HAhahahahA\n");
	}
}
int main(int argc, char* argv[]){
	func(0xdfadafba);
	return 0;
}