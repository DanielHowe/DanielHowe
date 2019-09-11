/*
File: Lab2.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160308
Description: Program to read user to input 5 single digit integers, convert ascii and concatanate to single string
Notes/Updates:
*/

#include <iostream>
#include <string>
//#include <cstring>

using namespace std;



int main()
{
	int userIntInput = 0;
	char userInput[2] = "";
	char userInputConcatenated[6] = "";
	for (int i = 0 ; i < 5 ; i++)
	{
		cout << "Please enter a single digit integer: ";
		cin >> userIntInput;
		strcat_s(userInputConcatenated, itoa(userIntInput, userInput, 10));
	}
	cout << "Your string is: " << userInputConcatenated;

  	return 0; // EOL

}