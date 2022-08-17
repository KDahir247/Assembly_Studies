// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
// todo write these in assembly

extern "C" int CalcArraySum(const int* x, unsigned int n);

int main()
{
	int x[]{ 1, 3, 12, 45, 34, 50, 12 };
	unsigned int n = 7;

	int res = CalcArraySum(x, n);

	std::cout << res << std::endl;
}
