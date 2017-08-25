; manipulate the characters of HEXOUT ('0x0000', 0) to print an ascii value
; The incoming value is stored in dx

; dx = incoming value
; cx = unused
; bx = output (HEXOUT) offset 
; ax = working register

print_hex_16:
  pusha                           ; Remember those registers
  mov     bx,     0x02            ; 0'th iteration (Start from the second byte so we include the 0x already in the string)

  ; First Byte
  ; High Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     12              ; Reading from left to right select the first 2 bytes
  call    append_al               ; append al on to HEXOUT

  ; Low Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     8               ; Reading from left to right select the first 2 bytes
  call    append_al               ; append al on to HEXOUT

  ; Second Byte
  ; High Bits
  mov     ax,     dx              ; copy dx in to working register ax
  shr     ax,     4               ; rotate the bits to provide the 4 high bits
  call    append_al               ; append al on to HEXOUT

  ; Low Bits
  mov     ax,     dx              ; copy dx in to working register ax
  call    append_al               ; append al on to HEXOUT

  popa  
  ret

append_al:
  and     ax,     0x0F            ; blank the remaining 4 high bits
  call    scale_number            ; scale the hex digit in to an ascii character
  mov     [HEXOUT + bx], ax       ; write out byte to string
  add     bx,     0x1             ; Increment the output poubter
  ret                             ; return to print_hex

scale_number:
  cmp     ax,     0x0a            ; is the resulting digit more than 9?
  jl      scale_hex_number        ; jump if number (0-9)
  jmp     scale_hex_letter        ; jump if letter (a-f)

scale_number_end:                 ; return here in every case
  ret                             ; return to append_al

scale_hex_number:
  add     ax,     0x30            ; convert hex number to ascii code
  jmp     scale_number_end        ; finish the function  

scale_hex_letter:
  add     ax,     0x37            ; convert hex character to ascii code
  jmp     scale_number_end
