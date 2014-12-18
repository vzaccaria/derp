# {%= name %} {%= badge("fury") %}

> {%= description %}

{%= include("install-global") %}

## General help 

```
{%= partial("usage.md") %}
```

This is just a post processor to be run after clang++ preprocessor (-E option).

## Example

Assume the following c++ file (`example.cxx`):

```c++
#include <string>
#include <iostream>
 
auto s = "variable string";

int main()
{
    std::cout << "This is an interpolation of '#{s}' that goes to stdout\n";
}

```

Compile it with:

    > clang++ --std=c++11 -E example.cxx | derp > example.c++ &&  clang++ -o example --std=c++11 example.c++

And then run it:

    > ./example 
    This is an interpolation of 'variable string' that goes to stdout

## Author
{%= include("author") %}

## License
{%= copyright() %}
{%= license() %}

***

{%= include("footer") %}
