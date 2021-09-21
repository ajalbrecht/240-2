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
;   File name: Manager.asm
;   Language: x86 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Manager.lis -o Manager.o Manager.asm
;   Link: g++ -m64 -no-pie -o What_Is_The_Sum.out -std=c17 Main.o Manager.o Input_Array.o isinteger.o atol.o Display_Array.o Sum.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper


global manager

;Declare the names of programs called in other files
extern printf
extern scanf
extern input_array
extern sum
extern display_array

segment .data
stringoutputformat db "%s", 0
info1 db "This program will sum your array of integers", 10, 0
info2 db "Enter a sequence of long integers separated by white space.", 10, 0
info3 db "After the last input press enter followed by Control+D:", 10, 0
;user inputs array
userinputresult db 10, "These number were received and placed into the array:", 10, 0
;the following two lines make up one line of text
number db "The sum of the %ld", 0
total db " numbers in this array is %ld", 10, 10, 0
goodbye db "The sum will now be returned to the main function.", 10, 10, 0

segment .bss
array: resq 100				; 100 - reserving 100 qwords

segment .text
manager:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
;Prolog  Back up the GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;register usesage list
;r15 - array
;r14 - amount of numbers systems
;r13 - temporary array responses -> sum of numbers
;rbx and rcx - control sum loop in sum file

;place the array into a registers
mov r15, array

;write 1st line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info1
mov qword rax, 0
call printf

;write 2nd line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info2
mov qword rax, 0
call printf

;write 3rd line of program usage information
mov qword rdi, stringoutputformat
mov qword rsi, info3
mov qword rax, 0
call printf

;call input array function and save the amount of responses into r14
mov rax, 0
call input_array

;write confirmatin mesage
mov qword rdi, stringoutputformat
mov qword rsi, userinputresult
mov qword rax, 0
call printf

;call display array to write out all response in array
mov rdi, r15  ;pass in array
mov rsi, r14  ;pass in amount of elements within array
mov rax, 0
call display_array

;call summation function to add all array values together
mov rax, 0
call sum
mov r13, rax

;display ammount of user inputs (1/2)
mov qword rdi, number
mov qword rsi, r14
mov qword rdx, r14
mov qword rax, 0
call printf

;display total of all values added together (2/2)
mov qword rdi, total
mov qword rsi, r13
mov qword rdx, r13
mov qword rax, 0
call printf

;write final informative message to user for this file
mov qword rdi, stringoutputformat
mov qword rsi, goodbye
mov qword rax, 0
call printf

;save the whole number response in rax, so it can be sent to main.c
mov qword rax, r13

;Restore the original values to the general registers before returning to the caller.
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp               ;Restore the base pointer of the stack frame of the caller.

;pass back the whole number
ret
