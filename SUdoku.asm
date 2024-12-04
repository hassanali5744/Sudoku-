org 0x0100

jmp start
checkcount db 0
abc: times 2500 dw 0
rowcount2 dw 0
bottom: times 4000 dw 0
linecheck dw 0
nmatch dw 0
nmatch11 dw 0
ndmatch dw 0
ndmatch1 dw 0
nmatch1 dw 0
undocount11 dw 0
undocount111 dw 0
msg1: db 'Created By: Hassan Ali (23L-0859)', 0
undocount dw 0
undocount1 dw 0
menuTitle  db '>> Home Page <<', 0
play_game   db 'Play Game', 0
play_game_highlighted db 'Play Game', 0
instructions db 'Instructions', 0
instructions_highlighted db 'Instructions', 0
quit_game   db 'Quit Game', 0
quit_game_highlighted db 'Quit Game', 0
chooseMsg   db 'Choose an option by press enter: ', 0
title       db '->->->WELCOME TO SUDOKU<-<-<-', 0
playMsg     db 'Play Sudoku Mate..', 0
play1Msg    db 'Score: ',0
play1   db 'Mistake Count: ',0
undomsg db 'Undo Count: ', 0
ucnt dw 4
play2Msg    db 'Timer: ',0
instr1Msg    db 'The instructions to play Sudoku are given below:',0
instr2Msg    db 'Press ESC if you want to go back to Home page',0
instrMsg    db 'Sudoku is a popular puzzle game that challenges players to fill a 9x9 grid with numbers. The objective is to ensure each row, column, and 3x3 subgrid contains the digits 1 through 9 without any repetitions. Players use logical reasoning and deduction to solve the puzzle, starting with the given numbers. As you progress, look for opportunities to eliminate possibilities and find placements for each number. The satisfaction of completing a Sudoku puzzle comes from the mental challenge it presents. Enjoy honing your problem-solving skills with this engaging game!!.', 0
quitMsg     db 'Quitting game...', 0
gameover    db 'Game Over...', 0
overcount3 dw 0
Logo db 'S   U   D   O   K   U',0
Tip db '->->TIP<-<-', 0
tip0 db '-> Once you start the game,you have 5 chances for the mistake' , 0
tip00 db '-> You can undo your move 4 times in the game', 0
tip1 db '-> On adding a repetitive entry, mistake count will increase.', 0
tip2 db '-> When mistake counts equals 5, Game will be over', 0
tip3 db '-> Press F for Undo,C for Nodes,Z for scrolling, R to restart', 0
match dw 0
match1 dw 0
match11 dw 0
dmatch dw 0
dmatch1 dw 0,0,0,0
dmatch11 dw 0,0,0,0
number_pos dw 0 
 right_count db 0
 last_move db 0 
 right_press_count db 0
 last_direction db 0
rowcount dw 0
coulmncount db 1
overcount2 dw 0
check db 0
numbers db '1','2','3','4','5','6','7','8','9', 0
msg dw 5,14,23,32,40,48,57,66,74
state db 0
counterMin: dw 0      
counterSec: dw 0      
counterMS:  dw 0      

isPaused:   db 0  
selected_number db 1   

PlayVaryingTone:
    mov bx, ax           

PlayLoop:
    mov al, 0b10110110   
    out 43h, al          
    mov ax, bx           
    out 42h, al          
    mov al, ah
    out 42h, al          

    in al, 61h           
    or al, 00000011b     
    out 61h, al          

    push cx              
    mov cx, 1200         
DelayLoop:
    dec cx
    jnz DelayLoop
    pop cx               

    in al, 61h           
    and al, 11111100b    
    out 61h, al          

    add bx, dx           
    loop PlayLoop        
    ret
	l111:
	noteDivisor dw 0
NoteC4 equ 261   
NoteB3 equ 247    
NoteA3 equ 220   
NoteG3 equ 196     
NoteF3 equ 675
NoteF4 equ 175     
NoteD4 equ 293     
NoteE4 equ 329    
DivisorC4 equ 1193180 / NoteC4     
DivisorB3 equ 1193180 / NoteB3     
DivisorA3 equ 1193180 / NoteA3      
DivisorG3 equ 1193180 / NoteG3     
DivisorF3 equ 1193180 / NoteF3    
DivisorD4 equ 1193180 / NoteD4      
DivisorE4 equ 1193180 / NoteE4  
   
PlayNote:
    mov al, 03h        
    out 61h, al         

    mov al, 0xB6        
    out 43h, al         

    mov ax, [noteDivisor]
    out 42h, al          
    shr ax, 8        
    out 42h, al       

    ret

StopSound:
    mov al, 00h         
    out 61h, al     
    ret

PlayLosingMelody:
    mov cx, 2       

playNextNote:
    mov dx, cx
    cmp dx, 8
    je playNoteC4   
    cmp dx, 7
    je playNoteB3  
    cmp dx, 6
    je playNoteA3  
    cmp dx, 5
    je playNoteG3   
    cmp dx, 4
    je playNoteF3   
    cmp dx, 3
    je playNoteG3  
    cmp dx, 2
    je playNoteA3   
    cmp dx, 1
    je playNoteB3   

playNoteC4:
    mov word [noteDivisor], DivisorC4  
    jmp playAndDelay
playNoteB3:
    mov word [noteDivisor], DivisorB3  
    jmp playAndDelay
playNoteA3:
    mov word [noteDivisor], DivisorA3  
    jmp playAndDelay
playNoteG3:
    mov word [noteDivisor], DivisorG3  
    jmp playAndDelay
playNoteF3:
    mov word [noteDivisor], DivisorF3  
    jmp playAndDelay

playAndDelay:
    call PlayNote
    call DelayShort   
    dec cx
    jnz playNextNote   
    ret

RepeatLosingMelody:
    call PlayLosingMelody  
    call PlayLosingMelody  
    ret

PlayDhooDhoo:

    mov word [noteDivisor], DivisorD4 
    call PlayNote
    call DelayShort

    mov word [noteDivisor], DivisorD4  
    call PlayNote
    call DelayShort

    mov word [noteDivisor], DivisorE4  
    mov cx, 5 
playDo:
    call PlayNote
    call DelayShort
    dec cx
    jnz playDo
    ret

DelayShort:
    push cx
    push dx
    mov cx, 150          
    mov dx, 1000         
delayShortOuter:
    push cx              
    mov cx, dx           
delayShortInner:
    nop              
    loop delayShortInner
    pop cx           
    loop delayShortOuter
    pop dx
    pop cx
    ret

PlayNote2:
    mov al, 03h        
    out 61h, al         

    mov al, 0xB6        
    out 43h, al         

    mov ax, [noteDivisor]
    out 42h, al          
    shr ax, 8        
    out 42h, al       

    ret

StopSound2:
    mov al, 00h         
    out 61h, al     
    ret

PlayLosingMelody2:
    mov cx, 8       

playNextNote2:
    mov dx, cx
    cmp dx, 8
    je playNoteC42   
    cmp dx, 7
    je playNoteB32 
    cmp dx, 6
    je playNoteA32 
    cmp dx, 5
    je playNoteG32  
    cmp dx, 4
    je playNoteF32  
    cmp dx, 3
    je playNoteG32  
    cmp dx, 2
    je playNoteA32  
    cmp dx, 1
    je playNoteB32  

playNoteC42:
    mov word [noteDivisor], DivisorC4  
    jmp playAndDelay2
playNoteB32:
    mov word [noteDivisor], DivisorB3  
    jmp playAndDelay2
playNoteA32:
    mov word [noteDivisor], DivisorA3  
    jmp playAndDelay2
playNoteG32:
    mov word [noteDivisor], DivisorG3  
    jmp playAndDelay2
playNoteF32:
    mov word [noteDivisor], DivisorF3  
    jmp playAndDelay2

playAndDelay2:
    call PlayNote2
    call DelayShort2   
    dec cx
    jnz playNextNote2   
    ret

RepeatLosingMelody2:
    call PlayLosingMelody2  
    call PlayLosingMelody2  
    ret

PlayDhooDhoo2:

    mov word [noteDivisor], DivisorD4 
    call PlayNote2
    call DelayShort2

    mov word [noteDivisor], DivisorD4  
    call PlayNote2
    call DelayShort2

    mov word [noteDivisor], DivisorE4  
    mov cx, 5 
playDo2:
    call PlayNote2
    call DelayShort2
    dec cx
    jnz playDo2
    ret

DelayShort2:
    push cx
    push dx
    mov cx, 150          
    mov dx, 1000         
delayShortOuter2:
    push cx              
    mov cx, dx           
delayShortInner2:
    nop              
    loop delayShortInner2
    pop cx           
    loop delayShortOuter2
    pop dx
    pop cx
    ret

printCounter: pusha
              push es
              mov ax, 0xb800
              mov es, ax
              mov di, 160 ; Location of the counter
			  mov bx, 10
              push word [counterMin]
              push di
              call printNum
              add di, 6
              mov byte [es:di-84], ':'
              push word [counterSec]
              add di, 6
              push di
              call printNum
			  
              pop es
              popa
              ret
printNum:
 push bp
          mov bp, sp
          pusha
          push es
          mov ax, 0xb800
          mov es, ax
          mov di, [bp+4]
          mov ax, [bp+6]
          mov bx, 10
          mov cx, 0
nextdigit: mov dx, 0
           div bx
           add dl, '0'
           push dx
           inc cx
           cmp ax, 0
           jnz nextdigit

printDigits: pop dx
             mov dh, 0x07
			 
             mov [es:di-84], dx
             add di, 2
             loop printDigits

          pop es
          popa
          pop bp
          ret 4

clockISR:
 pusha
          cmp byte [isPaused], 1
          je clockEOI
          mov ax, [counterMin]
          cmp ax, 2
          jne incrementTime
          mov ax, [counterSec]
          cmp ax, 0
          jne incrementTime
          mov ax, [counterMS]
          cmp ax, 0
          jne incrementTime
          mov byte [isPaused], 1
          jmp clockEOI
incrementTime:
          add word [counterMS], 55
          cmp word [counterMS], 1000
          jl updateTime

          mov word [counterMS], 0
          inc word [counterSec]

updateTime: cmp word [counterSec], 60
            jl clockUpdate

            mov word [counterSec], 0
            inc word [counterMin]
clockUpdate: call printCounter

clockEOI: mov al, 0x20
          out 0x20, al
          popa
          iret

keyboardISR: pusha
             in al, 0x60
             cmp al, 25 ; P key to pause
             je togglePause

             cmp al, 19 ; R key to reset
             je resetCounter
             jmp keyboardEOI

togglePause: xor byte [isPaused], 1
             jmp keyboardEOI

resetCounter: mov word [counterMin], 0
              mov word [counterSec], 0
              mov word [counterMS], 0
              mov byte [isPaused], 0
              call printCounter
              jmp keyboardEOI
keyboardEOI: mov al, 0x20
             out 0x20, al
             popa
             iret
selected_option db 0
  draw_number_buttons:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push es

    mov ax, 0b800h
    mov es, ax

    mov cx, 9                          ; Number of buttons to draw
    mov si, numbers                    ; Point to the numbers array
    mov di, (23 * 80 * 2) + (20 * 2)   ; Start position: row 26, column 10

    mov bl, [selected_number]          ; Load the selected number

draw_next_button:
    push cx
    mov al, [si]
    sub al, '0'                        ; Convert character to number
    cmp al, bl
    jne .draw_normal_button
    mov ah, 40h                        ; Attribute for highlighted text
    jmp .draw_button

.draw_normal_button:
    mov ah, 07h                      
.draw_button:
    ; Draw the button '[n]'
    mov al, '['
    mov [es:di], ax
    add di, 2

    mov al, [si]                 
    mov [es:di], ax
    add di, 2

    mov al, ']'
    mov [es:di], ax
    add di, 2
    add di, 2

    inc si                             ; Move to the next number
    pop cx
    loop draw_next_button

    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

sleep: push cx
mov cx, 0xFFFF
delay: loop delay
pop cx
ret
clr:
    push es
    push di
    mov ax, 0b800h
    mov es, ax
    mov di, 0

nextloc:
    mov word [es:di], 0x0720
    add di, 2
    cmp di, 4000
    jne nextloc

    pop di
    pop es
    ret

draw_9x9_grid:
    push ax
    push bx
    push cx
    push dx
    push di
    push es

    mov ax, 0b800h
    mov es, ax

    mov di, (2 * 80 * 2) ; Start at row 4 (to position grid below the message)
    call draw_thick_horizontal_line
    mov di, (17 * 80 * 2)
    call draw_thick_horizontal_line


	mov di, (3 * 80 * 2)
    add di, 48
	call draw_single_vertical_line
	mov di, (3 * 80 * 2)
    add di, 96
	call draw_single_vertical_line

	mov di, (3 * 80 * 2)
    add di, 16
	call draw_small_vertical_line
	mov di, (3 * 80 * 2)
    add di, 32
	call draw_small_vertical_line
	mov di, (3 * 80 * 2)
    add di,64
	call draw_small_vertical_line
	mov di, (3 * 80 * 2)
    add di, 80
	call draw_small_vertical_line
	mov di, (3 * 80 * 2)
    add di, 112
	call draw_small_vertical_line
	mov di, (3 * 80 * 2) ; Start at row 4 (position to draw the line)
    add di, 128
	call draw_small_vertical_line
	mov di, (7 * 80 * 2) ; Start at row 4 (to position grid below the message)
	add di,2
    call draw_break_horizontal_line
    mov di, (12	* 80 * 2)
	add di,2
    call draw_break_horizontal_line
    mov di, (22 * 80 * 2)
	add di,2
    call draw_break_horizontal_line
     mov si,Logo
	 mov di, (2 * 80 * 2)+110
	 call PrintStringManualCentered1
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret

draw_thick_horizontal_line:
    mov cx, 72
    mov al, '-'
.thick_horiz_line_loop:
    mov ah, 4Eh
    mov [es:di], ax
    add di, 2
    loop .thick_horiz_line_loop
    ret

draw_break_horizontal_line:
sub di,2
    mov cx, 72
    mov al, ' '
.break_horiz_line_loop:
    mov ah, 39h
    mov [es:di], ax
    add di, 2
    loop .break_horiz_line_loop
    ret

draw_single_vertical_line:
    push ax
    push di
    push es
    mov cx, 20
.draw_vert_line_loop:
    mov al, 20h
    mov ah, 2Ah
    mov [es:di], ax
    add di, 160
    loop .draw_vert_line_loop
    pop es
    pop di
    pop ax
    ret

draw_small_vertical_line:
    push ax
    push di
    push es
    mov cx, 20
.draw_vert_line_loop:
    mov al, 10h
    mov ah, 0Eh
    mov [es:di], ax
    add di, 160
    loop .draw_vert_line_loop
    pop es
    pop di
    pop ax
    ret

hacode:
push di
pusha

mov di, (4 * 80)* 2  +20 ; Set DI for Row 3, Column 3
    mov ax, '7' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax   
mov di, (4 * 80)* 2  +132 ; Set DI for Row 3, Column 3
    mov ax, '4' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (4 * 80)* 2  +84 ; Set DI for Row 3, Column 3
    mov ax, '3' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (4 * 80)* 2  +52 ; Set DI for Row 3, Column 3
    mov ax, '1' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (9 * 80)* 2  +20 ; Set DI for Row 3, Column 3
    mov ax, '9' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (9 * 80)* 2  +100; Set DI for Row 3, Column 3
    mov ax, '5' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (14 * 80)* 2  +84 ; Set DI for Row 3, Column 3
    mov ax, '7' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (19 * 80)* 2  +132 ; Set DI for Row 3, Column 3
    mov ax, '7' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
popa
pop di
ret	
hacode1:
push di
pusha

mov di, (2 * 80)* 2  +20 ; Set DI for Row 3, Column 3
    mov ax, '3' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax   
mov di, (10 * 80)* 2  +132 ; Set DI for Row 3, Column 3
    mov ax, '4' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (10 * 80)* 2  +84 ; Set DI for Row 3, Column 3
    mov ax, '3' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (2 * 80)* 2  +52 ; Set DI for Row 3, Column 3
    mov ax, '1' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (14 * 80)* 2  +20 ; Set DI for Row 3, Column 3
    mov ax, '9' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (18 * 80)* 2  +100; Set DI for Row 3, Column 3
    mov ax, '5' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (6 * 80)* 2  +84 ; Set DI for Row 3, Column 3
    mov ax, '7' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
	mov di, (22 * 80)* 2  +132 ; Set DI for Row 3, Column 3
    mov ax, '7' + (7 << 8)       ; Dot '.' with light gray attribute
    mov [es:di+164], ax 
popa
pop di
ret	
add_numbers_to_grid:
mov ax, 0
       mov es, ax
       
      
       mov word [es:8*4], clockISR
       mov [es:8*4+2], cs
       
    
       call printCounter
  
    mov ax, 0b800h
    mov es, ax
	mov bp ,msg
	mov si,0
	
mov ax, 0xB800
mov es, ax
mov al, ' '
mov ah, 0x4E

mov di, (4 * 80) * 2 + 4
call WriteChar
 call hacode         ; Write dot to video memory
mainloop1:
mov dx, 0
main_loop:
mov ah, 0x00
int 0x16

cmp al, '1'
je place_char
cmp al, '2'
je place_char
cmp al, '3'
je place_char
cmp al, '4'
je place_char
cmp al, '5'
je place_char
cmp al, '6'
je place_char
cmp al, '7'
je place_char
cmp al, '8'
je place_char
cmp al, '9'
je place_char
cmp al, 'r'
je PlayGame

cmp ah, 0x2E
    je switch_to_grid11

    cmp ah, 0x2C
    je clrBoxxx
	
cmp ah, 0x11
je move_up1
cmp ah, 0x1F
je move_down1
cmp ah, 0x1E
je move_left1
cmp ah, 0x20
je move_right1
cmp ah,0x21
je ddd

jmp main_loop

ddd:
push si
push di
dec word[ucnt]
mov si, [ucnt]
mov di, (23*80*2)+24
call PrintNumber
pop di
pop si
jmp undo1
undo1:
cmp word[undocount1],1
je agla
cmp word[undocount1],2
je agla1
cmp word[undocount1],0
je agla0
cmp word[undocount1],3
je agla3
agla3:
inc word[undocount1]
call clrBox
mov di,[dmatch1]
sub word [overcount2],5
jmp hoo
agla0:
inc word[undocount1]
call clrBox
mov di,[dmatch1+6]
sub word [overcount2],5
jmp hoo
agla:
inc word[undocount1]

call clrBox
mov di,[dmatch1+4]
sub word [overcount2],5
jmp hoo
agla1:
inc word[undocount1]
call clrBox
mov di,[dmatch1+2]
sub word [overcount2],5
jmp hoo
hoo:
jmp draw_box

switch_to_grid11:
    call add_numbers_to_grid11
	call clrBoxx
	mov ah ,10h
	
	call WriteChar
    jmp mainloop1



place_char:
call clrBox
inc dx
mov ah, 0x10
mov al, 0
int 16h
mov cx ,0
mov dx,di

l22:

inc cx
add di,32
mov bl,[es:di+164]
cmp al,bl
je l22

write:
sub di,32
l222:

inc cx
add di,16
mov bl,[es:di+164]

cmp al,bl
je l222
write1:
sub di,16
mov cx ,0

l223:

inc cx
add di,48
mov bl,[es:di+164]

cmp al,bl
je l223

write2:
sub di,48


mov cx ,0

l224:

inc cx
add di,64
mov bl,[es:di+164]

cmp al,bl
je l224

write3:
sub di,64
mov cx ,0

l225:

inc cx
add di,80
mov bl,[es:di+164]

cmp al,bl
je l225

write5:
sub di,80
mov cx ,0

l226:

inc cx
add di,96
mov bl,[es:di+164]
cmp al,bl
je l226

write6:
sub di,96

l227:


add di,112
mov bl,[es:di+164]

cmp al,bl
je l227

write7:
sub di,112
l228:

add di,128
mov bl,[es:di+164]
cmp al,bl
je l228

write8:
sub di,128


h22:

inc cx
sub  di,32
mov bl,[es:di+164]
cmp al,bl
je h22

writ:
add di,32
h222:

inc cx
sub di,16
mov bl,[es:di+164]

cmp al,bl
je h222
writ1:
add di,16
mov cx ,0

h223:

inc cx
sub di,48
mov bl,[es:di+164]

cmp al,bl
je h223

writ2:
add di,48


mov cx ,0

h224:

inc cx
sub di,64
mov bl,[es:di+164]

cmp al,bl
je h224

writ3:
add di,64
mov cx ,0

h225:

inc cx
sub di,80
mov bl,[es:di+164]

cmp al,bl
je h225

writ5:
add di,80
mov cx ,0

h226:

inc cx
sub di,96
mov bl,[es:di+164]
cmp al,bl
je h226

writ6:
add di,96

h227:


sub di,112
mov bl,[es:di+164]

cmp al,bl
je h227

writ7:
add di,112
h228:


sub di,128
mov bl,[es:di+164]
cmp al,bl
je h228

writ8:
add di,128
h229:
push di

sub di,5*160
mov bl,[es:di+164]
cmp al,bl
je h229

writ9:
pop di
h230:
push di

sub di,(10*160)
mov bl,[es:di+164]
cmp al,bl
je h230

writ0:
pop di
h231:
push di

sub di,(15*160)
mov bl,[es:di+164]
cmp al,bl
je h231

writ00:
pop di
h2311:
push di

add di,(15*160)
mov bl,[es:di+164]
cmp al,bl
je h2311

writ001:
pop di
h2314:
push di

add di,(5*160)
mov bl,[es:di+164]
cmp al,bl
je h2314

writ002:
pop di
h2313:
push di

add di,(10*160)
mov bl,[es:di+164]
cmp al,bl
je h2313

writ003:
pop di
h2315:
push di

add di,(5*160)+16
mov bl,[es:di+164]
cmp al,bl
je h2315

writ005:
pop di
h2316:
push di

add di,(10*160)+16
mov bl,[es:di+164]
cmp al,bl
je h2316

writ006:
pop di
h2317:
push di

add di,(5*160)+32
mov bl,[es:di+164]
cmp al,bl
je h2317

writ007:
pop di
h2318:
push di

add di,(10*160)-32
mov bl,[es:di+164]
cmp al,bl
je h2318

writ008:
pop di
h23151:
push di

sub di,(5*160)+16
mov bl,[es:di+164]
cmp al,bl
je h23151

writ0051:
pop di
h23161:
push di

sub di,(10*160)+16
mov bl,[es:di+164]
cmp al,bl
je h23161

writ0061:
pop di
h23171:
push di

sub di,(10*160)+32
mov bl,[es:di+164]
cmp al,bl
je h23171

writ0071:
pop di
h23181:
push di

sub di,(5*160)+32
mov bl,[es:di+164]
cmp al,bl
je h23181

writ0081:
pop di
mov word [es:di + 164], ax
cmp word[undocount],2
je nextt1
cmp word[undocount],1
je nextt
cmp word[undocount],3
je nextt3
inc word[undocount]
mov [dmatch1],di
jmp j00
nextt3:
inc word[undocount]

mov [dmatch1+6],di
jmp j00
nextt:
inc word[undocount]
mov [dmatch1+2],di
jmp j00
nextt1:
inc word[undocount]
mov [dmatch1+4],di
jmp j00
j00:
call score1
cmp word[rowcount],0
je r1
cmp word[rowcount],1
je r2
cmp word[rowcount],2
je r3
cmp word[rowcount],3
je r4
r1:
call linecheck1
jmp r00
r2:
call linecheck2
jmp r00
r3:
call linecheck3
jmp r00
r4:
call linecheck4
jmp r00
r00:

jmp main_loop

linecheck1:
push di
mov cx,0
mov di,(4*160)+4
g00:

inc cx
cmp byte [es:di+164],0x20
je no22
add di,16
cmp cx,9
je producesound
jmp g00
no22:
inc word[linecheck]
jmp end222
producesound:
 call RepeatLosingMelody 
    call PlayDhooDhoo
    call StopSound 
end222:
pop di
ret
linecheck2:
push di
mov cx,0
mov di,(4*160)+4
add di,5*160
g001:

inc cx
cmp byte [es:di+164],0x20
je no221
add di,16
cmp cx,9
je producesound1
jmp g001
no221:
inc word[linecheck]
jmp end2221
producesound1:
 call RepeatLosingMelody 
    call PlayDhooDhoo
    call StopSound 
end2221:
pop di
ret

linecheck3:
push di
mov cx,0
mov di,(4*160)+4
add di,10*160

g003:

inc cx
cmp byte [es:di+164],0x20
je no223
add di,16
cmp cx,9
je producesound3
jmp g003
no223:
inc word[linecheck]
jmp end2223
producesound3:
 call RepeatLosingMelody 
    call PlayDhooDhoo
    call StopSound 
end2223:
pop di
ret
linecheck4:
push di
mov cx,0
mov di,(4*160)+4
add di,15*160
g004:

inc cx
cmp byte [es:di+164],0x20
je no224
add di,16
cmp cx,9
je producesound4
jmp g004
no224:
inc word[linecheck]
jmp end2224
producesound4:
 call RepeatLosingMelody 
    call PlayDhooDhoo
    call StopSound 
end2224:
pop di
ret
move_up1:
call clrBox
sub di, (5 * 160)
dec word [rowcount]
jmp check_and_jump_up


move_down1:
call clrBox
add di, (5 * 160)
inc word [rowcount]
jmp check_and_jump_down

move_left1:
call clrBox
sub di, 16
dec byte[coulmncount]
jmp check_and_jump_left

move_right1:
call clrBox
add di, 16
inc byte[coulmncount]
jmp check_and_jump_right

check_and_jump_up:
call check_and_jump1
jmp draw_box

check_and_jump_down:
call check_and_jump2
jmp draw_box

check_and_jump_left:
call check_and_jump3
jmp draw_box

check_and_jump_right:
call check_and_jump
jmp draw_box

check_and_jump:
mov ax, [es:di + 164]
cmp ax, 0x0720
je skip_jump
add di, 16
inc byte[coulmncount]
jmp check_and_jump

skip_jump:
jmp draw_box

check_and_jump1:
mov ax, [es:di + 164]
cmp ax, 0x0720
je skip_jump1
sub di, (5 * 160)
dec byte[rowcount]
jmp check_and_jump1

skip_jump1:
jmp draw_box
check_and_jump2:
mov ax, [es:di + 164]
cmp ax, 0x0720
je skip_jump2
add di, (5 * 160)
inc byte[rowcount]
jmp check_and_jump2

skip_jump2:
jmp draw_box

check_and_jump3:
mov ax, [es:di + 164]
cmp ax, 0x0720
je skip_jump3
sub di, 16
dec byte [coulmncount]
jmp check_and_jump3

skip_jump3:
jmp draw_box

draw_box:
mov ah, 10h
call WriteChar
jmp mainloop1

WriteChar:
push di
mov cx, 2
draw_row:
push cx
mov cx, 5
row_loop:
stosw
loop row_loop
add di, (80 - 5) * 2
pop cx
loop draw_row
pop di
ret

clrBox:
cmp dx, 0
jne end1
push di
mov cx, 2
clear_row:
push cx
mov cx, 5
clear_loop:
mov ax, 0x0720
stosw
loop clear_loop
add di, (80 - 5) * 2
pop cx
loop clear_row
pop di
end1:
ret

clrBoxx:

cmp dx, 0
jne endd1
push di
sub di ,162
mov cx, 4
clear_roww:
push cx
mov cx, 7
clear_loopp:
mov ax, 0x0720
stosw
loop clear_loopp
add di, (80 - 7) * 2
pop cx
loop clear_roww
pop di
endd1:
ret

clrBoxxx:
cmp dx, 0
jne end111
push di
mov cx, 2
clear_row11:
push cx
mov cx, 5
clear_loop11:
mov ax, 0x0720
stosw
loop clear_loop11
add di, (80 - 5) * 2
pop cx
loop clear_row11
pop di
end111:
ret
end2:
    ret
PlayVaryingTone1:
    ; Inputs: AX = starting divisor, CX = number of steps, DX = step size
    mov bx, ax           ; Save the starting divisor for modification

PlayLoop1:
    ; Program the PIT with the current divisor in BX
    mov al, 0b10110110   ; Control word: Channel 2, Low/High Byte, Mode 3
    out 43h, al          ; Send control word to PIT
    mov ax, bx           ; Load the current divisor
    out 42h, al          ; Send low byte of divisor
    mov al, ah
    out 42h, al          ; Send high byte of divisor

    ; Enable the speaker
    in al, 61h           ; Read current port 61h value
    or al, 00000011b     ; Set bits 0 and 1 to enable the speaker
    out 61h, al          ; Write back to port 61h

    ; Longer delay for 1 minute duration
    push cx              ; Preserve CX
    mov cx, 1200      ; Delay loop for about 1 minute
DelayLoop1:
    dec cx
    jnz DelayLoop1
    pop cx               ; Restore CX

    ; Disable the speaker
    in al, 61h           ; Read current port 61h value
    and al, 11111100b    ; Clear bits 0 and 1 to disable the speaker
    out 61h, al          ; Write back to port 61h

    ; Adjust the frequency divisor
    add bx, dx           ; Modify the divisor by the step in DX
    loop PlayLoop1        ; Repeat for CX iterations
    ret

score1:
push si
push di
cmp dx,DI
jne endd
add word [overcount2],5
mov si, [overcount2]
mov di, (0 * 80 * 2)+152
call PrintNumber
pop DI
pop si
ret
endd:
add word [overcount3],1
mov si, [overcount3]
mov di, (0 * 80 * 2)+ 30
call PrintNumber
    mov ax, 1193180 / 440  ; Start frequency divisor (low pitch)
    mov cx, 1              ; Number of steps (only 1 tone for now)
    mov dx, -5             ; Step size (negative to increase frequency)
    call PlayVaryingTone1

    mov ax, 1193180 / 262  ; Start frequency divisor (higher pitch)
    mov cx, 1              ; Number of steps (only 1 tone for now)
    mov dx, 5              ; Step size (positive to decrease frequency)
    call PlayVaryingTone1

    mov ax, 1193180 / 330  ; Start frequency divisor (middle pitch)
    mov cx, 1              ; Number of steps (only 1 tone for now)
    mov dx, -4             ; Step size (decrease first)
    call PlayVaryingTone1

    mov ax, 1193180 / 370  ; Start frequency divisor (slightly higher pitch)
    mov cx, 1              ; Number of steps (only 1 tone for now)
    mov dx, 4              ; Step size (increase this time)
    call PlayVaryingTone1

cmp  word [overcount3],5
je QuitGame2
pop DI
pop si
ret

   
;upar wala notes
add_numbers_to_grid11:
    pusha
	push dx
    push di
    call clrBox
    mov ax, 0xB800
    mov es, ax
    mov al, ' '
    mov ah, 0x4E
    sub di, 162
    call WriteChar11

mainloop1_new1:
    mov dx, 0
main_loop_new1:
    mov ah, 0x00
    int 0x16



cmp al, '1'
je place_char2
cmp al, '2'
je place_char2
cmp al, '3'
je place_char2
cmp al, '4'
je place_char2
cmp al, '5'
je place_char2
cmp al, '6'
je place_char2
cmp al, '7'
je place_char2
cmp al, '8'
je place_char2
cmp al, '9'
je place_char2
    cmp ah, 0x20 ; Right arrow key
    je move_right1_new1
    cmp ah, 0x1E ; Left arrow key
    je move_left1_new1
	  cmp ah, 0x2C
    je end3
    jmp main_loop_new1

place_char2:
call clrBox_new1
inc dx
cmp word[match1],0
je hhh
cmp word[match1],1
je hhh1
cmp word[match1],2
je hhh2
cmp word[dmatch],1
je hhhh
cmp word[dmatch],2
je hhhh1
cmp word[dmatch],3
je hhhh2


hhh:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
add di,162
mov cx,0
he1:
inc word[match]
h231511:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he1
inc CX
cmp cx,9
jne h231511
writ00511:
pop di
cmp bl,[es:di+4]
cmp al,bl
je hhh
cmp word[match],1
je likh
jmp hhh
likh:
mov word [es:di + 0], ax
jmp main_loop_new1
hhh1:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
add di,158
mov cx,0
he11:
inc word[match]
h2315111:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he11
inc CX
cmp cx,9
jne h2315111
writ005111:
pop di
mov bl,[es:di-4]
cmp al,bl
je hhh1
cmp word[match],1
je likh1
jmp hhh1
likh1:
mov word [es:di + 0], ax
mt
jmp main_loop_new1
hhh2:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
add di,154
mov cx,0
he12:
inc word[match]
h2315112:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he12
inc CX
cmp cx,9
jne h2315112
writ005112:
pop di
mov bl,[es:di-8]
cmp al,bl
je hhh2
mov bl,[es:di-4]
cmp al,bl
je hhh2
cmp word[match],1
je likh2
jmp hhh2
likh2:
mov word [es:di + 0], ax
jmp main_loop_new1
hhhh:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
add di,2
mov cx,0
he123:
inc word[match]
h23151123:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he123
inc CX
cmp cx,9
jne h23151123
writ0051123:
pop di
mov bl,[es:di-160]
cmp al,bl
je hhhh
mov bl,[es:di-156]
cmp al,bl
je hhhh
mov bl,[es:di-152]
cmp al,bl
je hhhh
cmp word[match],1
je likh23
jmp hhhh
likh23:
mov word [es:di + 0], ax
jmp main_loop_new1
hhhh1:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
sub di,2
mov cx,0
he1231:
inc word[match]
h231511231:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he1231
inc CX
cmp cx,9
jne h231511231
writ00511231:
pop di
mov bl,[es:di-4]
cmp al,bl
je hhhh1
mov bl,[es:di-160]
cmp al,bl
je hhhh1
mov bl,[es:di-164]
cmp al,bl
je hhhh1
mov bl,[es:di-156]
cmp al,bl
je hhhh1
cmp word[match],1
je likh231
jmp hhhh1
likh231:
mov word [es:di + 0], ax
jmp main_loop_new1

hhhh2:
mov word[match],0
mov ah, 0x10
mov al, 0
int 16h
push di
sub di,6
mov cx,0
he1234:
inc word[match]
h231511234:
add di,16
mov bl,[es:di+164]
cmp al,bl
je he1234
inc CX
cmp cx,9
jne h231511234
writ00511234:
pop di
cmp word[match],1
je likh234
jmp hhhh2
likh234:
mov word [es:di + 0], ax
jmp main_loop_new1


move_right1_new1:   
 inc byte [right_count]
    cmp byte [right_count], 3
    je move_diagonal_down_left
    mov byte [last_move], 1
    ;call clrBox_new1
    add di, 4
	inc word[match1]
	cmp word[dmatch1],1
	je k00
	cmp word[match11],1
	je h44
	cmp word[match11],0
	je l33
	h44:
	inc word[dmatch]
	jmp l33
	k00:
	inc word[dmatch]
	l33:
    jmp draw_box_new1

move_left1_new1:
    mov byte [right_count], 0
    mov byte [last_move], 2
    ;call clrBox_new1
    sub di, 4
	dec word[match1]
    jmp draw_box_new1

move_diagonal_down_left:
    ;call clrBox_new1
    mov byte [right_count], 0
    mov byte [last_move], 0
    add di, (1 * 160)
    sub di, 8
	cmp word[match11],1
	je h2211
	inc word[match11]
	inc word[dmatch]
	jmp l000
	h2211:
	inc word[dmatch1]
	l000:
    jmp draw_box_new1

draw_box_new1:
    mov ah, 10h
    call WriteChar11
    jmp mainloop1_new1

WriteChar11:
    push di
    mov cx, 1
draw_row_new1:
    push cx
    mov cx, 2
row_loop_new1:
    stosw
    loop row_loop_new1
    add di, (80 - 2) * 2
    pop cx
    loop draw_row_new1
    pop di
    ret

clrBox_new1:
   cmp dx, 0
jne end4
    push di
    mov cx, 1
clear_row_new1:
    push cx
    mov cx, 2
clear_loop_new1:
    mov ax, 0x0720
    stosw
    loop clear_loop_new1
    add di, (80 - 2) * 2
    pop cx
    loop clear_row_new1
    pop di
	end4:
ret
clrBox_new2:
   
    push di
    mov cx, 1
clear_row_new2:
    push cx
    mov cx, 2
clear_loop_new2:
    mov ax, 0x0720
    stosw
    loop clear_loop_new2
    add di, (80 - 2) * 2
    pop cx
    loop clear_row_new2
    pop di
	end3:
pop di 
pop ds 
popa
    ret

	;necha wala dabaa
addnbrs:
  
    mov ax, 0b800h
    mov es, ax
	mov bp ,msg
	mov si,0
	
mov ax, 0xB800
mov es, ax
mov al, ' '
mov ah, 0x4E

mov di, (3 * 80) * 2 + 4
call WriteChar1

mainloop1new:
mov dx, 0
main_loopnew:
mov ah, 0x00
int 0x16

cmp al, '1'
je place_char1
cmp al, '2'
je place_char1
cmp al, '3'
je place_char1
cmp al, '4'
je place_char1
cmp al, '5'
je place_char1
cmp al, '6'
je place_char1
cmp al, '7'
je place_char1
cmp al, '8'
je place_char1
cmp al, '9'
je place_char1

cmp ah, 0x2E
 je switch_to_grid1

 cmp ah, 0x2C
    je clrBox1
	
cmp ah, 0x11
je move_up11
cmp ah, 0x1F
je move_down11
cmp ah, 0x1E
je move_left11
cmp ah, 0x20
je move_right11
cmp ah,0x21
je undo11

jmp main_loopnew

undo11:
cmp word[undocount11],1
je agla111
cmp word[undocount11],2
je agla11
cmp word[undocount11],0
je agla01
cmp word[undocount11],3
je agla31
agla31:
inc word[undocount11]
call clrBox
mov di,[dmatch11]
sub word [overcount2],5
jmp hoo
agla01:
inc word[undocount11]
call clrBox
mov di,[dmatch11+6]
sub word [overcount2],5
jmp hoo1
agla111:
inc word[undocount11]
call clrBox
mov di,[dmatch11+4]
sub word [overcount2],5
jmp hoo1
agla11:
inc word[undocount11]
call clrBox
mov di,[dmatch11+2]
sub word [overcount2],5
jmp hoo1
hoo1:
jmp draw_box3

switch_to_grid1:
    call addnbrstonode
	call clrBox1x
	mov ah ,10h
	
	call WriteChar1
    jmp mainloop1new

place_char1:
call clrBox1
inc dx

mov ah, 0x10
mov al, 0
int 16h
l22w:
push di
inc cx
add di,32
mov bl,[es:di+4]
cmp al,bl
je l22w

rite:
pop di
l222w:
push di
inc cx
add di,16
mov bl,[es:di+4]

cmp al,bl
je l222w
rite1:
pop di
mov cx ,0

l223w:
push di
inc cx
add di,48
mov bl,[es:di+4]

cmp al,bl
je l223w

rite2:
pop di


mov cx ,0

l224w:
push di
inc cx
add di,64
mov bl,[es:di+4]

cmp al,bl
je l224w

rite3:
pop di
mov cx ,0

l225w:
push di
inc cx
add di,80
mov bl,[es:di+4]

cmp al,bl
je l225w

rite5:
pop di
mov cx ,0

l226w:
push di
inc cx
add di,96
mov bl,[es:di+4]
cmp al,bl
je l226w

rite6:
pop di

l227w:
push di

add di,112
mov bl,[es:di+4]

cmp al,bl
je l227w

rite7:
pop di
l228w:
push di

add di,128
mov bl,[es:di+4]
cmp al,bl
je l228w

rite8:
pop di


h22w:
push di
inc cx
sub  di,32
mov bl,[es:di+4]
cmp al,bl
je h22w

rit:
pop di
h222w:
push di
inc cx
sub di,16
mov bl,[es:di+4]

cmp al,bl
je h222w
rit1:
pop di
mov cx ,0

h223w:
push di
inc cx
sub di,48
mov bl,[es:di+4]

cmp al,bl
je h223w

rit2:
pop di


mov cx ,0

h224w:
push di
inc cx
sub di,64
mov bl,[es:di+4]

cmp al,bl
je h224w

rit3:
pop di
mov cx ,0

h225w:
push di
inc cx
sub di,80
mov bl,[es:di+4]

cmp al,bl
je h225w

rit5:
pop di
mov cx ,0

h226w:
push di
inc cx
sub di,96
mov bl,[es:di+4]
cmp al,bl
je h226w

rit6:
pop di

h227w:
push di

sub di,112
mov bl,[es:di+4]

cmp al,bl
je h227w

rit7:
pop di
h228w:
push di

sub di,128
mov bl,[es:di+4]
cmp al,bl
je h228w

rit8:
pop di
h1228w:
push di

sub di,(4*160)
mov bl,[es:di+4]
cmp al,bl
je h1228w

riit8:
pop di
h2228w:
push di

sub di,(8*160)
mov bl,[es:di+4]
cmp al,bl
je h2228w

riiit8:
pop di
h3228w:
push di

sub di,(12*160)
mov bl,[es:di+4]
cmp al,bl
je h3228w

riitt8:
pop di
h4228w:
push di

sub di,(16*160)
mov bl,[es:di+4]
cmp al,bl
je h4228w

riitt9:
pop di
h11228w:
push di

add di,(4*160)
mov bl,[es:di+4]
cmp al,bl
je h11228w

rii1t8:
pop di
h22228w:
push di

add di,(8*160)
mov bl,[es:di+4]
cmp al,bl
je h22228w

riii2t8:
pop di
h33228w:
push di

add di,(12*160)
mov bl,[es:di+4]
cmp al,bl
je h33228w

rii1tt8:
pop di
h44228w:
push di

add di,(16*160)
mov bl,[es:di+4]
cmp al,bl
je h44228w

rii4tt9:
pop di


cmp word[rowcount2],0
je h1228w1
cmp word[rowcount2],1
je h1228w1
cmp word[rowcount2],2
je doooo
h1228w1:
push di

sub di,(4*160)
sub di,16
mov bl,[es:di+4]
cmp al,bl
je h1228w1

riit81:
pop di
h1228w12:
push di

sub di,(4*160)
sub di,32
mov bl,[es:di+4]
cmp al,bl
je h1228w12

riit812:
pop di
start_loop:
push di

add di, (4*160)
add di, 16
mov bl, [es:di+4]
cmp al, bl
je start_loop

end_loop:
pop di

second_loop:
push di

add di, (4*160)
add di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop

end_second_loop:
pop di
second_loop1:
push di

sub di, (4*160)
add di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop1

end_second_loop1:
pop di
jmp likh12
doooo:
push di

add di, (4*160)
add di, 16
mov bl, [es:di+4]
cmp al, bl
je doooo

end_second_loop2:
pop di
second_loop11:
push di
add di, (4*160)
add di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop11

end_second_loop11:
pop di
second_loop12:
push di

add di, (8*160)
add di, 16
mov bl, [es:di+4]
cmp al, bl
je second_loop12

end_second_loop12:
pop di
second_loop13:
push di

add di, (8*160)
add di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop13

end_second_loop13:
pop di
second_loop122:
push di

sub di, (4*160)
sub di, 16
mov bl, [es:di+4]
cmp al, bl
je second_loop122

end_second_loop122:
pop di
second_loop133:
push di

sub di, (4*160)
sub di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop133

end_second_loop133:
pop di
second_loop14:
push di

sub di, (4*160)
add di, 32
mov bl, [es:di+4]
cmp al, bl
je second_loop14

end_second_loop14:
pop di
likh12:
mov word [es:di + 4], ax
move_up11:
call clrBox1
sub di, (4 * 160)
dec word[rowcount2]
jmp check_and_jump_up1

move_down11:
call clrBox1
add di, (4 * 160)
inc word[rowcount2]
jmp check_and_jump_down1

move_left11:
call clrBox1
sub di, 16
jmp check_and_jump_left1

move_right11:
call clrBox1
add di, 16
jmp check_and_jump_right1

check_and_jump_up1:
call check_and_jump11
jmp draw_box3

check_and_jump_down1:
call check_and_jump22
jmp draw_box3

check_and_jump_left1:
call check_and_jump33
jmp draw_box3

check_and_jump_right1:
call check_and_jumpp
jmp draw_box3

check_and_jumpp:
mov ax, [es:di + 4]
cmp ax, 0x0720
je skip_jump111
add di, 16
jmp check_and_jumpp

skip_jump111:
jmp draw_box3

check_and_jump11:
mov ax, [es:di + 4]
cmp ax, 0x0720
je skip_jump11
sub di, (4 * 160)
jmp check_and_jump11

skip_jump11:
jmp draw_box3

check_and_jump22:
mov ax, [es:di + 4]
cmp ax, 0x0720
je skip_jump22
add di, (4 * 160)
jmp check_and_jump22

skip_jump22:
jmp draw_box3

check_and_jump33:
mov ax, [es:di + 4]
cmp ax, 0x0720
je skip_jump33
sub di, 16
jmp check_and_jump33

skip_jump33:
jmp draw_box3

draw_box3:
mov ah, 10h
call WriteChar1
jmp mainloop1new

WriteChar1:
push di
mov cx, 2
draw_row11:
push cx
mov cx, 5
row_loop1:
stosw
loop row_loop1
add di, (80 - 5) * 2
pop cx
loop draw_row11
pop di
ret

clrBox1:
cmp dx, 0
jne end11
push di
mov cx, 2
clear_row1:
push cx
mov cx, 5
clear_loop1:
mov ax, 0x0720
stosw
loop clear_loop1
add di, (80 - 5) * 2
pop cx
loop clear_row1
pop di
end11:
ret
clrBox1x:
cmp dx, 0
jne endd11
push di
sub di,162
mov cx, 3
clear_roww1:
push cx
mov cx, 6
clear_loopp1:
mov ax, 0x0720
stosw
loop clear_loopp1
add di, (80 - 6) * 2
pop cx
loop clear_roww1
pop di
endd11:
ret
end22:
    ret

PrintNumber: 
	pusha 
	
    mov ax, 0b800h   
    mov es, ax
	
	mov ax , si
	mov bx , 10 
	mov cx,  0 
NextDigit:
	mov dx ,  0  
	div bx 
	add dl  ,  0x30 
	push dx 
	inc cx 
	cmp ax , 0   
	jnz NextDigit
	
nextPos:
	pop dx 
	mov dh , 0x0B 
	mov [es:di] , dx 
add di,2
	loop nextPos
	
	popa
    ret
addnbrstonode:
    pusha
	push dx
    push di
    call clrBox1
    mov ax, 0xB800
    mov es, ax
    mov al, ' '
    mov ah, 0x4E
    sub di, 162
    call WriteCharnotes

mainloop1_new11:
    mov dx, 0
main_loop_new11:
    mov ah, 0x00
    int 0x16
cmp al, '1'
je place_char22
cmp al, '2'
je place_char22
cmp al, '3'
je place_char22
cmp al, '4'
je place_char22
cmp al, '5'
je place_char22
cmp al, '6'
je place_char22
cmp al, '7'
je place_char22
cmp al, '8'
je place_char22
cmp al, '9'
je place_char22
    cmp ah, 0x20 ; Right arrow key
    je move_right1_new11
    cmp ah, 0x1E ; Left arrow key
    je move_left1_new11
	  cmp ah, 0x2C
    je end33
    jmp main_loop_new11

place_char22:
call clrBox_new11
inc dx
cmp word[nmatch1],0
je start_main
cmp word[nmatch1],1
je start_main2
cmp word[nmatch1],2
je start_main3
cmp word[ndmatch],1
je start_main4
cmp word[ndmatch],2
je start_main5
cmp word[ndmatch],3
je start_main6
start_main:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
add di, 162
mov cx, 0
check_match1:
inc word[nmatch]
next_cell1:
add di, 16
mov bl, [es:di+4]
cmp al, bl
je check_match1
inc cx
cmp cx, 8
jne next_cell1
process_match1:
pop di
cmp bl, [es:di+4]
cmp al, bl
je start_main
cmp word[nmatch], 1
je write_value1
jmp start_main
write_value1:
mov word [es:di + 0], ax
jmp main_loop_new1

start_main2:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
add di, 158
mov cx, 0
check_match2:
inc word[nmatch]
next_cell2:
add di, 16
mov bl, [es:di+4]
mov word [es:di + 4], ax
cmp al, bl
je check_match2
inc cx
cmp cx, 8
jne next_cell2
process_match2:
pop di
mov bl, [es:di-4]
cmp al, bl
je start_main2
cmp word[nmatch], 1
je write_value2
jmp start_main2
write_value2:
mov word [es:di + 0], ax
jmp main_loop_new1

start_main3:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
add di, 154
mov cx, 0
check_match3:
inc word[nmatch]
next_cell3:
add di, 16
mov bl, [es:di+4]
cmp al, bl
je check_match3
inc cx
cmp cx, 9
jne next_cell3
process_match3:
pop di
mov bl, [es:di-8]
cmp al, bl
je start_main3
mov bl, [es:di-4]
cmp al, bl
je start_main3
cmp word[nmatch], 1
je write_value3
jmp start_main3
write_value3:
mov word [es:di + 0], ax
jmp main_loop_new1

start_main4:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
add di, 2
mov cx, 0
check_match4:
inc word[nmatch]
next_cell4:
add di, 16
mov bl, [es:di+4]
cmp al, bl
je check_match4
inc cx
cmp cx, 9
jne next_cell4
process_match4:
pop di
mov bl, [es:di-160]
cmp al, bl
je start_main4
mov bl, [es:di-156]
cmp al, bl
je start_main4
mov bl, [es:di-152]
cmp al, bl
je start_main4
cmp word[nmatch], 1
je write_value4
jmp start_main4
write_value4:
mov word [es:di + 0], ax
jmp main_loop_new1

start_main5:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
sub di, 2
mov cx, 0
check_match5:
inc word[nmatch]
next_cell5:
add di, 16
mov bl, [es:di+4]
cmp al, bl
je check_match5
inc cx
cmp cx, 9
jne next_cell5
process_match5:
pop di
mov bl, [es:di-4]
cmp al, bl
je start_main5
mov bl, [es:di-160]
cmp al, bl
je start_main5
mov bl, [es:di-164]
cmp al, bl
je start_main5
mov bl, [es:di-156]
cmp al, bl
je start_main5
cmp word[nmatch], 1
je write_value5
jmp start_main5
write_value5:
mov word [es:di + 0], ax
jmp main_loop_new1

start_main6:
mov word[nmatch], 0
mov ah, 0x10
mov al, 0
int 16h
push di
sub di, 6
mov cx, 0
check_match6:
inc word[nmatch]
next_cell6:
add di, 16
mov bl, [es:di+4]
cmp al, bl
je check_match6
inc cx
cmp cx, 9
jne next_cell6
process_match6:
pop di
cmp word[nmatch], 1
je write_value6
jmp start_main6
write_value6:
mov word [es:di + 0], ax
jmp main_loop_new11


move_right1_new11:  
  inc byte [right_count]
    cmp byte [right_count], 3
    je move_diagonal_down_left1
    mov byte [last_move], 1
  ; call clrBox_new11
   inc word[nmatch1]
   cmp word[nmatch1],1
   je proceed
cmp word[ndmatch1], 1
je match_found
cmp word[nmatch11], 1
je increment_dmatch
cmp word[nmatch11], 0
je proceed
increment_dmatch:
inc word[ndmatch]
jmp proceed
match_found:
inc word[ndmatch]
proceed:
    add di, 4
    jmp draw_box_new11

move_left1_new11:
    mov byte [right_count], 0
    mov byte [last_move], 2
    call clrBox_new11
    sub di, 4
    jmp draw_box_new11

move_diagonal_down_left1:
    call clrBox_new11
    mov byte [right_count], 0
    mov byte [last_move], 0
    add di, (1 * 160)
    sub di, 8
	cmp word[nmatch11],1
	je h22111
	inc word[nmatch11]
	inc word[ndmatch]
	jmp l0001
	h22111:
	inc word[ndmatch1]
	l0001:
    jmp draw_box_new11

draw_box_new11:
    mov ah, 10h
    call WriteCharnotes
    jmp mainloop1_new11

WriteCharnotes:
    push di
    mov cx, 1
draw_row_new11:
    push cx
    mov cx, 2
row_loop_new11:
    stosw
    loop row_loop_new11
    add di, (80 - 2) * 2
    pop cx
    loop draw_row_new11
    pop di
    ret

clrBox_new11:
   cmp dx, 0
jne end44
    push di
    mov cx, 1
clear_row_new11:
    push cx
    mov cx, 2
clear_loop_new11:
    mov ax, 0x0720
    stosw
    loop clear_loop_new11
    add di, (80 - 2) * 2
    pop cx
    loop clear_row_new11
    pop di
	end44:
ret
clrBox_new22:
   
    push di
    mov cx, 1
clear_row_new22:
    push cx
    mov cx, 2
clear_loop_new22:
    mov ax, 0x0720
    stosw
    loop clear_loop_new22
    add di, (80 - 2) * 2
    pop cx
    loop clear_row_new22
    pop di
	end33:
pop di 
pop ds 
popa
    ret

PrintStringManualCentered:
    push ax
    push cx
    push dx
    push si
    push di
    push es
    mov ax, 0b800h
    mov es, ax
    mov dx, 40
    sub dx, cx
    shr dx, 1
    shl dx, 1
    add di, dx
.print_char:
    mov al, [si]
    cmp al, 0
    je .done_printing
    mov ah, 1Bh
    mov [es:di], ax
    add di, 2
	call sleep
    inc si
    loop .print_char
.done_printing:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret

PrintStringManualCentered1:
    push ax
    push cx
    push dx
    push si
    push di
    push es
    mov ax, 0b800h
    mov es, ax
    mov dx, 40
    sub dx, cx
    shr dx, 1
    shl dx, 1
    add di, dx
.print_char1:
    mov al, [si]
    cmp al, 0
    je .done_printing1
    mov [es:di], al
    add di, 160
	call sleep
    inc si
    loop .print_char1
.done_printing1:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
PrintOption:
    push ax
    push cx
    push dx
    push si
    push di
    push es
    mov ax, 0b800h
    mov es, ax
    mov dx, 40
    sub dx, cx
    shr dx, 1
    shl dx, 1
    add di, dx
    mov bx, [selected_option]
    mov dx, di
    shr dx, 7
    cmp dx, bx
    je .highlighted_option
    mov ah, 07h
    jmp .print_normal
.highlighted_option:
    mov ah, 20h
.print_normal:
.print_char_option:
    mov al, [si]
    cmp al, 0
    je .done_printing_option
    mov [es:di], ax
    add di, 2
    inc si
    loop .print_char_option
.done_printing_option:
    pop es
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret


	scrollup:
push bp
mov bp,sp
push es
push ax
push cx
push si
push di
push ds
mov ax,0xB800
mov dx,ds
mov es,dx
mov ds,AX
mov si,0
mov di, abc
mov cx,80*24 ; 3rows
rep movsw
mov es,AX
		cld
		mov si,3840
		mov di,0
		mov cx,80*1 ;copy 22 rows
		rep movsw
		mov ax,0x0720
		mov cx,1800
		rep stosw
	
 mov di, (1 * 80 * 2) ; Start at row 4 (to position grid below the message)
    call draw_break_horizontal_line
	mov di, (1 * 80 * 2)
    add di, 48
	call draw_single_vertical_line
	mov di, (1 * 80 * 2)
    add di, 96
	call draw_single_vertical_line
	mov di, (5  * 80 * 2) ; Start at row 4 (to position grid below the message)
	add di,2
    call draw_break_horizontal_line
    mov di, (22 * 80 * 2)
	add di,2
    call draw_break_horizontal_line
	mov di, (1 * 80 * 2)
    add di, 16
	call draw_small_vertical_line
	mov di, (1 * 80 * 2)
    add di, 32
	call draw_small_vertical_line
	mov di, (1 * 80 * 2)
    add di,64
	call draw_small_vertical_line
	mov di, (1 * 80 * 2)
    add di, 80
	call draw_small_vertical_line
	mov di, (1 * 80 * 2)
    add di, 112
	call draw_small_vertical_line
	mov di, (1 * 80 * 2) ; Start at row 4 (position to draw the line)
    add di, 128
	call draw_small_vertical_line
	 mov di, ( 9* 80 * 2) ; Start at row 4 (to position grid below the message)
    call draw_thick_horizontal_line
	mov di, (13 * 80 * 2) ; Start at row 4 (to position grid below the message)
	add di,2
    call draw_break_horizontal_line
      mov di, (17 * 80 * 2)
	add di,2
    call draw_break_horizontal_line
	 mov di, (21 * 80 * 2) ; Start at row 4 (to position grid below the message)
    call draw_thick_horizontal_line
	 call hacode1
	 jmp l00
	 check12:
	 h2312:
push di

sub di,(2*80*2)
mov bl,[es:di+4]
cmp al,bl
je h2312

writ000:
pop di
ret
l00:
	mov ax,0x0720
		mov cx,400
		rep stosw
		
	
pop ds
pop di
pop si
pop cx
pop ax
pop es
mov sp,bp
pop bp
ret 0


scrolldown:
push bp
mov bp,sp
push es

push ax
push cx
push si
push di
push ds

;move data from video memory to memory memory
mov ax,0xB800
mov dx,ds
mov es,dx
mov ds,AX

;move data from es to abc
mov si,1*160
mov di, bottom

cld
mov cx,80*24 ; 3rows
rep movsw  ;last 3 rows moved to xyz

; mov ds,dx;we need to  use ds as vid memory later so no need to put val back yet

mov es,AX

std

		mov si,160*1 - 2
		mov di,320

		mov cx,80*1 ;copy 22 rows
		rep movsw

cld
mov ds,dx
mov si,abc
mov di,0
mov cx,2500
rep movsw
pop ds
pop di
pop si
pop cx
pop ax
pop es
mov sp,bp
pop bp
ret

f1:
pusha
push di
mov cx, 54
mov al, 20h
mov ah, 50h
mov di, 19*160

l1:
mov [es:di], al
add di, 3
call sleep
loop l1
pop di
popa
ret

f2:
pusha
push di
mov cx, 54
mov al, 20h
mov ah, 50h
mov di, 3*160

l2:
mov [es:di], al
add di, 3
call sleep
loop l2
pop di
popa
ret

s1:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 40h
mov di, (8*160)+12
ss1:
mov word [es:di], ax
add di, 2
call sleep
loop ss1
pop di
popa
ret

s2:
pusha
push di
mov cx, 4
mov al, 20h
mov ah, 40h
mov di, (8*160)+12
ss2:
mov word [es:di], ax
add di, 160
call sleep
loop ss2
pop di
popa
ret

s3:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 40h
mov di, 11*160
add di , 12
ss3:
mov word [es:di], ax
add di, 2
call sleep
loop ss3
pop di
popa
ret

s4:
pusha
push di
mov cx, 4
mov al, 20h
mov ah, 40h
mov di, (11*160)+26
ss4:
mov word [es:di], ax
add di, 160
call sleep
loop ss4
pop di
popa
ret

s5:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 40h
mov di, (14*160)+12
ss5:
mov word [es:di], ax
add di, 2
call sleep
loop ss3
pop di
popa
ret

u1:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 97h
mov di, (8*160)+34
uu1:
mov word [es:di], ax
add di, 160
call sleep
loop uu1
pop di
popa
ret

u2:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 97h
mov di, (14*160)+34
uu2:
mov word [es:di], ax
add di, 2
call sleep
loop uu2
pop di
popa
ret

u3:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 97h
mov di, (8*160)+48
uu3:
mov word [es:di], ax
add di, 160
call sleep
loop uu3
pop di
popa
ret

d1:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 30h
mov di, (8*160)+56
dd1:
mov word [es:di], ax
add di, 160
call sleep
loop dd1
pop di
popa
ret

d2:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 30h
mov di, (8*160)+56
dd2:
mov word [es:di], ax
add di, 2
call sleep
loop dd2
pop di
popa
ret

d3:
pusha
push di
mov cx, 5
mov al, 20h
mov ah, 30h
mov di, (9*160)+68
dd3:
mov word [es:di], ax
add di, 160
call sleep
loop dd3
pop di
popa
ret

d4:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 30h
mov di, (14*160)+56
dd4:
mov word [es:di], ax
add di, 2
call sleep
loop dd4
pop di
popa
ret

o1:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 40h
mov di, (8*160)+76
oo1:
mov word [es:di], ax
add di, 2
call sleep
loop oo1
pop di
popa
ret

o2:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 40h
mov di, (8*160)+76
oo2:
mov word [es:di], ax
add di, 160
loop oo2
call sleep
pop di
popa
ret

o3:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 40h
mov di, (14*160)+76
oo3:
mov word [es:di], ax
add di, 2
call sleep
loop oo3
pop di
popa
ret

o4:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 40h
mov di, (8*160)+90
oo4:
mov word [es:di], ax
add di, 160
call sleep
loop oo4
pop di
popa
ret

kk1:
pusha
push di
mov cx, 7
mov al, 20h
mov ah, 97h
mov di, (8*160)+98
kkk1:
mov word [es:di], ax
add di, 160
call sleep
loop kkk1
pop di
popa
ret

kk2:
pusha
push di
mov cx, 4
mov al, 20h
mov ah, 97h
mov di, (8*160)+110
kkk2:
mov word [es:di], ax
add di, 158
call sleep
loop kkk2
sub di, 162
mov word [es:di], ax
add di, 2
mov word [es:di], ax
pop di
popa
ret

kk3:
pusha
push di
mov cx, 3
mov al, 20h
mov ah, 97h
mov di, (12*160)+106
kkk3:
mov word [es:di], ax
add di, 162
call sleep
loop kkk3
pop di
popa
ret

u11:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 30h
mov di, (8*160)+118
uu11:
mov word [es:di], ax
add di, 160
call sleep
loop uu11
pop di
popa
ret

u22:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 30h
mov di, (14*160)+118
uu22:
mov word [es:di], ax
add di, 2
call sleep
loop uu22
pop di
popa
ret

u33:
pusha
push di
mov cx, 6
mov al, 20h
mov ah, 38h
mov di, (8*160)+132
uu33:
mov word [es:di], ax
add di, 160
call sleep
loop uu33
pop di
popa
ret
ScrooollllllDwn:
call scrollup
call draw_number_buttons
call addnbrs
jmp done

Scrooollllllup:
call scrolldown
call add_numbers_to_grid
jmp done
start:
    call clr
mov ax, 0xb800
mov es, ax
call f2
call f1
call s1
call s2
call s3
call s4
call s5
call u1
call u2
call u3
call d1
call d2
call d3
call d4
call o1
call o2
call o3
call o4
call kk1
call kk2
call kk3
call u11
call u22
call u33

mov si, msg1
mov cx, -5
mov di, (21 * 80 * 2) - 34
call PrintStringManualCentered
mov ah ,00
	int 16h
	call clr
	call v1
	call v2
    call display_menu
    call get_input

get_input:
    mov ah, 00h
    int 16h
    cmp ah, 48h
    je move_up
    cmp ah, 50h
    je move_down
    cmp al, 13
    je show_selected_option
    ret

move_up:
    mov al, [selected_option]
    cmp al, 0
    je move_to_last_option
    dec al
    mov [selected_option], al
    call display_menu
    call get_input
    ret

move_down:
    mov al, [selected_option]
    cmp al, 2
    je move_to_first_option
    inc al
    mov [selected_option], al
    call display_menu
    call get_input
    ret

move_to_last_option:
    mov al, 2
    mov [selected_option], al
    call display_menu
    call get_input
    ret

move_to_first_option:
    mov al, 0
    mov [selected_option], al
    call display_menu
    call get_input
    ret

show_selected_option:
    cmp byte [selected_option], 0
    je PlayGame
    cmp byte [selected_option], 1
    je ShowInstructions
    cmp byte [selected_option], 2
    je QuitGame
    ret

v1:
pusha
push di
mov cx, 13
mov al, 20h
mov ah, 20h
mov di, (0*160)+20
vv1:
mov word [es:di], ax
add di, 320
call sleep
loop vv1
pop di
popa
ret

v2:
pusha
push di
mov cx, 13
mov al, 20h
mov ah, 20h
mov di, (0*160)+136
vv2:
mov word [es:di], ax
add di, 320
call sleep
loop vv2
pop di
popa
ret

display_menu:
    mov si, title
    mov cx, 40
    mov di, (2 * 80 * 2) + 46
    call PrintStringManualCentered
    mov si, menuTitle
    mov cx, 15
    mov di, (5 * 80 * 2) + 36
    call PrintStringManualCentered

    mov si, play_game
    mov cx, 12
    mov di, (8 * 80 * 2) + 38
    call PrintOption

    mov si, instructions
    mov cx, 15
    mov di, (11 * 80 * 2) + 38

    call PrintOption

    mov si, quit_game
    mov cx, 12
    mov di, (14 * 80 * 2) + 38
    call PrintOption
 call RepeatLosingMelody 
    call PlayDhooDhoo
    call StopSound 
     mov si, chooseMsg
    mov cx, 35
    mov di, (21 * 80 * 2) + 38
    call PrintStringManualCentered

    cmp byte [selected_option], 0
    je highlight_play_game
    cmp byte [selected_option], 1
    je highlight_instructions
    cmp byte [selected_option], 2
    je highlight_quit_game
    ret

highlight_play_game:
    mov si, play_game_highlighted
    mov cx, 12
    mov di, (8 * 80 * 2) + 38
    call PrintStringManualCentered
    ret

highlight_instructions:
    mov si, instructions_highlighted
    mov cx, 15
    mov di, (11 * 80 * 2) + 38
    call PrintStringManualCentered
    ret

highlight_quit_game:
    mov si, quit_game_highlighted
    mov cx, 12
    mov di, (14 * 80 * 2) + 38
    call PrintStringManualCentered
    ret

get_number_input:
    mov ah, 00h
    int 16h
    cmp ah, 4Bh
    je move_left
    cmp ah, 4Dh
    je move_right
    ret

move_left:
    mov al, [selected_number]
    cmp al, 1
    jle move_to_nine
    dec al
    mov [selected_number], al
    call draw_number_buttons
    ret

move_right:
    mov al, [selected_number]
    cmp al, 9
    jge move_to_one
    inc al
    mov [selected_number], al
    call draw_number_buttons
    ret

move_to_nine:
    mov byte [selected_number], 9
    call draw_number_buttons
    ret

move_to_one:
    mov byte [selected_number], 1
    call draw_number_buttons
    ret
	
b1:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 20h
mov di, (4*160)+16
bb1:
mov word [es:di], ax
add di, 320
call sleep
loop bb1
pop di
popa
ret

b2:
pusha
push di
mov cx, 8
mov al, 20h
mov ah, 20h
mov di, (4*160)+146
bb2:
mov word [es:di], ax
add di, 320
call sleep
loop bb2
pop di
popa
ret

b3:
pusha
push di
mov cx, 45
mov al, 20h
mov ah, 50h
mov di, (19*160) + 16

bb3:
mov [es:di], al
add di, 3
call sleep
loop bb3
pop di
popa
ret

b4:
pusha
push di
mov cx, 45
mov al, 20h
mov ah, 50h
mov di, (3*160) + 16

bb4:
mov [es:di], al
add di, 3
call sleep
loop bb4
pop di
popa
ret

PlayGame:
mov word[overcount2], 0
mov word[overcount3], 0
    call clr
	call b1
	call b2
	call b4
	call b3
	mov si, Tip
    mov cx, 15
    mov di, (5 * 80 * 2) + 44
    call PrintStringManualCentered
	mov si, tip0
    mov cx, 180
    mov di, (10 * 80 * 2)+2
    call PrintStringManualCentered
	mov si, tip00
    mov cx, 180
    mov di, (12 * 80 * 2)+2
    call PrintStringManualCentered
	mov si, tip1
    mov cx, 180
    mov di, (14 * 80 * 2)+2
    call PrintStringManualCentered
	mov si, tip2
    mov cx, 180
    mov di, (16 * 80 * 2)+2
    call PrintStringManualCentered
	mov si, tip3
    mov cx, 180
    mov di, (18 * 80 * 2)+2
    call PrintStringManualCentered
	mov ah , 00h
	int 16h
	call clr
	
    mov si, play1
    mov cx, 40
    mov di, (0 * 80 * 2)
    call PrintStringManualCentered
    mov si, play2Msg
    mov cx, 20
    mov di, (0 * 80 * 2)
    add di,42
    call PrintStringManualCentered
    mov si, play1Msg
    mov cx, 16
    mov di, (0 * 80 * 2)
    add di,114
    call PrintStringManualCentered
	mov si, undomsg
    mov cx, 40
    mov di, (23 * 80 * 2)
	call PrintStringManualCentered
	mov si, [ucnt]
    mov di, (23 * 80 * 2) + 24
    call PrintNumber
    call draw_9x9_grid
    call draw_number_buttons
    call add_numbers_to_grid
done:
	mov ah , 00h
int 16h
cmp ah , 48h
je Scrooollllllup
cmp ah , 50h
je ScrooollllllDwn
call get_number_input

jmp done

return_to_menu3:
    jmp start
	
	
ShowInstructions:
    call clr
    mov si, instr1Msg
    mov cx, -5
    mov di, (3 * 80 * 2)
    sub di, 40
    call PrintStringManualCentered

    mov si, instrMsg
    mov cx, 0
    mov di, (5 * 80 * 2)
    sub di, 40
    call PrintStringManualCentered
mov si, instr2Msg
    mov cx, -5
    mov di, (19 * 80 * 2)
    sub di, 40
    call PrintStringManualCentered
.wait_for_esc:
    mov ah, 00h
    int 16h
    cmp al, 1Bh
    je return_to_menu
    jmp .wait_for_esc
return_to_menu:
    jmp start

QuitGame:
mov byte[isPaused] ,1 
call clr

    mov si, quitMsg
    mov cx, 40
    mov di, (5 * 80 * 2)
	add di ,30
    call PrintStringManualCentered
    mov si, instr2Msg
    mov cx, -5
    mov di, (19 * 80 * 2)
    sub di, 40
    call PrintStringManualCentered
.wait_for_esc:
    mov ah, 00h
    int 16h
    cmp al, 1Bh
    je return_to_menu1
    jmp .wait_for_esc
return_to_menu1:
    jmp start
	
QuitGame2:
mov byte[isPaused] , 1 
call clr
call RepeatLosingMelody2
    call PlayDhooDhoo2
    call StopSound2
    mov si, gameover
    mov cx, 13
    mov di, (5 * 80 * 2)
	add di ,30
    call PrintStringManualCentered
	mov si, play1Msg
    mov cx, 13
    mov di, (7 * 80 * 2)
	add di ,32
    call PrintStringManualCentered
	mov si, overcount2
    mov cx, 13
    mov di, (7 * 80 * 2)
	add di ,44
    call PrintStringManualCentered
    mov si, instr2Msg
    mov cx, -5
    mov di, (19 * 80 * 2)
    sub di, 40
    call PrintStringManualCentered
.wait_for_esc:
    mov ah, 00h
    int 16h
    cmp al, 1Bh
    je return_to_menu1
    jmp .wait_for_esc
return_to_menu2:
    jmp start

END_PROGRAM:
    mov ax, 4C00h
    int 21h
