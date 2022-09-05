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
extern "C" float  min_val = std::numeric_limits<float>::max(); // min start at max so when we do a min instruction the val array will always be the minimum in the start
extern "C" float max_val = std::numeric_limits<float>::min();

extern "C" bool calc_min_max(float* min, float* max, const float* val, size_t len);
// Homework

int main()
{
	const size_t len = 22;
	__declspec(align(16)) float src[len];

	std::uniform_int_distribution<> dist{-100, 1000};
	std::default_random_engine random_engine{ 25 };
	for (size_t i = 0; i < len; i++)
	{
		src[i] = (float)dist(random_engine);
	}

	float min_src{};
	float max_src{};



	calc_min_max(&min_src, &max_src, src, len);

	std::cout << "Array values" << std::endl;
	for (size_t i = 0; i < len; i++)
	{

		std::cout << src[i] << "," << std::setw(5);
	}


	std::cout << "\n\n" << std::endl;


	std::cout << "Minimum value:";
	std::cout << std::setw(5) << min_src << std::endl;

	std::cout << "Maximum value:";
	std::cout << std::setw(5) << max_src << std::endl;


}
 