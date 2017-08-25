println:                          ; Alias for print + print_nl
  call      print_string
  call      print_nl
  ret


print:                            ; alias for print_string
print_string:                     ; print contents of bx to screen
  pusha                           ; save the registers
  mov       ah,       0x0e        ; scrolling tty

print_string_loop:
  mov       al,       [bx]        ; move contents of bx in to al
  cmp       al,       0x00        ; compare al against 0x00 (end of string)
  je        print_string_end      ; on string end jump to print_string_end
  int       0x10                  ; BIOS interrupt prints character at al
  add       bx,       0x01        ; increments the bx pointer
  jmp       print_string_loop     ; loop until null character is found

print_string_end:
  popa                            ; restore the registers
  ret                             ; return from function

print_nl:
  pusha                           ; Store regusters
  mov       ah,       0x0e        ; Scrolling tty functions
  mov       al,       0x0d        ; carriage return
  int       0x10                  ; print it
  mov       al,       0x0a        ; new line
  int       0x10                  ; print it
  popa                            ; restore registers
  ret                             ; return to calling function