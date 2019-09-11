/*
File: Lab1.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160308
Description: Program to read user input as a c-string (char []), convert it to upper then compare the string to the original 
Notes/Updates:
*/

#include <iostream>
#include <string>
#include <cstring>

using namespace std;

int main()
{
	const int cStringLength = 20;
	char userInput[cStringLength] = "";
	char userInputCopied[cStringLength] = "";
	cout << "Please ask me something...\nplease make sure it ends with a '?'" << endl;
	cin.getline(userInput,20,'?');
	cout << "The string length is " << strlen(userInput) << endl;
	for (int i = 0 ; i < cStringLength ; i++)
	{
		if (userInput[i] == '\n')
		{
			userInputCopied[i] = userInput[i];
			continue; // found a null character and stops...
		}
		userInputCopied[i] = toupper(userInput[i]);
	}
	cout << "You input converted to upper is "<< userInputCopied << endl;
	if (strcmp(userInput, userInputCopied) != 0 )
		cout << "The string is different" << endl;
	else cout << "The string is the same..." << endl;
  	return 0; // EOL

}