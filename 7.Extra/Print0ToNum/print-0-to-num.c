#include <stdio.h>
#include <stdlib.h>

#define BUFFERSIZE 512

void dummy()
{
	printf("");
}

int ReceiveInput()
{
	int val = 0;

	char buff[BUFFERSIZE];
	fgets(buff, BUFFERSIZE, stdin);

	val = atoi(buff);

	return val;
	
}