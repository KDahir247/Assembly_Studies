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



// Homework
extern "C" void matrix_mul(const float* mat_1, const float* mat_2, float* mat_res);


int main()
{
 	__declspec(align(16)) float matrix_arr[16] = {
		1.0,  2.0,  3.0,   4.0,
		5.0,  6.0,  7.0,   8.0,
		9.0,  10.0, 11.0,  12.0,
		13.0, 14.0, 15.0,  16.0

	};

	__declspec(align(16)) float matrix_arr1[16] = {
		2.0, 4.0, 1.0, 1.5,
		3.0, 1.0, 5.0, 3.0,
		7.0, 8.0, 2.0, 1.0,
		9.0, 4.0, 1.0, 11.0
	};


	__declspec(align(16)) float matrix_res[16] = {};


	matrix_mul(matrix_arr, matrix_arr1, matrix_res);

	std::cout << "---------src matrix-----------------" << std::endl;

	for (size_t i = 0; i < 16; i++)
	{
		std::cout << matrix_arr[i] << ",\t";
		if ((i + 1) % 4 == 0) {
			std::cout << std::endl;
		}
	}

	std::cout << "\n multiply(*) \n" << std::endl;

	for (size_t i = 0; i < 16; i++)
	{
		std::cout << matrix_arr1[i] << ",\t";
		if ((i + 1) % 4 == 0) {
			std::cout << std::endl;
		}
	}

	std::cout << "\n equal(=) \n" << std::endl;

	for (size_t i = 0; i < 16; i++)
	{
		std::cout << matrix_res[i] << ",\t";
		if ((i + 1) % 4 == 0) {
			std::cout << std::endl;
		}
	}

}
 