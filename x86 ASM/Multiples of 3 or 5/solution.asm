
section .data
    N dw 1000
    three db 3
    five db 5

section .text
    global main

main:
    mov cx, word [N]
    xor ebx, ebx

sum_loop:
    xor eax, eax
    xor edx, edx
    mov ax, cx
    mov dx, ax
    mov edi, [three]
    shr edx, 8
    shl eax, 8
    push edx
    push eax
    div edi
    cmp edx, 0
    je div_three
    pop eax
    pop edx
    mov edi, [five]
    div edi
    cmp edx, 0
    je div_five
    loop sum_loop

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
    ; write syscall
    mov ecx, ebx ; message to write
    mov edx, 16 ; message length
    mov eax, 4 ; syscall number (sys_write)
    mov ebx, 1 ; file descriptor (stdout)
    int 0x80 ; call kernel

    ; exit syscall
    mov eax, 1 ; syscall number (sys_exit)
    xor ebx, ebx ; exit code
    int 0x80 ; call kernel
    
    leave 
    ret

