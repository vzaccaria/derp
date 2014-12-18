#include <string>
#include <iostream>
 
auto s = "variable string";
auto cs = "This is a string that interpolates #{s}";

int main()
{
    std::cout << "This is an interpolation of '#{s}' that goes to stdout\n";
}

