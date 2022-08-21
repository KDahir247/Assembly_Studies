// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>


extern "C" long long count_char(const char* string, char locate_this);

// homework
int main()
{
	const char* hello_text = "Hello World";
	char find = 'l';

	long long res = count_char(hello_text, find);

	std::cout << find << " is located " << res << " times in " << hello_text << std::endl;
}
