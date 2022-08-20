// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>

// todo write these in assembly

extern "C" int calc_matrix_row_col_sums(int* row_sums, int* col_sums, const int* x, int nrows, int ncols);

// homework

void initialize(int* x, int nrows, int ncols)
{
	unsigned int seed = 13;
	std::uniform_int_distribution<> d{ 1, 200 };
	std::default_random_engine random{ seed };
	for (int i = 0; i < nrows * ncols; i++)
		x[i] = d(random);
}

void print_res( const int* row_sums, const int* col_sums, const int* x,
	int nrows, int ncols)
{
	const int w = 6;
	for (int i = 0; i < nrows; i++)
	{
		for (int j = 0; j < ncols; j++) {
			std::cout << std::setw(w) << x[i * ncols + j];
		}

		std::cout << " " << std::setw(w) << row_sums[i] << std::endl;
	}

	std::cout << std::endl;
	
	for (int i = 0; i < ncols; i++) {
		std::cout << std::setw(w) << col_sums[i];
	}

	std::cout << std::endl;
}

// homework
int main()
{
	const int nrows = 7;
	const int ncols = 5;
	int x[nrows][ncols];
	initialize((int*)x, nrows, ncols);
	int row_sums1[nrows], col_sums1[ncols];

	int res = calc_matrix_row_col_sums(row_sums1, col_sums1, (int*)x, nrows, ncols);

	
	print_res( row_sums1, col_sums1, (int*)x, nrows, ncols);
	std::cout << "Result Code (1 = Success, 0 = Failed): " << res << std::endl;

}
