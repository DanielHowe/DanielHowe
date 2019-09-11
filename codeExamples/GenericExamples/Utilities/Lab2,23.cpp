/*
File: Lab2,23.cpp
Name: Daniel Howe
Date: 20160126
Desc: Financial Application future investment val
Notes:

*/

#include <iostream>
#include <string>
#include <cmath>

using namespace std;

int main()
{
	// Declare and init
	double investmentAmount = 0.0;
	double futureInvestmentValue = 0.0;
	double annualInterestRate = 0.0;
	int numberOfYears = 0;
	double accumulatedValue = 0.0;
	double monthlyInterestRate = 0.0;

	// Get input from user
	cout << "Enter investment amount: ";
	cin >> investmentAmount;
	cout << "Enter annual interest rate in percentage: ";
	cin >> annualInterestRate;
	annualInterestRate /= 100.0;
	cout << "Enter number of years: ";
	cin >> numberOfYears;
	monthlyInterestRate = annualInterestRate / 12;
	futureInvestmentValue = investmentAmount * ( pow( 1 + monthlyInterestRate , ( numberOfYears * 12 ) ) );
	cout << "Accumulated value is $" << futureInvestmentValue << endl;
	// End of prog
	return 0;
}
