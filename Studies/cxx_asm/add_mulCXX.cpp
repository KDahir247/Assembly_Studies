// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

extern "C" int add_mul(int a, int b, int c, int d);

int main()
{
    int a = 10; int b = 20; int c = 30; int d = 40;

    int res = add_mul(a, b, c, d);

    std::cout << res;
}
