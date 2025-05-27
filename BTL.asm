.model large   
.stack 100h    ; Du tru 256 byte cho stack
.data

exit db 0
player_pos dw 1760d                         ;vi tri cua nguoi choi

arrow_pos dw 0d                             ;vi tri cua mui ten
arrow_status db 0d                          ;0 = mui ten san sang ban, khac 0 thi khong 
arrow_limit dw  22d     ;150d

loon_pos dw 3860d       ;3990d
loon_status db 0d
         
                                            ;huong di chuyen cua nguoi choi 
                                            ;len=8, xuong=2
direction db 0d

state_buf db '00:0:0:0:0:0:00:00$'          ;bien diem so
;hit_num db 0d
hits dw 0d
miss dw 0d  

game_over_str dw '  ',0ah,0dh
dw '                             |               |',0ah,0dh
dw '                             |---------------|',0ah,0dh
dw '                             | ^   Score   ^ |',0ah,0dh
dw '                             |_______________|',0ah,0dh
dw ' ',0ah,0dh 
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw '                                Game Over',0ah,0dh
dw '                        Do you want to play again? (Y/N)$',0ah,0dh 

game_start_str dw '  ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw '                ====================================================',0ah,0dh
dw '               ||                                                  ||',0ah,0dh                                      
dw '               ||         *    Balloon Shooting Game      *        ||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '               ||--------------------------------------------------||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '               ||                  Game Team2                      ||',0ah,0dh
dw '               ||       This game was modified by Group BTL2       ||',0ah,0dh
dw '               || (D23 PTIT Hanoi),based on an open-source version ||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '               ||          Use W and S key to move player          ||',0ah,0dh
dw '               ||            and space button to shoot             ||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '               ||          Miss 5 balloons and you lose            ||',0ah,0dh
dw '               ||          Hit 2 balloons and you win              ||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '               ||             Press Enter to start                 ||',0ah,0dh 
dw '               ||                                                  ||',0ah,0dh
dw '               ||                                                  ||',0ah,0dh
dw '                ====================================================',0ah,0dh
dw '$',0ah,0dh

win_str dw '  ',0ah,0dh
dw '                             |               |',0ah,0dh
dw '                             |---------------|',0ah,0dh
dw '                             | ^ You Win! ^  |',0ah,0dh
dw '                             |_______________|',0ah,0dh
dw ' ',0ah,0dh 
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw ' ',0ah,0dh
dw '                                Congratulations!',0ah,0dh
dw '                        Do you want to play again? (Y/N)$',0ah,0dh

.code
main proc
mov ax,@data
mov ds,ax

mov ax, 0B800h
mov es,ax 

jmp game_menu                              ;hien thi menu chinh

main_loop:                                 ;cap nhat logic va hien thi moi thu
    mov ah,1h
    int 16h                                ;kiem tra neu co phim duoc nhan
    jnz key_pressed
    jmp inside_loop                        ;hoac tiep tuc
    
    inside_loop:                           ;kiem tra moi thu
        cmp miss,5                        ;neu bong bay vuot qua 5 lan, chuyen den phan ket thuc tro choi
        jge game_over
        
        mov dx,arrow_pos                   ;kiem tra va cham
        cmp dx, loon_pos
        je hit
        
        cmp direction,8d                   ;cap nhat vi tri nguoi choi
        je player_up
        cmp direction,2d                   ;len hoac xuong dua tren bien huong
        je player_down
        
        mov dx,arrow_limit                 ;an mui ten 
        cmp arrow_pos, dx
        jge hide_arrow
        
        cmp loon_pos, 0d                   ;kiem tra bong bay vuot qua
        jle miss_loon
        jne render_loon 
     
        hit:                               ;;;phat am thanh neu ban trung
            mov ah,2                       ; in ra ky tu } tren man hinh
            mov dx, 7d
            int 21h 
            
            inc hits                       ;cap nhat diem so

            lea bx,state_buf               ;hien thi diem so ngay lap tuc
            call show_score 
            lea dx,state_buf
            mov ah,09h
            int 21h

            mov ah,2                       ;xuong dong
            mov dl, 0dh
            int 21h

            cmp hits, 2                    ;kiem tra neu so lan ban trung dat 2
            je win_game

            jmp fire_loon                  ;bong bay moi xuat hien
    
        render_loon:                       ;ve bong bay
            mov cl, ' '                    ;an bong bay cu
            mov ch, 1111b
            mov bx,loon_pos 
            mov es:[bx], cx
                
            sub loon_pos,160d              ;va ve bong bay moi o vi tri moi
            mov cl, 15d
            mov ch, 1101b
            mov bx,loon_pos 
            mov es:[bx], cx
            
            cmp arrow_status,1d            ;kiem tra xem co mui ten nao de ve khong
            je render_arrow
            jne inside_loop2 
        
        render_arrow:                      ;ve mui ten
            mov cl, ' '
            mov ch, 1111b
            mov bx,arrow_pos               ;an vi tri cu
            mov es:[bx], cx
                
            add arrow_pos,4d               ;ve vi tri moi
            mov cl, 26d
            mov ch, 1001b
            mov bx,arrow_pos 
            mov es:[bx], cx
        
        inside_loop2:
            mov cl, 125d                   ;ve nguoi choi 
            mov ch, 1100b
            mov bx,player_pos 
            mov es:[bx], cx
                       
    cmp exit,0
    je main_loop                          ;ket thuc vong lap chinh
    jmp program_end
     
jmp inside_loop2
    
player_up:                                ;an vi tri cu cua nguoi choi
    mov cl, ' '
    mov ch, 1111b
    mov bx,player_pos 
    mov es:[bx], cx
    
    sub player_pos, 160d                  ;dat vi tri moi cho nguoi choi
    mov direction, 0    
    jmp inside_loop2                      ;no se duoc ve trong vong lap chinh
    
player_down:
    mov cl, ' '                           ;giong nhu player_up
    mov ch, 1111b                         ;an cai cu va dat vi tri moi
    mov bx,player_pos 
    mov es:[bx], cx
    
    add player_pos,160d                   ;va vong lap chinh se ve no
    mov direction, 0
    jmp inside_loop2

key_pressed:                              ;phan xu ly dau vao
    mov ah,0
    int 16h

    cmp ah,11h ;11h la Scan Code (hex) cua W     ;chuyen den upKey neu nut len duoc nhan
    je upKey
    cmp ah,1Fh ;1Fh la Scan Code (hex)  cua S    ;chuyen den dowKey neu nut len duoc nhan
    je downKey
    
    cmp ah,39h                            ;chuyen den spaceKey neu nut space duoc nhan
    je spaceKey
    
    cmp ah,4Bh                            ;chuyen den leftKey (dung de debug)
    je leftKey
    jmp inside_loop                       ;neu khong co nut nao duoc nhan, chuyen den ben trong vong lap

leftKey:                                  ;chung ta dung no de debug 
    inc miss
    lea bx,state_buf
    call show_score 
    lea dx,state_buf
    mov ah,09h
    int 21h
    
    mov ah,2
    mov dl, 0dh
    int 21h
jmp inside_loop
    
upKey:                                    ;dat huong di chuyen cua nguoi choi len tren
    mov direction, 8d
    jmp inside_loop

downKey:                                   ;dat huong di chuyen cua nguoi choi xuong duoi
    mov direction, 2d                     
    jmp inside_loop
    
spaceKey:                                 ;ban mui ten
    cmp arrow_status,0
    je  fire_arrow
    jmp inside_loop

fire_arrow:                               ;dat vi tri mui ten tai vi tri nguoi choi
    mov dx, player_pos                    ;de mui ten ban tu vi tri nguoi choi
    mov arrow_pos, dx
    
    mov dx,player_pos                     ;khi ban mui ten, no cung dat gioi han
    mov arrow_limit, dx                   ;cua mui ten, noi ma no se bi an
    add arrow_limit, 22d  ;150
    
    mov arrow_status, 1d                  ;dat trang thai mui ten. No ngan chan viec ban nhieu lan
    jmp inside_loop                       ;ban

miss_loon:
    add miss,1                            ;cap nhat diem so
    lea bx,state_buf                      ;hien thi diem so
    call show_score 
    lea dx,state_buf
    mov ah,09h
    int 21h
                                          ;xuong dong
    mov ah,2
    mov dl, 0dh
    int 21h
jmp fire_loon
    
fire_loon:                                ;ban bong bay moi
    mov loon_status, 1d
    mov loon_pos, 3860d     ;3990d
    jmp render_loon
    
hide_arrow:
    mov arrow_status, 0                   ;an mui ten
    mov cl, ' '
    mov ch, 1111b
    mov bx,arrow_pos 
    mov es:[bx], cx
    
    cmp loon_pos, 0d 
    jle miss_loon
    jne render_loon 
    jmp inside_loop2
    
game_over:     
    mov cl, ' '                           ;an bong bay cuoi cung tren man hinh
    mov ch, 1111b 
    mov bx, loon_pos  
    mov es:[bx], cx  
    
    mov cl, ' '                           ;an mui ten tren man hinh
    mov ch, 1111b 
    mov bx,arrow_pos                      
    mov es:[bx], cx
          
    mov cl, ' '                           ;an nguoi choi
    mov ch, 1111b 
    mov bx,player_pos  
    mov es:[bx], cx    
    
    mov ah,09h
    mov dx, offset game_over_str
    int 21h
    
    ;cap nhat bien de bat dau lai
    mov miss, 0d
    mov hits,0d
    mov player_pos, 1760d
    mov arrow_pos, 0d
    mov arrow_status, 0d 
    mov arrow_limit, 22d      ;150d
    mov loon_pos, 3860d       ;3990d
    mov loon_status, 0d
    mov direction, 0d
    
    input:
        mov ah,1
        int 21h
        cmp al,'Y'
        je play_again
        cmp al,'y'
        je play_again
        cmp al,'N'
        je exit_game
        cmp al,'n'
        je exit_game
        jmp input                         ;neu khong phai Y/N, cho dau vao hop le

    play_again:
        call clear_screen
        jmp main_loop

    exit_game:
        mov ah,4Ch
        int 21h

win_game:
    mov ah,09h
    mov dx, offset win_str
    int 21h
    
    ; An mui ten va nguoi choi
    mov cl, ' '
    mov ch, 1111b
    mov bx, arrow_pos
    mov es:[bx], cx
    
    mov cl, ' '
    mov ch, 1111b
    mov bx, player_pos
    mov es:[bx], cx
    
    ; Dat lai cac bien
    mov miss, 0d
    mov hits, 0d
    mov player_pos, 1760d
    mov arrow_pos, 0d
    mov arrow_status, 0d
    mov arrow_limit, 22d
    mov loon_pos, 3860d
    mov loon_status, 0d
    mov direction, 0d
    
    input_win:
        mov ah,1
        int 21h
        cmp al,'Y'
        je play_again
        cmp al,'y'
        je play_again
        cmp al,'N'
        je exit_game
        cmp al,'n'
        je exit_game
        jmp input_win

game_menu:
    mov ah,09h
    mov dh,0
    mov dx, offset game_start_str
    int 21h
                                           ;cho dau vao
    input2:
        mov ah,1
        int 21h
        cmp al,13d
        jne input2
        call clear_screen
        
        lea bx,state_buf                   ;hien thi diem so
        call show_score 
        lea dx,state_buf
        mov ah,09h
        int 21h
    
        mov ah,2
        mov dl, 0dh
        int 21h
        jmp main_loop

program_end:                                ;ket thuc tro choi:)
mov exit,10d

main endp

show_score proc
    lea bx,state_buf
    mov dx, hits
    add dx,48d 
    mov [bx], 9d
    mov [bx+1], 9d
    mov [bx+2], 9d
    mov [bx+3], 9d
    mov [bx+4], 'H'
    mov [bx+5], 'i'                                      
    mov [bx+6], 't'
    mov [bx+7], 's'
    mov [bx+8], ':'
    mov [bx+9], dx
    mov dx, miss
    add dx,48d
    mov [bx+10], ' '
    mov [bx+11], 'M'
    mov [bx+12], 'i'
    mov [bx+13], 's'
    mov [bx+14], 's'
    mov [bx+15], ':'
    mov [bx+16], dx
ret    
show_score endp 

clear_screen proc near
    mov ah,0
    mov al,3
    int 10h        
    ret
clear_screen endp

end main