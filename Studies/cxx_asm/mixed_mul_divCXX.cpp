// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>



// todo write these in assembly
// (a + b + c) * (d + e + f)
extern "C" int64_t signed_mul(int8_t a, int16_t b, int32_t c, int16_t d, int64_t e, int8_t f);
// (a + b + c) / (d + e + f)
extern "C" int unsigned_div(uint8_t a, uint16_t b, uint32_t c, uint16_t d, uint64_t e, uint8_t f, uint64_t * quo, uint64_t * rem);

int main()
{
	uint64_t quo{}; uint64_t rem{};

	int64_t res = unsigned_div(4, 26, 114, 213, 2, 21, &quo, &rem);

	std::cout << res << std::endl;
	std::cout << quo << std::endl;
	std::cout << rem << std::endl;
}
