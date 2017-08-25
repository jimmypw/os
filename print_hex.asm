; manipulate the characters of HEXOUT ('0x0000', 0) to print a 16 bit value
; The incoming value is stored in dx

; dx = incoming value
; cx = outgoing address
; bx = iteration count / offset
; ax = current value

print_hex:
  pusha                 ; Remember those registers
  mov bx, 0x00          ; 0'th iterations
  mov cx, HEXOUT + 0x2  ; look at the first value we need to modify

print_hex_loop:
  push bx               ; store the iteration count too keep it out of the way
  mov ax, dx            ; Get value of dx in to our working register ax
  shr ax, 8             ; shift the high 8 bits in to the low 8 bits
  and ax, 0x1           ; blank high 4 bits

  cmp ax, 0xa
  je hex_number         ; 0-9 + 48
  jge hex_string        ; a-f + 65 

print_hex_post_scale:
  mov cx, ax
  add [dx], 0x0001           ; loox at next value of incoming address
  add [cx], 0x0001           ; Loox at the next value of the outgoing address

  pop bx                ; restore the iteration count
  add bx, 0x1           ; increment the iteration count
  cmp bx, 0x3           ; 4 iterations only
  je print_hex_end      ; quit after 4 iterations
  jmp print_hex_loop    ; else process the next digit

print_hex_end:
  popa
  ret

hex_number:
  add ax, 0x30
  jmp print_hex_post_scale

hex_string:
  add ax, 0x41
  jmp print_hex_post_scale
