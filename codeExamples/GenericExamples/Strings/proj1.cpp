// Programmer: Daniel Howe
// Date: 20160119
// Compiler: VS Studio X 2012
// Program Notes: Display messages as strings...
// Todo: array or table print, concated strings, nested if

#include <iostream>
#include <string>
using namespace std;

#define space 5
#if space == 1
int main()
{
	string w = "Welcome to C++";
	string wcs = "Welcome to Computer Science";
	string p = "Programming is fun";
	cout << w << endl;
	cout << wcs << endl;
	cout << p << endl;
	return 0;
}
#elif space == 2
int main()
{
	string w = "Welcome to C++\n";
	for (int i = 1; i != 5; i++)
	{
		cout << w;
		cout << "..Did you hear me?  I have told you ";
		cout << i;
		cout << " times\n"; //not sure how to concate this..
	}
	return 0;
}
#elif space == 3
int main()
{
	string s1n4 = "  CCCC       +        +       \n";
	string s2n3 = " C           +        +       \n";
	string s3 =   "C         +++++++  +++++++\n";
	cout << s1n4+s2n3+s3;
	cout << s2n3+s1n4;
	return 0;
}
#elif space == 4
int main()
{
	cout << "a      a^2      a^3\n";
	cout << "1      1        1\n";
	cout << "2      4        8\n";
	cout << "3      9        27\n";
	cout << "4      16       64\n";
	return 0;
}
#elif space == 5
int main()
{
	cout << "print flag";
	return 0;
}
#endif