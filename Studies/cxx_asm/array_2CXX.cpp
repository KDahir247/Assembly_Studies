// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
// todo write these in assembly

extern "C" void calc_sqr_matrix(int* y, const int* x, int nrows, int ncols);

// homework
int main()
{
	const int nrows = 5;
	const int ncols = 3;
	int y2[nrows][ncols];
	int x[nrows][ncols]{ { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 },
	{ 10, 11, 12 }, {13, 14, 15}};

	calc_sqr_matrix(&y2[0][0], &x[0][0], nrows, ncols);


	for (int i = 0; i < nrows; i++)
	{
		for (int j = 0; j < ncols; j++)
		{
			std::cout << "res " << y2[i][j] << ' ';
			std::cout << " src" << x[j][i] << '\n';
		
		}
	}

}
