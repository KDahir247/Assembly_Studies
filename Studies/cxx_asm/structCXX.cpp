// C++ASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <iomanip>
#include <random>

// todo write these in assembly
struct MyStruct
{
	int8_t a;
	// compiler padding 
	//  processor alignment constraint 
	int16_t b;
	int32_t c;
	int64_t d;
};


extern "C" int sum_struct(const MyStruct* structure);
// homework


// homework
int main()
{
	MyStruct res;
	res.a = 25;
	res.b = 1231;
	res.c = 40000;
	res.d = 451;

	int aa = sum_struct(&res);
	
	std::cout << "MYSTRUCT VALUE : " << aa;

}
