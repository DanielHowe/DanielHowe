/*
 * Title: equal_group.cpp
 * Abstract: This program receives two user inputs A) number that indicates the
 *   size of the input, B) the list of inputs up to A.  Then it determines if 
 *   the list can be divided by the half of its sum and whether the first half 
 *   sum is the half of the sum of the whole
 * Author: Daniel Philip Howe
 * ID: 7070
 * Date: 05/14/2019
 */
 
 #include <iostream>
 #include <iomanip>
 
using namespace std;

int main()
{

    // Get user input to determine size of array to input values later
    int numbersInput = 0;
    cout << "Number of input: ";
    cin >> numbersInput;
    
    // Get user input for the array of values
    int arrayNumbers[15] = { 0 };
    cout << "Enter 3 numbers: ";
    int userInputCount = 0;
    int sumNumbers = 0;
    while (cin.good() && userInputCount < numbersInput)
    {
        cin >> arrayNumbers[userInputCount++];
    }
    
    for (int i = 0; i < numbersInput; i++)
    {
        sumNumbers += arrayNumbers[i];
    }
    //cout << "(Diag) Sum of Numbers in array: " << sumNumbers << endl;
    
    // determine the left half sum
    int leftSum = 0;
    //cout << "(Diag) Halfway " << sumNumbers / 2 << endl;
    
    for (int i = 0; i < numbersInput / 2; i++ )
    {
        leftSum += arrayNumbers[i];
    }
    //cout << "(Diag) Left Sum: " << leftSum << endl;
    
    cout << "Equal Group: ";
    if (sumNumbers / 2 == leftSum)
    {
        for (int i = 0; i < numbersInput / 2; i++ )
        {
            cout << arrayNumbers[i] << " ";
        }
        
        cout << "vs ";
        
        for (int i = numbersInput / 2; i < numbersInput; i++)
        {
            cout << arrayNumbers[i] << " ";
        }
    }
    else
    {
        cout << "Not exist" << endl;
    }
    
    
    cout << "Done." << endl;

    return 0;
}