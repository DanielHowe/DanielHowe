/*
 * Title: heap.cpp
 * Abstract: This program prompts a user to enter a list of numbers
 *  and allows the user to use functions to check to see if it is a heap
 *  and to modify the heap
 * Author: Daniel Philip Howe
 * ID: 7070
 * Date: 06/18/2019
 */
 
 #include <iostream>
 #include <iomanip>

using namespace std;
int main()
{
    int arraySize;
    cout << "Input Size: ";
    cin >> arraySize;
    
    // Typical
    // int userArrayInput[arraySize];
    // cout << "Enter numbers: ";
    // for (int i = 0; i < arraySize; i++)
    // {
    //     cin >> userArrayInput[i];
    // }
    
    //Dynamic Allocation
    int *userArray;
    userArray = new int[arraySize];
    // Fill out the newly created array
    cout << "Enter numbers: ";
    bool heap = true;
    for (int i = 0; i < arraySize; i++)
    {
        cin >> userArray[i];
        if (userArray[0] < userArray[i])
        { 
            heap = false;
        }
    }
    
    // Notify user if it is a heap or not
    if (heap)
    {
        cout << "This is a heap.." << endl;
    }
    else
    {
        cout << "This is NOT a heap" << endl;
    }
    
    cout << "Select an operation \n\t1: Insert a number\n\t2. Delete the max\n\t3. Heapsort and Quit" << endl;
    
    int userMenuInput;
    cin >> userMenuInput;
    
    switch(userMenuInput)
    {
        case 1 : 
        {
            int newNumberEntry;
            cout << "Enter a number: ";
            cin >> newNumberEntry;
        }
        
        case 2 :
        {
            // delete userArray[0];
            // display array
            for (int i = 0; i < arraySize; i++)
            {
                cout << userArray[i];
            }
        }
        
        case 3 :
        {
            cout << "Heapsort: ";
            //heapify();
            // display array
            for (int i = 0; i < arraySize; i++)
            {
                cout << userArray[i];
            }
            cout << "Bye!" << endl;
        }
    }
    
    
}