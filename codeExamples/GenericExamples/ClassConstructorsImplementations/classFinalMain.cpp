/*
File: lab1.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160315
Description: program for taking user input and adding it to the rectangle object
Notes/Updates:
*/

#include <iostream>
#include <iomanip>
#include "classFinalHeader.h"

using namespace std;

int main()
{
	Baker person1("Bob Barker");
	Surgeon person2("Susan Swenson");
	Astronaut person3("Andrew Ashton");

	person1.getInfo();
	person2.getInfo();
	person3.getInfo();

	return 0;
}