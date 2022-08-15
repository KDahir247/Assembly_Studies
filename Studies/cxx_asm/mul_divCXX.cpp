// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>


extern "C" int int_mul_div(int a, int b, int* product, int* quo, int* rem);

extern "C" unsigned int value = 0;

int main()
{
    int a = 45; int b = 23;
    int prodt{1}; int quo{2}; int rem{3};

    int res = int_mul_div(a, b, &prodt, &quo, &rem);


    std::cout << "product is " << prodt << std::endl;
    std::cout << "quotent is " << quo << std::endl;
    std::cout << "remainder is " << rem << std::endl;
}
