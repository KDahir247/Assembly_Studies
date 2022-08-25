// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>
#include <string>

extern "C" void compare_single(float a, float b, bool* res);

// Homework

int main()
{
	float a = 1.34f;
	float b = 6.61f;

	bool res[7]{};
	std::string cmp_operation[7] = {"Invalid" ,"Less Then", "Less Then or Equal", "Equal", "Not Equal", "Greater Then", "Greater Then or Equal"};

	compare_single(a, b, res);
	
	std::cout << "---------------------------" << std::endl;

	for (size_t i = 0; i < 7; i++)
	{
		std::cout << cmp_operation[i] << ": ";
		std::cout << res[i] << std::endl;
	}
	
	std::cout << "---------------------------" << std::endl;

}
