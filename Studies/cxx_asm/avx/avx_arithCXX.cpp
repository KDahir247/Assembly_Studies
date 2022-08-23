// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>



extern "C" float celcius_to_farenheit(float celcius);
extern "C" float farenheit_to_celcius(float farenheit);

// Homework

int main()
{
	const int len = 5;
	float faren[len]{ -459.67f, -40.0f, 32.0f, 98.6f, 212.0f };
	float celc[len]{ -273.15f, -40.0f, 0.0f, 37.0f, 100.0f };
	std::cout << "------------f_to_c--------------" << std::endl;

	for (size_t i = 0; i < len; i++)
	{
		float celcius = farenheit_to_celcius(faren[i]);

		std::cout << "f: " << std::setw(4) << faren[i] << std::endl;
		std::cout << "c: " << std::setw(4) << celcius << std::endl;
		
		std::cout << "------------------------------" << std::endl;


	}

	std::cout << "\n" << std::endl;


	std::cout << "------------c_to_f--------------" << std::endl;

	for (size_t i = 0; i < len; i++)
	{
		float faren = celcius_to_farenheit(celc[i]);

		std::cout << "c: " << std::setw(4) << celc[i] << std::endl;
		std::cout << "f: " << std::setw(4) << faren << std::endl;

		std::cout << "------------------------------" << std::endl;


	}
}
