// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>


extern "C" double calc_distance(double x2, double y2, double z2, double x1, double y1, double z1);

// Homework

int main()
{

	double res = calc_distance(56.0, 12.0, 1.0, 35.0, 5.0, 3.0);
	std::cout << res << std::endl;

}
