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


extern "C" void avx_compare_f32(const XMMValue& x, const XMMValue& y, XMMValue z[8]);

// Homework

int main()
{
	__declspec(align(16)) XMMValue x;
	__declspec(align(16)) XMMValue y;
	__declspec(align(16)) XMMValue z[8];


	x.xmm_float[0] = 5.1673f;
	x.xmm_float[1] = 4.3753f;
	x.xmm_float[2] = 72.9821f;
	x.xmm_float[3] = 54.5629f;

	y.xmm_float[0] = -54.7473f;
	y.xmm_float[1] = 4.3753f;
	y.xmm_float[2] = -0.425f;
	y.xmm_float[3] = 6.8525f;

	avx_compare_f32(x, y, z);

	for (size_t i = 0; i < 3; i++)
	{
		std::cout << z[0].xmm_int[i] << ", ";
	}
}
 