// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>



// todo write these in assembly

extern "C" int32_t signed_min(int32_t a, int32_t b, int32_t c);

extern "C" uint32_t unsigned_max(uint32_t a, uint32_t b);

int main()
{
	int32_t var = 12; int32_t var1 = 3; int32_t var2 = 64;

	int32_t res = signed_min(var, var1, var2);

	uint32_t uvar = 111; uint32_t uvar1 = 45;

	uint32_t res1 = unsigned_max(uvar, uvar1);

	std::cout << res << std::endl;
	std::cout << res1 << std::endl;

}
