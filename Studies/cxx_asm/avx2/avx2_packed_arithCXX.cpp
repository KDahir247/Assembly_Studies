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

struct YMMValue {
public:
	union {
		int8_t ymm_i8[32];
		int16_t ymm_i16[16];
		int32_t ymm_i32[8];
		int64_t ymm_i64[4];
		
		uint8_t ymm_u8[32];
		uint16_t ymm_u16[16];
		uint32_t ymm_u32[8];
		uint64_t ymm_u64[4];

		float_t ymm_float[8];
		double_t ymm_double[4];
	};
};

// Homework
// c  will store; add, sub, mul, div, flip, sqrt, min, max
extern "C" void avx_pck_math_f32(const YMMValue & a, const YMMValue & b, YMMValue c[8]);

int main()
{
	__declspec(align(32)) YMMValue a;
	__declspec(align(32)) YMMValue b;
	__declspec(align(32)) YMMValue c[8];

	a.ymm_float[0] = 79.476f;		b.ymm_float[0] = -14.868f;
	a.ymm_float[1] = 98.18f;		b.ymm_float[1] = 36.474f;
	a.ymm_float[2] = 26.906f;		b.ymm_float[2] = -43.862f;
	a.ymm_float[3] = 95.264f;		b.ymm_float[3] = 47.452f;
	a.ymm_float[4] = 30.567f;		b.ymm_float[4] = -41.523f;
	a.ymm_float[5] = 82.116f;		b.ymm_float[5] = 39.206f;
	a.ymm_float[6] = 67.25f;		b.ymm_float[6] = 11.003f;
	a.ymm_float[7] = 68.712f;		b.ymm_float[7] = -3.597f;


	avx_pck_math_f32(a, b, c);

	std::cout << "-------------addition-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[0].ymm_float[i] << ",  ";
	}
	
	std::cout << std::endl;
	std::cout << std::endl;


	std::cout << "-------------subtract-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[1].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	std::cout << "-------------multiply-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[2].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	std::cout << "-------------divide-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[3].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;


	std::cout << "-------------flip-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[4].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	std::cout << "-------------sqrt-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[5].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	std::cout << "-------------min-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[6].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;

	std::cout << "-------------max-------------" << std::endl;

	for (size_t i = 0; i < 8; i++)
	{
		std::cout << c[7].ymm_float[i] << ",  ";
	}

	std::cout << std::endl;
	std::cout << std::endl;
}
 