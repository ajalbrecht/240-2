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
;   File name: Input_Array.asm
;   Language: x86 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Input_array.lis -o Input_array.o Input_array.asm
;   Link: g++ -m64 -no-pie -o What_Is_The_Sum.out -std=c17 Main.o Manager.o Input_array.o isinteger.o atol.o Display_Array.o Sum.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper


;Declare the names of programs called in this file.
extern printf
extern scanf
extern isinteger
extern atolong

global input_array

segment .data
stringoutputformat db "%s", 0 ;writes
stringinputformat db "%s",0 ; inputs
numberFormat db "%ld", 10, 0 ; %ld means any digit
invalid db "The last input was invalid and not entered into the array.", 10, 0
;info db "%ld", 10, 0

segment .bss
;the array is located in the manager file and is currently in r15

segment .text
sub rsp, 128
input_array:

;initialize all values for the loop ahead
mov r14, 0   ;initialize loop counter
mov r12, 0
;rsp = r13   ;pointer to value thought the loop

;the symbols used by each jmp can be used as a guide to where it loops back to.
;-----------------------------------------------------------------------------------------
;The following block is one logical loop that check the user response to determine when to
;exit the loop, take a response or reject a response due to an invalid character.
;take in the user response
run_again:                                    ;re run loop entry point
mov qword rdi, stringinputformat
push qword 0
mov qword rsi, rsp
mov qword rax, 0
call scanf
;Evaluate the response =========================================
;Did the user ask to stop the loop by pressing ctrld? ==========
cdqe
cmp rax, -1
je end_loop ; if ctrld is detected, get out of the loop ====end======

;verify that the incoming response is an integer. ==============
mov rax,0
mov rdi,rsp       ; pointer to stack, which contains r13s
call isinteger    ; call is integer function to verify if the number is an integer
mov r12,rax
;Evaluate the response =========================================
;Was the response entered an integer? ==========================
cmp r12, 1
je valid          ; If so, move over to the input block ////////

;If the response was not valid, ask the user to try again ======
;error message
mov qword rdi, stringoutputformat
mov qword rsi, invalid
mov qword rax, 0
call printf
pop rax
jmp run_again   ; Return to top of loop for next response --------------

;/////////////////////////////////////////////////////////////////////
; If the response is valid, convert the string to an integer
valid:
mov rax, 0
mov rdi,rsp     ;pointer to the stack
call atolong
mov r13, rax    ;the converted string to integer has been replaced with an int

;Input the response into the array
pop qword r12 ; dummy pop to balance stack
mov [r15 + (8 * r14)], r13
inc r14
jmp run_again ; loop again and ask for the next integer --------------
;//////////////////////////////////////////////////////////////////////
;---------------------------------------------------------------------------------------

;=============================end==================================
;The loop is done, and the user has pressed control d
end_loop:
pop rax
mov rax, r14     ;pass back the amount of times run to the main function

;pass back the amount of numbers in the array
ret
