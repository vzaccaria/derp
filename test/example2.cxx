#include <string>
#include <iostream>
 
auto s = "variable string";
auto cs = "This is a string that interpolates #{s}";

int main()
{
    int i = 1;
    std::cout << "This is an interpolation of '##{i}' that goes to stdout\n";
}

