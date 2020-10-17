# Dillon's n64 tests
A WIP N64 test suite designed for young emulators

## Building
All tests are written for [this fork of bass](https://github.com/ARM9/bass).

They also require [chksum64]https://github.com/DragonMinded/libdragon/blob/trunk/tools/chksum64.c) to boot.

To build, simply run `make` after both of these tools have been placed on the PATH. You'll probably have to compile them both yourself, I doubt they'd be in your distribution's package manager.

## Running
This project is still far too young to worry about running these yet. Come back later.

## TODO
- "Fuzzer" tests testing large numbers of cases
- Basic RSP test testing similar cases to the basic CPU test
- Documentation on how to skip the bootcode and run the tests for very young emulators
- CI to automatically build the roms