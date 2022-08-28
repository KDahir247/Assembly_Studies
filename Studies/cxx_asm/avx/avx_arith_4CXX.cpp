// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

using namespace std;

extern "C" void calc_matrix_squares(float* y, const float* x, float offset, int nrows, int ncols);
// Homework

int main()
{
	const int num_rows = 3;
	const int num_cols = 3;
	const float offset = 0.25;
	float y[num_rows][num_cols];
	float x[num_rows][num_cols]{ { 2, 4, 6 }, { 8, 10, 8 }, { 6, 4, 2 }};

	calc_matrix_squares(&y[0][0], &x[0][0], offset, num_rows, num_cols);


	for (size_t i = 0; i < num_rows; i++)
	{
		for (size_t j = 0; j < num_cols; j++)
		{
			std::cout <<  y[j][i] << ", ";
		}
		std::cout << std::endl;
	}
}
