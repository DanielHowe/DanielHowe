/*
File: Lab3.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160308
Description: Program to create 100 random lowercase letters and to count how many are the same
Notes/Updates:
*/

#include <iostream>
#include <string>
#include <ctime>

using namespace std;

int main()
{
	char randChars[100] = "";
	int matchCountSum = 0;
	srand(time(0));
	for (int i = 0 ; i <100 ; i++)
	{
		randChars[i] = 'a' + rand() % ('z' - 'a' + 1);
		cout << randChars[i] << endl;
	}
	int lastReadIndex = 0;

	do
	{
		cout << "Character: " << randChars[lastReadIndex] << " Found ";
		for (int i = 1 ; i < 100 ; i++)
		{
			if ( randChars[i] == '\0' ) break;
			if ( randChars[lastReadIndex] == randChars[i] ) 
			{
				matchCountSum += 1;		
			}
		}
		cout << matchCountSum << " matches" << endl;
		matchCountSum = 0;
		lastReadIndex += 1;
	} while (lastReadIndex<100);

	
	return 0;
}