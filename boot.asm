[org 0x7c00]
BITS 16

mov [BOOTDRIVE], bl    ; Store the boot drive set by BIOS

mov       bx,       HELLO_MSG
call      println

mov       bx,       GOODBYE_MSG
call      println

mov       dx,       [BOOTDRIVE]
call      print_hex_16

mov       bx,       HEXOUT
call      println

jmp       $                     ; Jump to this address forever

%include "string/print_string.asm"
%include "hex/print_hex.asm"

HELLO_MSG:
  db "HELLO WOLD", 0

GOODBYE_MSG:
  db "GOODBYE WOLD", 0

HEXOUT:
  db "0x0000", 0

BOOTDRIVE:
  db 0

times  510-($-$$) db 0    ; Pad the boot loader to 512 bytes
dw 0xaa55                 ; Boot sector magic number
