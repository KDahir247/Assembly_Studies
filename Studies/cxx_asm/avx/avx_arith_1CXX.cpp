// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>



extern "C" void calc_sphere_area_vol(double radius, double* surface_area, double* volume);

// Homework

int main()
{
	double suface_area{};
	double volume{};
	double radius = 6.123;

	calc_sphere_area_vol(radius, &suface_area, &volume);

	std::cout << "------------------------------" << std::endl;

	std::cout << "sphere calculation" << std::endl;
	std::cout << "radius is: " << radius << std::endl;

	std::cout << "surface area is: " << suface_area << std::endl;
	std::cout << "volume is: " << "" << volume << std::endl;

	std::cout << "------------------------------" << std::endl;


}
