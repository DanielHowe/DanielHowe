/*
File:Lab2,4.cpp
Name:Daniel Howe
Date:20160126
Desc:Sum digits in integer
Notes:

*/

#include <iostream>
#include <string>

using namespace std;

int main()
{
	int startingInteger = 0;
	int growing = 0;
	int a = 1;
	cout << "Enter a number between 0 and 1000: ";
	cin >> startingInteger; //Take user input for startingInteger
	for (int b = 1 ; b < 1000 ; b *= 10 )
	{
		growing += startingInteger % (10 * a);
		startingInteger /= (10 * a);
	}
	cout << "The sum of the digits is " << growing << endl;
	return 0;

}