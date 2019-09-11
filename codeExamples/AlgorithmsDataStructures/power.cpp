/*
 * Title: power.cpp
 * Abstract: This program computes the result of a base integer
 *    raised to some input then displays the result
 * Author: Daniel Philip Howe
 * ID: 7070
 * Date: 05/14/2019
 */
 
 #include <iostream>
 #include <iomanip>
 
using namespace std;

int power(int p_raisedTo, int p_base)
{
    if (p_raisedTo <= 0)
    {
        return 1;
    }
    else
        return p_base * power(p_raisedTo - 1, p_base);
}

int main()
{

    int powerInteger = 0;
    int baseInteger = 2;
    // Get user input
    cout << "Enter a number: ";
    cin >> powerInteger;
    
    cout << "Result: " << power(powerInteger, baseInteger) << endl;
    
    return 0;
}