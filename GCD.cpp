
/*
	Title: GCD
	Author: pouya.taghipour@Gmail.com
*/


#include <iostream>
#include <conio.h>
#include <bitset>

using namespace std;

int GCD(unsigned int D1, unsigned int D2);


int main(int argc, char** argv) 
{
	GCD(161,14);
	_getch();
	
	return 0;
}

int GCD(unsigned int num1, unsigned int num2)
{
   int gcd =0;
   
   if(num1 == num2)
   {
   	 gcd = num1;
   }
   else
   {
		while ((num1 != 0) && (num2 != 0))
		{
			if (num1 > num2)
				num1 = 	num1 - num2	;
			else			
				num2 = 	num2 - num1	;				
		}
   }
   
    gcd = num1;   
    cout<<"gcd="<<gcd<<endl;
	return num1;
}



