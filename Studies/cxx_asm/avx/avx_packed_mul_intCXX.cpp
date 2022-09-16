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
		uint16_t xmm_ui16[8];
		int16_t xmm_i16[8];
	};
};



// Homework
extern "C" void avx_packed_muli16(XMMValue c[2], const XMMValue * a, const XMMValue * b);
extern "C" void avx_packed_muli32(XMMValue * c, const XMMValue * a, const XMMValue * b);

int main()
{
	__declspec(align(16)) XMMValue a;
	__declspec(align(16)) XMMValue b;
	__declspec(align(16)) XMMValue c[2] = { };

	a.xmm_i16[0] = 24;	  b.xmm_i16[0] = 87;
	a.xmm_i16[1] = 123;   b.xmm_i16[1] = 127;
	a.xmm_i16[2] = 5;	  b.xmm_i16[2] = 9;
	a.xmm_i16[3] = 3401; b.xmm_i16[3] = 4551;
	a.xmm_i16[4] = 80;	  b.xmm_i16[4] = 400;
	a.xmm_i16[5] = 2112; b.xmm_i16[5] = 27512;
	a.xmm_i16[6] = 35000; b.xmm_i16[6] = 1211;
	a.xmm_i16[7] = 1111;  b.xmm_i16[7] = 923;

	avx_packed_muli16(c, &a, &b);


	std::cout << "-----------mul low i16-----------" << std::endl;
	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;


	std::cout << "-----------mul high i16-----------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;

	a.xmm_int[0] = 5;	b.xmm_int[0] = -450;
	a.xmm_int[1] = 2500;  b.xmm_int[1] = 50;
	a.xmm_int[2] = -1510; b.xmm_int[2] = -12012;
	a.xmm_int[3] = 4250;	b.xmm_int[3] = 1500;
	XMMValue d{};

	avx_packed_muli32(&d, &a, &b);


	std::cout << "-----------mul i32-----------" << std::endl;


	for (size_t i = 0; i < 4; i++)
	{
		std::cout << d.xmm_int[i] << ",\t";
	}

	std::cout << std::endl;

}
 