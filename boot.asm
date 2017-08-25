[org 0x7c00]
BITS 16

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $                     ; Jump to this address forever

%include "print_string.asm"

HELLO_MSG:
  db "HELLO WOLD", 0

GOODBYE_MSG:
  db "GOODBYE WOLD", 0

times  510-($-$$) db 0    ; Pad the boot loader to 512 bytes
dw 0xaa55                 ; Boot sector magic number
