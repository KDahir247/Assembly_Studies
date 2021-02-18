#include <stdio.h>
#include <stdlib.h>

#define BUFFERSIZE 512

int GetNumber()
{
	int val = 0;

	do
	{
		char buff[BUFFERSIZE];
		fgets(buff, BUFFERSIZE, stdin);

		val = atoi(buff);
	}
	while (val <= 0 || val > 10); // input value greater then 10 will cause an overflow for dword (int)

	printf("You have entered %i\n", val);
	
	return val;
}