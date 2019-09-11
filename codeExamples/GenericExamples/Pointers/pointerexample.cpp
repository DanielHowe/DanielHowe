/*
File: pointerexample.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 201604
Description: 
Notes/Updates:
*/

#include <iostream>
#include <string>
using namespace std;

int main()
{
	struct Node
	{
		string name;
		char grade;
		Node *link;
	};

	Node *headPtr = NULL;
	headPtr = new Node;
	Node *tailPtr = NULL;
	tailPtr = headPtr;

	int students = 0;
	cout << "Enter in the amount of students you'll be inputting: ";
	cin >> students;
	string username;
	char wishGrade;
	cout << "Enter your name and your desired grade \n";
	cin >> username >> wishGrade;
	headPtr -> name = username ;
	headPtr -> grade = wishGrade;

	Node *temp = NULL;

	for (int i=0;i<students-1;i++)
	{

		temp = new Node;
		cin >> username >> wishGrade;
		temp -> name = username;
		temp -> grade = wishGrade;
		temp -> link = NULL;
		tailPtr -> link  = temp ;
		tailPtr = temp;
	}

	Node *trace = NULL;
	trace = headPtr;
	while (trace != NULL)
	{	
		cout << trace -> name << " ";
		cout << trace -> grade << endl;
		trace = trace -> link;
	}

	return 0;
}