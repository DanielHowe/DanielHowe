/*
 * Title: ts.cpp
 * Abstract: This program receives user input for a file to be examined,
 *  the first line indicates the size of the array contained in the file
 *  the second line is the array.
 *  The array is sampled to determine the topoSort of a given array such that the
 *  Index should be displayed if the node exists on that index
 * Author: Daniel Philip Howe
 * ID: 7070
 * Date: 06/04/2019
 */

#include <iostream>
#include <iomanip>
#include <fstream>
 
using namespace std;

int main()
{
    string fileName; // string to store path of file

    // Get user input
    cout << "Enter a filename: ";
    cin >> fileName;
    
    ifstream inputFile; //create new file object
    inputFile.open(fileName.c_str()); // open the file in the new object
    
    if (!inputFile) 
    { // checks validity
        cout << "Invalid file" << endl;
        //exit(1); // abnormal exit
        return -1;
    }
    
    // Read file contents and assign to an array
    int arraySize; // size of the array to be read from file
    inputFile >> arraySize; // reads first line from file and stores to arraySize
    
    int arr[arraySize][arraySize]; // initialize new array to size specified
    int visited[arraySize]; // init new array to store whether a bit has been marked
    
    for(int i = 0; i < arraySize; i++) 
    { // store values from file to new array
        for (int j = 0; j < arraySize; j++)
        {
            inputFile >> arr[i][j];
        }
    }
    
    cout << "array now sorted as: " << endl;
    for(int i = 0; i < arraySize; i++) 
    { // display values from file to new array
        for (int j = 0; j < arraySize; j++)
        {
            //cout << arr[i][j] << " ";
            if ((arr[i][j] == 1))
            { //((arr[i][j] == 1) && visited[j] != true)
                //cout << "visited j: " << j << " ";
                visited[i] = 1;
                //cout << "setting i: " << i << endl;
                visited[j] = 1;
            }
        }
        //cout << endl;
    }
    
    for (int i = 0; i <= arraySize; i++)
        {
            if ( visited[i] == 1 && i < arraySize - 2 )
                cout << i << " -> ";
            else if ( i == (arraySize - 1) )
                cout << i;
        }
    
}