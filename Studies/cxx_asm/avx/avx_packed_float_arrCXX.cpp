// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

using namespace std;

struct XMMValue {
public:
	union {
		float xmm_float[4]; // 32 * 4 == 128
		double xmm_double[2]; // 64 * 2 = 128
		int xmm_int[4];
	};
};


extern "C" bool avx_calc_sqrt(float* dst, const float* src, size_t len);
// Homework

int main()
{
	const size_t len = 22;
	__declspec(align(16)) float src[len];
	__declspec(align(16)) float dst[len];

	std::uniform_int_distribution<> dist{1, 1000};
	std::default_random_engine random_engine{ 25 };
	for (size_t i = 0; i < len; i++)
	{
		src[i] = (float)dist(random_engine);
	}

	avx_calc_sqrt(dst, src, len);


	for (size_t i = 0; i < len; i++)
	{
		std::cout << i << std::endl;
		std::cout << std::setw(6) << src[i] << "\t";
		std::cout  << dst[i] << std::endl;

		if ((i + 1) % 4 == 0) {
			std::cout << "------------------------------" << std::endl;
		}
	}

}
 