# derp [![NPM version](https://badge.fury.io/js/derp.svg)](http://badge.fury.io/js/derp)

> String interpolation for clang++ - Yet another post-pre processor

## Install globally with [npm](npmjs.org):

```bash
npm i -g derp
```

## General help 

```
Usage:
    derp [-f FILE]
    derp -h | --help 

Options:
    -f, --file FILE     If no <input> is passed, it is read from stdin

```

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

**Vittorio Zaccaria**
 

## License
Copyright (c) 2014 Vittorio Zaccaria  
Released under the BSD license

***

_This file was generated by [verb](https://github.com/assemble/verb) on December 18, 2014._
