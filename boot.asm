[org 0x7c00]
BITS 16

HELLO_MSG:
  db "HELLO WOLD", 0

GOODBYE_MSG:
  db "GOODBYE WOLD", 0

HEXOUT:
  db "0x0000", 0

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

mov dx, 0x1f45
call print_hex
mov bx, HEXOUT
call print_string

jmp $                     ; Jump to this address forever

%include "print_string.asm"
%include "print_hex.asm"

times  510-($-$$) db 0    ; Pad the boot loader to 512 bytes
dw 0xaa55                 ; Boot sector magic number
