// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
// todo write these in assembly

extern "C" long long CalcArrayVals(long long* y, const int* x, int src, int dst, int8_t lenght);
//  y[i] = x[i] * src + dst
// sum += y[i]

// homework
int main()
{
	int src = 7; int dst = 9;
	const int8_t len = 7;
	int x[]{ 1, 3, 12, 45, 34, 50, 12 };
	long long y[len]{};

	int res = CalcArrayVals(y,x, src, dst, len);

	std::cout << y[0] << std::endl;
	std::cout << y[1] << std::endl;
	std::cout << y[2] << std::endl;
	std::cout << y[3] << std::endl;
	std::cout << y[4] << std::endl;
	std::cout << y[5] << std::endl;
	std::cout << y[6] << std::endl;


}
