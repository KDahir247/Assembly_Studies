// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>


extern "C" long long cmp_array(const int* a, const int* b, long long len);

// homework

void initialize(int* x, int* y, long long n, unsigned int seed)
{
	std::uniform_int_distribution<> d{ 1, 243 };
	std::default_random_engine rng(seed);
	for (long long i = 0; i < n; i++)
		x[i] = y[i] = d(rng);
}


int main()
{
	const long long len = 243;

	int x[len];
	int y[len];

	initialize(x, y, len, 24);

	long long result = cmp_array(x, y, len);


	if (result != len) {

		std::cout << "index : " << result << " is not the same. " << std::endl;
	}
	else {
		std::cout << "both x and y are the same! " << std::endl;
	}

}
