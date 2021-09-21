;*****************************************************************************************************************************
; Program name: "What_Is_The_Sum".  This program allow the user to calculate the sum of up to 100 integers, while also       *
; filtering for invalid response with each input .  Copyright (C) 2020 AJ Albrecht                                           *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;*****************************************************************************************************************************
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;Author name: AJ Albrecht
;Author email: ajalbrecht@fullerton.edu
;
;Program information
;  Program name: What_Is_The_Sum
;  Programming languages: C, C++, x86 Assembly and Bash
;  Date program began:     2020-Sep-22
;  Date program completed: 2020-Oct-3
;  Date comments upgraded: 2020-Oct-4
;  Files in this program: Main.c, Manager.asm, Input_Array.asm, isinteger.cpp, atol.asm, Display_Array.cpp, Sum.asm
;  Status: Complete.
;
;References for this program
;  Holiday, atol.asm, version 2.
;  Holiday, Control-D-Example, version 1.
;  Holiday, Integer Arithmetic, version 1.
;  Holiday, isinteger, version 1.
;  Holiday, Where arrays live, version 1.
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
;  Add up all imputed numbers and filter for invalid responses
;
;This file
;   File name: Sum.asm
;   Language: x86 Intel format
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm
;   Link: g++ -m64 -no-pie -o What_Is_The_Sum.out -std=c17 Main.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o Sum.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper


;Declare the names of programs called from this X86 source file, but whose own source code is not in this file.
extern printf
extern scanf

global sum

segment .data
;this file does not talk to the user

segment .bss
;The array is in the manager function

segment .text
sum:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.


;set up the loop values
mov qword rbx, 0     ;set times run counter to zero
mov qword rcx, 0     ;set summation total to zero
                     ;the times the program needs to run is in r14

;-----------------------------------------------------------------------------------
;Add all elements together loop
loop_again:
cmp rbx, r14              ; Has the loop added all elements? if so, stop the loop
jg exit_loop
add rcx, [r15 + rbx * 8]  ; Add the integer to the total
inc rbx
jmp loop_again            ; Loop again to initial condition
;----------------------------------------------------------------------------------
exit_loop:
mov qword rax, rcx         ;pass back the sum to the manager.

;Pass back the whole number sum
ret
