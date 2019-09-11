/*
File: proj2.cpp
Programmer Name: Daniel Howe
Compiler: Visual Studio 2012
Date: 20160128
Description: 
Notes/Updates:
*/

#include <iostream>
#include <string>
#include <cmath>

using namespace std;

int main()
{
	// Input.  Process. Output.
	double a = 0.0, b = 0.0, c = 0.0;
	double xResult = 0.0; // Used for storing the result of the sqrt for test later
	cout << "Enter a, b, c: ";
	cin >> a >> b >> c;
	xResult = pow(b,2) - 4 * a * c;
	//cout << "The result of the determinent is: " << xResult << endl;
	if (xResult < 0)
	{
		cout << "The equation has no real roots" << endl;
	}
	if (xResult == 0)
	{
		cout << "The root is " << (- b + sqrt( pow(b,2) - 4 * a * c ) ) / 2 * a << endl;
	}
	if (xResult > 0)
	{
		cout << "The roots are "<< (- b + sqrt( pow(b,2) - 4 * a * c ) ) / 2 * a << " and " << (- b - sqrt( pow(b,2) - 4 * a * c ) ) / 2 * a;
	}


	return 0; // EOL

}