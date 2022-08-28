// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

extern "C" bool calc_standard_deviation(double* mean, double* standard_deviation, const double* x, int len);
// Homework

int main()
{
	const int len = 17;
	double x[len] = { 8, 67, 33, 86, 36, 5, 6, 53, 30, 19, 14, 40, 91, 73, 100, 37, 54 };
	double mean{}, standard_deviation{};

	bool res = calc_standard_deviation(&mean, &standard_deviation, x, len);

	if (res) {
		std::cout << "Mean : " << mean << std::endl;
		std::cout << "Standard Deviation : " << standard_deviation << std::endl;
	}
	else {
		std::cout << "length can not be zero." << std::endl;
	}
}
