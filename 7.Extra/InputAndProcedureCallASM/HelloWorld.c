#include <stdio.h>
#include <stdlib.h>

//Required by ASM File
void PrintResult( char const* operation, int val)
{
	printf("%s %i\n",operation, val);
}


int RetrieveInput()
{
	char c;
	int val;
	do
	{
		c = getchar();
		val = atoi(&c);
	}
	while (val == 0);

  return  val;
}


