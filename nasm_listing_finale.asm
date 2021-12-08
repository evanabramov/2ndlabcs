section .text

global _start

_start:

    mov ebx, 16
    call print_f
    mov ebx, 2
    call print_f

    mov cl, 6
    
    startloop:
    cmp cl, 32
    jb func

    mov ebx, 16
    call print_f
    mov ebx, 2
    call print_f

    mov eax, 1
    xor ebx, ebx
    int 0x80

    func:
    call the_action_itself
    add cl, 9
    jmp startloop   
    
    
    
    ; дальше вывод числа
    print_f:
    mov eax, [num] ; число для вывода
    mov ebx, ebx     ; система счисления
    call print
    ret

    print:
    mov ecx, esp
    sub esp, 36   ; резервируем место в памяти для строки с числами, (esp - указатель на стэк)

    mov edi, 1
    dec ecx
    mov [ecx], byte 10

    print_loop:

    xor edx, edx
    div ebx ; edx:eax by ebx
    cmp dl, 9     ; если остаток > 9 переходим на use_letter
    jg use_letter

    add dl, '0'
    jmp after_use_letter

    use_letter:
    add dl, 'W'   ; буквы от 'a' до ... в ascii code

    after_use_letter:
    dec ecx
    inc edi
    mov [ecx], dl
    test eax, eax
    jnz print_loop

    ; системный вызов вывода, ecx - указатель на строку
    mov eax, 4    ; номер системного вызова (sys_write)
    mov ebx, 1    ; дескриптор вызова (stdout)
    mov edx, edi  ; длина строки
    int 0x80

    add esp, 36   ; освобождаем память, где была строка с числами
    ret
    
    the_action_itself:
    mov edx, [num]
    
    mov eax, edx
    sar eax, cl
    mov ebx, eax
    mov eax, edx
    add cl, 2
    sar eax, cl
    xor eax, ebx
    
    mov edx, 1
    and edx, eax
    
    mov eax, edx
    mov ebx, edx
    
    sub cl, 2
    sal eax, cl
    add cl, 2
    sal ebx, cl
    sub cl, 2
    or eax, ebx
    mov edx, [num]
    xor edx, eax
    
    mov [num], edx
    
    ret

section .data

num DD 0xd5ad6abf

segment .bss