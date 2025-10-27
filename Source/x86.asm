;--------------------------------------------------------
; Fixed MASM32 Assembly - Compiles cleanly with ml 6.14
;--------------------------------------------------------

.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.data
    helloMsg    db "Hello world", 10, 0      ; "Hello world\n"
    fmtInt      db "%d", 10, 0               ; "%d\n"
    charG       db "G", 0
    charL       db "L", 0
    a           dd 1
    b           dd 2

.data?
    sum         dd ?

.code
main PROC
    ;-----------------------------------
    ; printf("Hello world\n");
    ;-----------------------------------
    push offset helloMsg
    call crt_printf
    add esp, 4

    ;-----------------------------------
    ; printf("%d\n", a + b);
    ;-----------------------------------
    mov eax, a
    add eax, b
    mov sum, eax

    push sum
    push offset fmtInt
    call crt_printf
    add esp, 8

    ;-----------------------------------
    ; if (a > b)
    ;-----------------------------------
    mov eax, a
    cmp eax, b
    jle else_part      ; jump if a <= b

then_part:
    push offset charG
    call crt_printf
    add esp, 4
    jmp end_if

else_part:
    push offset charL
    call crt_printf
    add esp, 4

end_if:
    ;-----------------------------------
    ; return 0;
    ;-----------------------------------
    push 0
    call ExitProcess
main ENDP

END main
