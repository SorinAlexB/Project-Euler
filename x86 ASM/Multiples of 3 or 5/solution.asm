%include "../utils/printf32.asm"

section .data
    N dd 1000
    three dw 3
    five dw 5

section .text
    extern printf
    global main

main:
    push ebp
    mov ebp, esp

    xor ecx, ecx
    mov ecx, dword [N]
    xor ebx, ebx

sum_loop:
    xor eax, eax
    xor edx, edx

    mov eax, ecx
    push ecx
    xor ecx, ecx
    mov cx, [three]
    push eax
    div cx
    pop eax
    pop ecx
    cmp edx, 0
    je div_three

    xor edx, edx
    push ecx
    xor ecx, ecx
    mov cx, [five]
    div cx
    pop ecx
    cmp edx, 0
    je div_five
    
    sub ecx, 1
    cmp ecx, 0
    jg sum_loop

    jmp print

div_three:
    add ebx, ecx
    sub ecx, 1
    jmp sum_loop

div_five:
    add ebx, ecx
    sub ecx, 1
    jmp sum_loop

print:
    PRINTF32 `%u\n\x0`, ebx
    
    leave 
    ret

