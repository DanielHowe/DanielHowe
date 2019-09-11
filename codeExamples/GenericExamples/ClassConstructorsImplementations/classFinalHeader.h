/*
File: classFinalHeader.h
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160517
Description: Class to define a person, and set attributes
Notes/Updates:
*/

#ifndef CLASSFINAL_H
#define CLASSFINAL_H
#include <iostream>
#include <string>
using namespace std;

class Person
{
public:
	Person(); //Empty or default constructor
	Person(string p_name); //Sets name to passed value
	void setName(string p_name); //changes name to passed value
	void getJobTitle(); //returns empty string
	void getInfo(); //returns the name of the person
private:
	string m_name;
};

class Baker 
	:public Person
{
public:
	Baker(); //Empty or default constructor
	Baker(string p_name); //Sets name to passed value
	void getInfo();
protected:
	string m_occupation = "Baker";
};

class Surgeon
	:public Person
{
public:
	Surgeon(); //Empty or default constructor
	Surgeon(string p_name); //Sets name to passed value
	void getInfo();
protected:
	string m_occupation = "Surgeon";
};

class Astronaut
	:public Person
{
public:
	Astronaut(); //Empty or default constructor
	Astronaut(string p_name); //Sets name to passed value
	void getInfo();
protected:
	string m_occupation = "Astronaut";
};
#endif