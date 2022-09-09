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
extern "C" void transpose(const float* matrix, float* transpose_matrix);

int main()
{
 	__declspec(align(16)) float matrix_arr[16] = {
		1.0,  2.0,  3.0,   4.0,
		5.0,  6.0,  7.0,   8.0,
		9.0,  10.0, 11.0,  12.0,
		13.0, 14.0, 15.0,  16.0

	};

	__declspec(align(16)) float transpose_matrix_arr[16] = {};

	transpose(matrix_arr, transpose_matrix_arr);

	

		for (size_t i = 0; i < 16; i++)
		{
			std::cout << transpose_matrix_arr[i] << ", ";

			if ((i + 1) % 4 == 0) {
				std::cout << std::endl;
			}

		}

	


}
 