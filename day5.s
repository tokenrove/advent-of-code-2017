;;; -*- nasm-mode -*-

bits 16

org 0x7C00
section .text

        data equ 0x8000
        data_part_2 equ 0x6000
        data_len equ data_end - data_begin
        data_len_in_segments equ (data_len + 511)/512

start:  mov sp, 0x2000
        xor ax, ax
        mov es, ax
        mov ah, 2
        mov al, data_len_in_segments
        mov cx, 2
        mov bx, data
        int 0x13

        mov di, data_part_2
        mov si, data
        mov cx, data_len/2
        rep movsw

        mov word [0x14], bounds_check_failed
        mov word [0x16], cs

part_1: mov si, data
        mov word [data-4], si
        mov word [data-2], data+data_len-1
        xor edx, edx
.forever:
        inc word [ds:si]
        lodsw
        lea esi, [esi+2*eax-4]
        inc edx
        bound si, [data-4]
        jmp .forever

part_2: mov si, data_part_2
        mov word [data-4], si
        mov word [data-2], data_part_2+data_len-1
        xor edx, edx
.forever:
        lodsw
        cmp ax, 3
        setl bl
        add bl, bl
        dec bl
        movsx bx, bl
        add word [ds:si-2], bx
        lea esi, [esi+2*eax-2]
        inc edx
        bound si, [data-4]
        jmp .forever

.never: jmp .never

bounds_check_failed:
        call inspect
        mov al, 0xd
        call putc
        mov al, 0xa
        call putc
        mov di, sp
        add word [cs:di], 6
        iret
.forever: jmp .forever

inspect:
        mov eax, edx
        mov ebx, 10
        xor cx, cx
.digit: xor edx, edx
        div ebx
        push dx
        inc cx
        cmp eax, 0
        jne .digit
.print: pop ax
        add al, 0x30
        call putc
        loop .print
        ret

putc:   mov ah, 0xe
        xor bx, bx
        int 0x10
        ret

        times 510-($-$$) db 0
signature: dw 0xAA55

data_begin:
%include "day5.data.s"
data_end:
