/*
 * Title: ShortRep.cpp
 * Abstract: This program receives user input for a file to be examined,
 *  the first line indicates the size of the array contained in the file
 *  the second line is the first position of the array.
 *  The array is sorted and displayed such that if adjacent numbers are the same
 *  in the array, then a "-" is displayed between them, otherwise just list
 *  number with a " " delimiter
 * Author: Daniel Philip Howe
 * ID: 7070
 * Date: 05/28/2019
 */
 
 #include <iostream>
 #include <iomanip>
 #include <fstream>
 
using namespace std;

int quicklySort(int arrayGiven[], int leftIndex, int rightIndex)
{
    // initialize variables to find the middle
    int i = leftIndex;
    int j = rightIndex;
    int partitionIndex = arrayGiven[(leftIndex + rightIndex) / 2];
    
    // partition the array
    while (i <= j)
    {
        while (arrayGiven[i] < partitionIndex)
        {
            i++;
        }
        while (arrayGiven[j] > partitionIndex)
        {
            j--;
        }
        
        if (i <= j)
        {
            int temp = arrayGiven[i];
            arrayGiven[i] = arrayGiven[j]; //swap
            arrayGiven[j] = temp;
            i++;
            j--;
        }
    } // done partitioning
    
    if (leftIndex < j)
    {
        quicklySort(arrayGiven, leftIndex, j);
    }
    if (i < rightIndex)
    {
        quicklySort(arrayGiven, i, rightIndex);
    }
}

void displayShortenedArray(int p_arrayGiven[], int p_firstIndex, int p_lastIndex)
{
    int i = 0;
    bool incremental = false;
    int startInteger = p_arrayGiven[p_firstIndex];
    while(i < p_lastIndex)
    {
        // ignore first element
        if (p_arrayGiven[i+1] ==  p_arrayGiven[i]+1)
        { // incremental numbers
            if (!incremental)
            {
                startInteger = p_arrayGiven[i];
            }
            i++;
            incremental = true;
        }
        else //not incremental
        {
            if (incremental)
            {
                cout << startInteger << "-" << p_arrayGiven[i] << " ";
            }
            else
            {
                cout << p_arrayGiven[i] << " "; //space only
            }
            i++;
            incremental = false;
        }
    }
}

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
        exit(1); // abnormal exit
    }
    
    // Read file contents and assign to an array
    int arraySize; // size of the array to be read from file
    inputFile >> arraySize; // reads first line from file and stores to arraySize
    
    int arr[arraySize]; // initialize new array to size specified
    
    for(int i = 0; i < arraySize; i++) 
    { // store values from file to new array
        inputFile >> arr[i];
    }
    
    //quicklySort(int arrayGiven[], int leftIndex, int rightIndex) 
    quicklySort(arr, 0, arraySize);
    // cout << "array now sorted as: " << endl;
    // for(int i = 0; i < arraySize; i++) 
    // { // display values from file to new array
    //     cout << arr[i] << " ";
    // }
    
    //cout << "Displaying shortened array with duplicates truncated" << endl;
    displayShortenedArray(arr, 0, arraySize);
    
    cout << endl;
    
}