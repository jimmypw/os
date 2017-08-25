; manipulate the characters of HEXOUT ('0x0000', 0) to print an ascii value
; The incoming value is stored in dx

; dx = incoming value
; cx = unused
; bx = output (HEXOUT) offset 
; ax = working register

print_hex:
  pusha                         ; Remember those registers
  mov     bx,     0x02              ; 0'th iteration (Start from the second byte so we include the 0x already in the string)

  ; First Byte
  ; High Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     8               ; Reading from left to right select the first 2 bytes
  shr     ax,     4               ; rotate the bits to provide the 4 high bits
  call  append_al

  ; Low Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     8               ; Reading from left to right select the first 2 bytes
  call    append_al

  ; Second Byte
  ; High Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     4               ; rotate the bits to provide the 4 high bits
  call    append_al

  ; Low Bits
  mov     ax,     dx                  ; copy dx in to working register ax
  call    append_al

  popa  
  ret

append_al:
  and     ax,     0x0F                ; blank the remaining 4 high bits
  call    scale_number 
  mov     [HEXOUT + bx], ax       ; write out byte to string
  add     bx,     0x1             ; Increment the output poubter
  ret

scale_number:
  cmp     ax,     0x0a              ; is the resulting digit more than 10?
  jl      hex_number
  jmp     hex_string

scale_number_end:
  ret

hex_number:
  add     ax,     0x30              ; convert hex number to ascii code
  jmp     scale_number_end

hex_string:
  add     ax,     0x37              ; convert hex character to ascii code
  jmp     scale_number_end
