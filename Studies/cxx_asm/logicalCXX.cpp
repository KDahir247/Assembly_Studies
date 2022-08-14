// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

// (((a & b) | c) ^ d) + value
extern "C" int int_logic(unsigned int a,unsigned int b,unsigned int c,unsigned int d);

extern "C" unsigned int value = 0;

int main()
{
    value = 2;
    unsigned int a = 3641; // 0111000111001b
    unsigned int b = 1121; // 0010001100001b 
    unsigned int c = 2431; // 0100101111111b
    unsigned int d = 5824; // 1011011000000b
    unsigned int res = int_logic(a, b, c, d);

    std::cout << res;
}
