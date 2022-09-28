// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

using namespace std;


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

void Init(float* r, size_t n, unsigned int seed)
{
	uniform_int_distribution<> ui_dist{ 1, 10 };
	default_random_engine rng{ seed };
	for (size_t i = 0; i < n; i++)
		r[i] = (float)ui_dist(rng);
}

extern "C" float PI = 3.14159274f;
extern "C" float QUIET_NAN_F32 = std::numeric_limits<float>::quiet_NaN();

// Homework
extern "C" void avx2_calc_sphere_area_volume(float* surface_area, float* volume, const float* radius, size_t n);

int main()
{
	const size_t n = 23;
	__declspec(align(32)) float r[n];
	__declspec(align(32)) float surface_area[n];
	__declspec(align(32)) float volume[n];

	Init(r, n, 23);

	avx2_calc_sphere_area_volume(surface_area, volume, r, n);


	std::cout << "------------------Surface Area------------------" << std::endl;
	for (size_t i = 0; i < n; i++)
	{
		std::cout << surface_area[i] << ",  ";
	}

	std::cout << std::endl;


	std::cout << "------------------Volume------------------" << std::endl;
	for (size_t i = 0; i < n; i++)
	{
		std::cout << volume[i] << ",  ";
	}

	std::cout << std::endl;

}
 