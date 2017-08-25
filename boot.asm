[org 0x7c00]
BITS 16

HELLO_MSG:
  db "HELLO WOLD", 0

GOODBYE_MSG:
  db "GOODBYE WOLD", 0

HEXOUT:
  db "0x0000", 0

mov       bx,       HELLO_MSG
call      println

mov       bx,       GOODBYE_MSG
call      println

mov       dx,       0xbee1
call      print_hex_16

mov       bx,       HEXOUT
call      println

jmp       $                     ; Jump to this address forever

%include "print_string.asm"
%include "print_hex.asm"

times  510-($-$$) db 0    ; Pad the boot loader to 512 bytes
dw 0xaa55                 ; Boot sector magic number
