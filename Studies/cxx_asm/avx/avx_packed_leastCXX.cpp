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

extern "C" double ls_epsilon = 1.0e-12;

extern "C" bool avx_calc_least_sqrs(const double* x, const double* y, int len, double* m, double* n);
// Homework

int main()
{
	const int n = 10;
	alignas(16) double x[n] = { 40,63,68,17,68,33,75,98,43,10 };
	alignas(16) double y[n] = { 2.9,4.6,6,6.6,10.2,1.3,5.5,10.2,4.2,5.3 };

	double m1{};
	double b1{};

	avx_calc_least_sqrs(x, y, n, &m1, &b1);

	std::cout << m1 << std::endl;
	std::cout << b1 << std::endl;
}
 