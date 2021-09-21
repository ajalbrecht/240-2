//*****************************************************************************************************************************
// Program name: "What_Is_The_Sum".  This program allow the user to calculate the sum of up to 100 integers, while also       *
// filtering for invalid response with each input .  Copyright (C) 2020 AJ Albrecht                                           *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//*****************************************************************************************************************************
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//Author name: AJ Albrecht
//Author email: ajalbrecht@fullerton.edu
//
//Program information
//  Program name: What_Is_The_Sum
//  Programming languages: C, C++, x86 Assembly and Bash
//  Date program began:     2020-Sep-22
//  Date program completed: 2020-Oct-3
//  Date comments upgraded: 2020-Oct-4
//  Files in this program: Main.c, Manager.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, Sum.asm
//  Status: Complete.
//
//References for this program
//  Holiday, atol.asm, version 2.
// Holiday, Control-D-Example, version 1.
//  Holiday, Integer Arithmetic, version 1.
//  Holiday, isinteger, version 1.
//  Holiday, Where arrays live, version 1.
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
//  Add up all imputed numbers and filter for invalid responses
//
//This file
//   File name: Main.c
//   Language: C
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c17
//   Link: g++ -m64 -no-pie -o What_Is_The_Sum.out -std=c17 Main.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o Sum.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper


#include <stdio.h>
#include <stdint.h>

extern int manager();

int main() {
  // stores result from manager file
  long int result;

  // inroduce the user to the program
  printf("%s\n", "Welcome to Arrays of Integers");
  printf("%s\n\n", "Bought to you by AJ Albrecht");

  // call manager to do organize the result
  result = manager();

  // end the program
  printf("%s%ld%s\n", "The main received ", result, " and is not sure what to do with it");
  printf("%s\n", "Main will return 0 to the operating system.   Bye.");
  return 0;
}
