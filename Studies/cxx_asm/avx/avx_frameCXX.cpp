// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

using namespace std;

extern "C" int64_t add_all_frame(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h);

// Homework

int main()
{
	int8_t a = 255, e = -35;
	int16_t b = -1137, f = 861;
	int32_t c = 434, g = -408;
	int64_t d = 4022, h = -7278;
	int64_t sum = add_all_frame(a, b, c, d, e, f, g, h);

	std::cout << sum << std::endl;
}
 