/*
File: classFinalHeader.cpp
Programmer Name: Daniel Howe
Instructor: Miakhau, Chia (MChia@marin.edu)
Compiler: Visual Studio 2012
Date: 20160417
Description: Class to define a person and set attributes, this is the implementation.
Notes/Updates:
*/

#include "classFinalHeader.h"
#include <iostream>

using namespace std;
#include <iostream>
#include <string>

//constructors
Person::Person()
{
	m_name = "";
	//m_occupation = "";
}

Person::Person(string p_name)
{
	m_name = p_name;
}

//setters
void Person::setName(string p_name)
{
	m_name = p_name;
}

//getters
void Person::getInfo()
{
	cout << m_name;
}

void Person::getJobTitle()
{
	cout << " ";
}

Baker::Baker()
{
	Person();
}

Baker::Baker(string p_name)
{
	Person::setName(p_name);
}

void Baker::getInfo()
{
	Person::getInfo();
	cout << " is a " << m_occupation << endl;
};

Surgeon::Surgeon()
{
	Person();
}

Surgeon::Surgeon(string p_name)
{
	Person::setName(p_name);
}

void Surgeon::getInfo()
{
	Person::getInfo();
	cout << " is a " << m_occupation << endl;
}

Astronaut::Astronaut()
{
	Person();
}

Astronaut::Astronaut(string p_name)
{
	Person::setName(p_name);
}

void Astronaut::getInfo()
{
	Person::getInfo();
	cout << " is a " << m_occupation << endl;
}