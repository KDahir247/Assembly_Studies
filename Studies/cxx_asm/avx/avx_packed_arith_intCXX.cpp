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
extern "C" void avx_packed_add_i16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
extern "C" void avx_packed_sub_i16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);

extern "C" void avx_packed_add_u16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
extern "C" void avx_packed_sub_u16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);


int main()
{
	__declspec(align(16)) XMMValue a;
	__declspec(align(16)) XMMValue b;
	__declspec(align(16)) XMMValue c[2];

	a.xmm_i16[0] = 24;	  b.xmm_i16[0] = 87;
	a.xmm_i16[1] = 123;   b.xmm_i16[1] = 127;
	a.xmm_i16[2] = 5;	  b.xmm_i16[2] = 9;
	a.xmm_i16[3] = 3401; b.xmm_i16[3] = 4551;
	a.xmm_i16[4] = 80;	  b.xmm_i16[4] = 400;
	a.xmm_i16[5] = 2112; b.xmm_i16[5] = 27512;
	a.xmm_i16[6] = 35000; b.xmm_i16[6] = 1211;
	a.xmm_i16[7] = 1111;  b.xmm_i16[7] = 923;

	a.xmm_ui16[0] = 11;	 b.xmm_ui16[0] = 111;
	a.xmm_ui16[1] = 250;	 b.xmm_ui16[1] = 250;
	a.xmm_ui16[2] = 33;	 b.xmm_ui16[2] = 9;
	a.xmm_ui16[3] = 60000;	 b.xmm_ui16[3] = 5432;
	a.xmm_ui16[4] = 67;	 b.xmm_ui16[4] = 234;
	a.xmm_ui16[5] = 3501;  b.xmm_ui16[5] = 35001;
	a.xmm_ui16[6] = 12345;  b.xmm_ui16[6] = 4321;
	a.xmm_ui16[7] = 1201;	 b.xmm_ui16[7] = 951;

	avx_packed_add_i16(a, b, c);


	std::cout << "---------add i16 wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;

	std::cout << "---------add i16 sign wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;
	std::cout << std::endl;


	avx_packed_sub_i16(a, b, c);

	std::cout << "---------sub i16 wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;

	std::cout << "---------sub i16 signed wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].xmm_i16[i] << ",\t";
	}

	std::cout << std::endl;
	std::cout << std::endl;


	avx_packed_add_u16(a, b, c);


	std::cout << "---------add u16 wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].xmm_ui16[i] << ",\t";
	}

	std::cout << std::endl;

	std::cout << "---------add u16 signed wrap around---------" << std::endl;
	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].xmm_ui16[i] << ",\t";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	avx_packed_sub_u16(a, b, c);

	std::cout << "--------sub u16 wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].xmm_ui16[i] << ",\t";
	}

	std::cout << std::endl;

	std::cout << "---------sub u16 signed wrap around---------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].xmm_ui16[i] << ",\t";
	}

	std::cout << std::endl;
	std::cout << std::endl;


}
 