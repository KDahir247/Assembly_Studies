// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>


extern "C" int reverse_array(int* dst, const int* src, int len);

// homework

void initialize(int* x,  long long n, unsigned int seed)
{
	std::uniform_int_distribution<> d{ 1, 243 };
	std::default_random_engine rng(seed);
	for (long long i = 0; i < n; i++)
		x[i] = d(rng);
}


int main()
{
	const int len = 15;

	int src[len];
	int dst[len];
	int seed = 13;
	initialize(src,  len, seed);
	int err_code = reverse_array(dst, src, len);

	std::cout << "________________ original ________________" << std::endl;
	for (size_t i = 0; i < len; i++)
	{
		std::cout << src[i] << "\t";
	}

	std::cout << "\n" << std::endl;
	std::cout << "________________ reversed ________________" << std::endl;

	for (size_t i = 0; i < len; i++)
	{
		std::cout << dst[i] << "\t";
	}
	std::cout << std::endl;

}
