/*
File: HoursMinutesSecondsConverter
Name: Daniel Howe
Date: 20160126
Desc: For converting user input in seconds to Hr., Min., Sec
Notes:
*/


//directives for preprocessor
#include <iostream>
#include <string>
#include <cmath>
using namespace std;


int main()
{ 
	int userinput = 0;
	int hours = 0;
	int minutes = 0;
	int seconds = 0;
	int minutesremaining = 0;
	cout << "Enter the seconds to be converted to Hrs, Mins, Secs\n";
	cin >> userinput; // this is an extraction operator...
	// Processing
	seconds = userinput % 60;
	minutes = userinput/60;
	minutesremaining = minutes % 60;
	hours = minutes/60;
	// Output
	cout << "There are:\n" << hours << " Hours " << minutesremaining << " Minutes " << seconds << " Seconds" << endl;
	return 0;
}