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


// type can only be 1 or zero
// 1 = float, 0 = int
extern "C" bool avx_packed_convert_fp(const XMMValue & first, XMMValue & second, unsigned int type);

// Homework

int main()
{
	__declspec(align(16)) XMMValue x;
	__declspec(align(16)) XMMValue y;


	x.xmm_float[0] = 5.1673f;
	x.xmm_float[1] = 4.3753f;
	x.xmm_float[2] = 72.9821f;
	x.xmm_float[3] = 54.5629f;

	y.xmm_float[0] = -54.7473f;
	y.xmm_float[1] = 4.3753f;
	y.xmm_float[2] = -0.425f;
	y.xmm_float[3] = 6.8525f;


	avx_packed_convert_fp(x, y, 0);

	for (size_t i = 0; i < 4; i++)
	{
		std::cout << y.xmm_int[i] << ", ";
	}
}
 