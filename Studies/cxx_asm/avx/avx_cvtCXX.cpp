// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

extern "C" int get_mxcsr_rounding();
extern "C" bool convert_float_to_int(int* a, float* b);

// 0 == rounding to nearest, 1 == rounding negative (down), 2 == rounding postive (up), 3 == rounding to zero
// Don't use value greater the 3 or less then 0, since RCC only ocupy two bits in the MXCSR register
extern "C" void set_msxcr_rounding(unsigned int id);
// Homework

int main()
{
	int old_round = get_mxcsr_rounding();
	set_msxcr_rounding(1);

	int a{};
	float b = 1.6f;
	convert_float_to_int(&a, &b);



	int res = get_mxcsr_rounding();
	
	if (res == 0)
	{
		std::cout << "rounding to nearest" << std::endl;
	}
	else if (res  == 1)
	{
		std::cout << "rounding negative" << std::endl;
	}
	else if (res == 2) {
		std::cout << "rounding postive" << std::endl;
	}
	else if (res == 3) {
		std::cout << "rounding to zero" << std::endl;
	}

	std::cout << "rounded value is " << a << std::endl;
	
	set_msxcr_rounding(old_round); // preserve rounding at function boundaries according to Visual C++ calling convention
}
