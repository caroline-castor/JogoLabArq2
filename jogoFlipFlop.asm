INCLUDE Irvine32.inc

OBSTACULO STRUCT
	x BYTE ? ;1 byte
	y BYTE ? ;1 byte
	caracter BYTE ?
OBSTACULO ENDS


.data
	row BYTE 0
	col BYTE 0
	jogador BYTE 226d,0
	carac BYTE 219d,0
	points BYTE "PONTOS: ",0
	level BYTE "NIVEL: ",0
	melhor_ponto BYTE "MELHOR PONTUACAO",0
	pontos DWORD 0
	melhor_pontuacao DWORD 0
	nivel DWORD 0
	opcao1_mp BYTE "INICIAR JOGO",0
	opcao2_mp BYTE "INSTRUCOES",0
	opcao4_mp BYTE "SOBRE",0
	opcao5_mp BYTE "SAIR",0
	opcao1_mg BYTE "CONTINUE",0
	opcao2_mg BYTE "MENU PRINCIPAL",0
	opcao3_mg BYTE "SAIR",0
	seta_menu BYTE "->",0
	instrucoes_jogo_1 BYTE "Mova o personagem para desviar dos obstaculos",0
	instrucoes_jogo_2 BYTE "Utilize as teclas A(LEFT), S(DOWN), D(RIGHT), W (UP)",0
	instrucoes_jogo_3 BYTE "[PRESSIONE ESC PARA VOLTAR AO MENU PRINCIPAL]",0
	sobre_1 BYTE "Trabalho da Disciplina Laboratorio de Arquitetura de Computadores II",0
	sobre_2 BYTE "Feito por: Caroline Castor dos Santos RA: 551503",0
	sobre_3 BYTE "Professor Doutor Luciano Neris",0
	sobre_4 BYTE "UFSCAR - DEPTO DE COMPUTACAO / Primeiro SEMESTRE DE 2017",0
	blank BYTE "  ",0
	seta_menu_x BYTE 31
	seta_menu_y BYTE 11
	jogadorx BYTE 2
	jogadory BYTE 2
	obstaculos OBSTACULO 10 DUP (<>)
	sizeObstaculo equ 3
	
	desenha_personagem PROTO, x:BYTE, y:BYTE
	desenha_obstaculo PROTO, index:DWORD
	apaga_obstaculo PROTO, index:DWORD
	anda_obstaculo PROTO, index:DWORD
	acrescenta_pontuacao PROTO pontuacao:DWORD
	acrescenta_nivel PROTO nivelJogo:DWORD
	verifica_nivel PROTO pontosJogo:DWORD
	verifica_colisao PROTO, xJogador:BYTE, yJogador:BYTE
	desenha_menu_F PROTO, x: BYTE, y:BYTE
	desenha_menu_L PROTO, x: BYTE, y:BYTE
	desenha_menu_I PROTO, x:BYTE, y:BYTE
	desenha_menu_P PROTO, x:BYTE, y:BYTE
	desenha_menu_S PROTO, x: BYTE, y:BYTE
	desenha_menu_H PROTO, x: BYTE, y:BYTE
	desenha_menu_G PROTO, x: BYTE, y:BYTE
	desenha_menu_A PROTO, x: BYTE, y:BYTE
	desenha_menu_M PROTO, x: BYTE, y:BYTE
	desenha_menu_E PROTO, x: BYTE, y:BYTE
	desenha_menu_O PROTO, x: BYTE, y:BYTE
	desenha_menu_V PROTO, x: BYTE, y:BYTE
	desenha_menu_R PROTO, x: BYTE, y:BYTE
	
	
	indice BYTE 0
	
.code



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
;Procedimento principal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;limpa a tela
	call Clrscr
	;desenha o menu
    call desenha_menu
	
	;quando o jogo terminar, posiciona o cursor fora da margem do jogo 
	mov dl,0
	mov dh,26
	call Gotoxy
	call Crlf
	exit
main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_tela PROC
;Desenha todas das bordas da tela
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call desenha_tela_cima
	call desenha_tela_esquerda
	call desenha_tela_embaixo
	call desenha_tela_direita
	ret
	exit
desenha_tela ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_tela_cima PROC
;Desenha borda superior da tela
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov row,0
	mov col,0
	;move o cursor para as coordenadas dl controla a coluna e dh controla as linhas da tela
	mov dl, col
	mov dh, row
	;faz o loop 80 vezes, ou seja, a tela de jogo terá largura 80
	mov ecx, 80
	L0:
		call Gotoxy
		mov al, carac
		call WriteChar
		inc col
		mov dl,col
	LOOP L0
	ret
desenha_tela_cima ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_tela_esquerda PROC
;Desenha a borda esquerda da tela
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov row, 0
	mov col, 0
	;move o cursor para as coordenadas dl controla a coluna e dh controla as linhas da tela
	mov dl,col
	mov dh, row
	;faz o loop 25 vezes, ou seja, a tela de jogo terá altura 25
	mov ecx,25
	L0:
		call Gotoxy
		mov al, carac
		call WriteChar
		inc row
		mov dh,row
	LOOP L0
	ret
desenha_tela_esquerda ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_tela_embaixo PROC
;Desenha a borda debaixo da tela
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov row,25
	mov col,0
	;move o cursor para as coordenadas dl controla a coluna e dh controla as linhas da tela
	mov dl,col
	mov dh,row
	;faz o loop 80 vezes, ou seja, a tela de jogo terá largura 80
	mov ecx,80
	L0:	call Gotoxy
		mov al, carac
		call WriteChar
		inc col
		mov dl, col
	LOOP L0
	ret
desenha_tela_embaixo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_tela_direita PROC
;Desenha a borda direita da tela
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov row,0
	mov col,79
	;move o cursor para as coordenadas dl controla a coluna e dh controla as linhas da tela
	mov dl,col
	mov dh,row
	;faz o loop 25 vezes, ou seja, a tela de jogo terá altura 25
	mov ecx,25
	L0:	call Gotoxy
		mov al, carac
		call WriteChar
		inc row
		mov dh, row
	LOOP L0
	ret
desenha_tela_direita ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OS SEGUINTES PROCEDIMENTOS AUXILIAM A IMPRESSÃO DAS LETRAS DAS TELAS,
;PARA NÃO REPETIR O CODIGO PARA CADA CARACTER IGUAL ELES FORAM CRIADOS
;RECEBE: NADA
;RETORNA: IMPRIME O CARACTER NA TELA
;REQUER: que antes de chamado o cursor esteja posicionado onde ele será impresso
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imprime_underline PROC
	mov al, '_'
	call WriteChar
	ret
imprime_underline ENDP

imprime_barra PROC
	mov al, 92d
	call WriteChar
	ret
imprime_barra ENDP

imprime_barra2 PROC
	mov al, '/'
	call WriteChar
	ret
imprime_barra2 ENDP

imprime_apostrofe PROC
	mov al, 96
	call WriteChar
	ret
imprime_apostrofe ENDP

imprime_acento PROC
	mov al, 239
	call WriteChar
	ret
imprime_acento ENDP


imprime_pipe PROC
	mov al, '|'
	call WriteChar
	ret
imprime_pipe ENDP

imprime_circunflexo PROC
	mov al, '^'
	call WriteChar
	ret
imprime_circunflexo ENDP

imprime_parentesis_dir PROC
	mov al, ')'
	call WriteChar
	ret
imprime_parentesis_dir ENDP

imprime_parentesis_esq PROC
	mov al, '('
	call WriteChar
	ret
imprime_parentesis_esq ENDP

imprime_traco PROC
	mov al, '-'
	call WriteChar
	ret
imprime_traco ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_opcoes_menu PROC
;Desenha as opções do menu principal
;Recebe: nada
;Retorna: nada
;Reqer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,35
	mov dh,11
	call Gotoxy
	mov edx, OFFSET opcao1_mp
	call WriteString
	mov dl,35
	mov dh,13
	call Gotoxy
	mov edx, OFFSET opcao2_mp
	call WriteString
	mov dl,35
	mov dh,15
	call Gotoxy
	mov edx, OFFSET opcao4_mp
	call WriteString
	mov dl,35
	mov dh,17
	call Gotoxy
	mov edx, OFFSET opcao5_mp
	call WriteString
	ret
desenha_opcoes_menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_opcoes_gameOver PROC
;Desenha as opções do menu de game over
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,35
	mov dh,11
	call Gotoxy
	mov edx, OFFSET opcao1_mg
	call WriteString
	mov dl,35
	mov dh,13
	call Gotoxy
	mov edx, OFFSET opcao2_mg
	call WriteString
	mov dl,35
	mov dh,15
	call Gotoxy
	mov edx, OFFSET opcao3_mg
	call WriteString
	
	ret
desenha_opcoes_gameOver ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
imprime_seta_menu PROC
;Redesenha a seta do menu 
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov edx, OFFSET seta_menu
	call WriteString
ret
imprime_seta_menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
apaga_seta_menu PROC
;Apaga a seta do menu para ir a outra opção
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov edx, OFFSET blank
	call WriteString
ret
apaga_seta_menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
controla_menu PROC
;Faz o controle do menu principal
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,seta_menu_x
	mov dh,seta_menu_y
	call Gotoxy
	call imprime_seta_menu
L0:
	mov eax,50
	call Delay
	call ReadKey
	jz L0
	;se foi 119, então a tela foi 'w' (UP), salta para label UP
	cmp al, 119
	je UP
	;se foi 115, então a tela foi 's' (DOWN), salta para label DOWN
	cmp al, 115
	je DOWN
	cmp al,0Dh
	je _ENTER
	;se não foi nenhuma das opções, salta para label L0 e tenta ler outra tecla permitida
	jmp L0
	
UP:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call apaga_seta_menu
	cmp seta_menu_y,11
	jne UP1
	mov seta_menu_y,17
	jmp UP2
UP1:
	sub seta_menu_y,2
UP2:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call imprime_seta_menu
	jmp L0
DOWN:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call apaga_seta_menu
	cmp seta_menu_y,17
	jne DOWN1
	mov seta_menu_y,11
	jmp DOWN2
DOWN1:
	add seta_menu_y,2
DOWN2:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call imprime_seta_menu
	jmp L0
_ENTER:
	cmp seta_menu_y, 11
	je _JOGO
	cmp seta_menu_y,13
	je _INSTRUCOES
	cmp seta_menu_y,15
	je _SOBRE
	cmp seta_menu_y, 17
	je _SAIR
	jmp L0
	
_JOGO:
		call jogo
		jmp NEXT
_INSTRUCOES:
		call Clrscr
		call desenha_tela
		call instrucoes
		jmp NEXT
_SOBRE:
		call Clrscr
		call desenha_tela
		call sobre
		jmp NEXT
_SAIR:	
		mov dl,0
		mov dh,26
		call Gotoxy
		call Crlf
		exit
NEXT:
	ret
controla_menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
controla_menu_gameOver PROC
;Faz o controle do menu principal
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,seta_menu_x
	mov dh,seta_menu_y
	call Gotoxy
	call imprime_seta_menu
L0:
	mov eax,50
	call Delay
	call ReadKey
	jz L0
	;se foi 119, então a tela foi 'w' (UP), salta para label UP
	cmp al, 119
	je UP
	;se foi 115, então a tela foi 's' (DOWN), salta para label DOWN
	cmp al, 115
	je DOWN
	cmp al,0Dh
	je _ENTER
	;se não foi nenhuma das opções, salta para label L0 e tenta ler outra tecla permitida
	jmp L0
	
UP:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call apaga_seta_menu
	cmp seta_menu_y,11
	jne UP1
	mov seta_menu_y,15
	jmp UP2
UP1:
	sub seta_menu_y,2
UP2:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call imprime_seta_menu
	jmp L0
DOWN:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call apaga_seta_menu
	cmp seta_menu_y,15
	jne DOWN1
	mov seta_menu_y,11
	jmp DOWN2
DOWN1:
	add seta_menu_y,2
DOWN2:
	mov dl, seta_menu_x
	mov dh, seta_menu_y
	call Gotoxy
	call imprime_seta_menu
	jmp L0
_ENTER:
	cmp seta_menu_y, 11
	je  _JOGO
	cmp seta_menu_y, 13
	je _MENU
	cmp seta_menu_y, 15
	je _SAIR
	jmp L0
	
_JOGO:
		call jogo
		jmp NEXT
_MENU:
		call Clrscr
		call desenha_tela
		call desenha_menu
		JMP NEXT
_SAIR:	
		mov dl,0
		mov dh,26
		call Gotoxy
		call Crlf
		exit
NEXT:
	ret
controla_menu_gameOver ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu PROC
;Faz o desenho do menu principal
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INVOKE desenha_menu_F, 10,1
	INVOKE desenha_menu_L, 18,1
	INVOKE desenha_menu_I, 26,1
	INVOKE desenha_menu_P, 30,1
	INVOKE desenha_menu_F, 40,1
	INVOKE desenha_menu_L, 48,1
	INVOKE desenha_menu_O, 56,1
	INVOKE desenha_menu_P, 65,1
	call desenha_opcoes_menu
	call controla_menu
	ret
desenha_menu ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_F PROC x:BYTE, y:BYTE
;Desenha a letra F nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl, x
	mov dh, y
	call Gotoxy
	mov ecx, 6
L0:
	call imprime_underline
	LOOP L0
	
	;Segunda linha
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	mov ecx,4
L1:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L1
	call Gotoxy
	call imprime_pipe
	
	;TERCEIRA LINHA
	
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	mov ecx, 2
L2:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L2
	
	;QUARTA LINHA
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,3
	mov ecx,2
L3:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L3
	call Gotoxy
	call imprime_pipe
	
	;QUINTA LINHA
	mov dl, x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	
	; SEXTA LINHA
	mov dl, x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	mov ecx,2
L4:
	inc dl
	call Gotoxy
	call imprime_underline
	LOOP L4
	call Gotoxy
	call imprime_pipe
	
	
ret
desenha_menu_F ENDP
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_L PROC x:BYTE, y:BYTE
;Desenha a letra L nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Linha 1
	inc x
	mov dl,x
	mov dh,y
	mov ecx,1
	L1:
		call Gotoxy
		call imprime_underline
		inc dl
		LOOP L1
	;Linha 2
	dec x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	;Linha 3
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	;Linha 4
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	;Linha 5
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	mov al, 39d
	call WriteChar
	inc dl
	mov ecx,3
L5: 
	call Gotoxy
	mov al,'-'
	call WriteChar
	inc dl
	LOOP L5
	call Gotoxy
	mov al, '.'
	call WriteChar
	;Linha 6
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	inc dl
	mov ecx,5
L6:	
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L6
	call Gotoxy
	call imprime_pipe

ret
desenha_menu_L ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_I PROC x:BYTE, y:BYTE
;Desenha a letra I nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Linha 1
	inc x
	mov dl,x
	mov dh,y
	mov ecx,1
L1:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L1
;Linha2
	dec x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl, 2
	call Gotoxy
	call imprime_pipe
;Linha 3
	mov dl,x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	add dl, 2
	call Gotoxy
	call imprime_pipe
	
;Linha 4
	mov dl,x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	add dl, 2
	call Gotoxy
	call imprime_pipe	
;Linha 5
	mov dl,x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	add dl, 2
	call Gotoxy
	call imprime_pipe	
;Linha 6
	mov dl,x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	inc dl
	mov ecx,1
L6:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L6
	call Gotoxy
	call imprime_pipe
ret
desenha_menu_I ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_P PROC x:BYTE, y:BYTE
;Desenha a letra P nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Linha 1
	inc x
	mov dl,x
	mov dh,y
	mov ecx,5
L1:	
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L1

;Linha 2
	dec x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_underline
	add dl,3
	call Gotoxy
	call imprime_barra
; Linha 3
	mov dl,x
	inc y
	mov dh, y 
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_parentesis_dir
	add dl,3
	call Gotoxy
	call imprime_pipe
; Linha 4
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,3
	mov ecx,3
L4:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L4
	call Gotoxy
	call imprime_barra2
;Linha 5
	mov dl,x
	inc y 
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl, 2
	call Gotoxy
	call imprime_pipe
	
;Linha 6
	mov dl,x
	inc y
	mov dh, y
	call Gotoxy
	call imprime_pipe
	inc dl
	mov ecx,1
L6:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L6
	call Gotoxy
	call imprime_pipe	
ret
desenha_menu_P ENDP

desenha_jogador PROC x:BYTE, y:BYTE
	;linha1
	mov dl,x
	mov dh,y
	call Gotoxy
	call imprime_barra
	add x,4
	mov dl,x
	call Gotoxy
	mov ecx,1
L1:	call imprime_underline
	inc x
	call Gotoxy
	LOOP L1
	mov ecx,3
L2:	call imprime_barra2
	inc x
	call Gotoxy
	LOOP L2
	inc x
	call imprime_underline
ret
desenha_jogador ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_S PROC x:BYTE, y:BYTE
;Desenha a letra S nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Linha 1
	add x,2
	mov dl,x
	mov dh,y
	mov ecx, 6
L1:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L1
;Linha 2
	dec x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_barra2
	add dl,7
	call Gotoxy
	call imprime_pipe
;Linha 3
	dec x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_parentesis_esq
	inc dl
	mov ecx,4
L3:
	call Gotoxy
	call imprime_traco
	inc dl
	LOOP L3
	call Gotoxy
	mov al,96d
	call WriteChar
;Linha 4
	inc x
	mov dl,x
	inc y
	mov dh,y
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra
;Linha 5
	sub x,3
	mov dl,x
	inc y 
	mov dh,y
	mov ecx,3
L5:
	call Gotoxy
	call imprime_traco
	inc dl
	LOOP L5
	call Gotoxy
	call imprime_parentesis_dir
	add dl,3
	call Gotoxy
	call imprime_pipe
;Linha 6
	dec x
	mov dl,x
	inc y 
	mov dh,y 
	call Gotoxy
	call imprime_pipe
	inc dl
	mov ecx,6
L6:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L6
	call Gotoxy
	call imprime_barra2
	ret
desenha_menu_S ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_H PROC x:BYTE, y:BYTE
;Desenha a letra H nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    inc x
	mov dl,x
	mov dh,y
	mov ecx,1
L1:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L1
	add dl,3
	mov ecx,1
L12:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L12
	
;LINHA 2
	dec x
	mov dl,x
	inc y 
	mov dh,y
	mov ecx,4
L2:
	call Gotoxy
	call imprime_pipe
	add dl,2
	LOOP L2
	
; LINHA 3
	mov dl,x
	inc y 
	mov dh,y
	mov ecx, 2
L3: 
	call Gotoxy
	call imprime_pipe
	add dl,2
	LOOP L3
	dec dl
	mov ecx,1
	
L31:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L31
	mov ecx,2
L32: 
	call Gotoxy
	call imprime_pipe
	add dl,2
	LOOP L32
	
; LINHA 4
	mov dl,x
	inc y 
	mov dh,y
	call Gotoxy
	call imprime_pipe
	add dl,3
	mov ecx,1
L4:
	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L4
	add dl,2
	call Gotoxy
	call imprime_pipe
	
;LINHA 5
	mov dl,x
	inc y 
	mov dh,y
	mov ecx, 2
L5: 
	call Gotoxy
	call imprime_pipe
	add dl,2
	LOOP L5
	mov ecx,2
L51:
 	call Gotoxy
	call imprime_pipe
	add dl,2
	LOOP L51
	
;LINHA 6
	mov dl,x
	inc y 
	mov dh,y
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	mov ecx,1
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl 
	call Gotoxy
	call imprime_pipe

ret
desenha_menu_H ENDP
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_G PROC x:BYTE, y:BYTE
;Desenha a letra G nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,x
	inc dl
	mov dh,y
	call Gotoxy
	mov ecx,7
;linha 1
L1:
	call imprime_underline
	loop L1
;linha 2
	inc dh
	dec dl
	call Gotoxy
	call imprime_barra2
	add dl,2
	call Gotoxy
	mov ecx,6
L2:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L2
	call Gotoxy
	call imprime_pipe
;linha 3
	inc dh
	dec x
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	add dl,3
	mov ecx,2
L3:	call Gotoxy
	call imprime_underline
	inc dl
	LOOP L3
;linha 4
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	add dl,2
	call Gotoxy
	call imprime_pipe
;linha 5
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	mov ecx,2
	inc dl
L5: 
	call Gotoxy
	call imprime_underline
	inc dl
loop L5
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
;linha 6
	inc x
	mov dl,x
	inc dh
	call Gotoxy
	call imprime_barra
	mov ecx,6
	inc dl
L6:
	call Gotoxy
	call imprime_underline
	inc dl
loop L6
    call Gotoxy
	call imprime_pipe	
ret
desenha_menu_G ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_A PROC x:BYTE, y:BYTE
;Desenha a letra A nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,x
	add dl,5
	mov dh,y
	mov ecx,3
;LINHA 1
L1:
	call Gotoxy
	call imprime_underline
	inc dl
	loop L1
;LINHA 2
	inc dh
	mov dl,x
	add dl,4
	call Gotoxy
	call imprime_barra2
	add dl,4
	call Gotoxy
	call imprime_barra
;LINHA 3
	inc dh
	mov dl,x
	add dl,3
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_circunflexo
	add dl,3
	call Gotoxy
	call imprime_pipe
;LINHA 4
	inc dh
	mov dl,x
	add dl,3
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
;LINHA 5
	inc dh
	mov dl,x
	add dl,3
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	mov ecx,1
L5:
	call imprime_underline
	inc dl
	call Gotoxy
loop L5
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dh
;LINHA 6
	mov dl,x
	add dl,3
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
ret
	
desenha_menu_A ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_M PROC x:BYTE, y:BYTE
;Desenha a letra M nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LINHA 1
	mov dl,x
	inc dl
	mov dh,y
	mov ecx,3
L1:	call Gotoxy
	call imprime_underline
	inc dl
	loop L1
	add dl,2
	call Gotoxy
	mov ecx,3
L11: call imprime_underline
	 inc dl
	 call Gotoxy
	 loop L11
;linha2
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,4
	call Gotoxy
	call imprime_barra
	inc dl
	call Gotoxy
	call imprime_barra2
	add dl,4
	call Gotoxy
	call imprime_pipe
;linha 3
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra2
	add dl,3
	call Gotoxy
	call imprime_pipe
;linha 4
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_barra
	inc dl
	call Gotoxy
	call imprime_barra2
	inc dl
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
;linha 5
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	mov ecx,3
L5: add dl,3
	call Gotoxy
	call imprime_pipe
	loop L5
;linha 6
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl 
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
ret
desenha_menu_M ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_E PROC x:BYTE, y:BYTE
;Desenha a letra E nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;linha 1
	mov dl,x
	mov dh,y
	inc dl
	call Gotoxy
	mov ecx,7
L1:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L1
;linha 2
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,4
	call Gotoxy
	mov ecx,4
L2:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L2
	call imprime_pipe
;linha 3
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_underline
;linha 4
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,4
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
;linha 5
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_pipe
	mov ecx,4
L5:
	inc dl
	call Gotoxy
	call imprime_underline
	loop L5
;linha 6
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	mov ecx,7
L6:
	inc dl
	call Gotoxy
	call imprime_underline
	loop l6
	inc dl
	call Gotoxy
	call imprime_pipe
	
ret
desenha_menu_E ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_O PROC x:BYTE, y:BYTE
;Desenha a letra O nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,x
	mov dh,y 
	add dl,2
	call Gotoxy
	mov ecx,6
L1:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L1
;linha 2
	inc dh
	mov dl,x 
	inc dl 
	call Gotoxy
	call imprime_barra2
	add dl,3
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_underline
	add dl,3
	call Gotoxy
	call imprime_barra
;linha 3 e linha 4
mov ecx,2
L34:
	inc dh
	mov dl,x 
	call Gotoxy
	call imprime_pipe
	push ecx
	mov ecx,3
L3:
	add dl,3
	call Gotoxy
	call imprime_pipe
	loop L3
	pop ecx
	loop L34
;linha 5
	inc dh
	mov dl,x 
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_apostrofe
	inc dl
	call Gotoxy
	mov ecx,2
L5:
	call imprime_traco
	inc dl
	call Gotoxy
	loop L5
	call imprime_acento
	add dl,3
	call Gotoxy
	call imprime_pipe
;linha 6
	inc dh
	mov dl,x 
	inc dl
	call Gotoxy
	call imprime_barra
	mov ecx,6
L6:
	inc dl
	call Gotoxy
	call imprime_underline
	loop L6
	inc dl
	call Gotoxy
	call imprime_barra2
ret
desenha_menu_O ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_V PROC x:BYTE, y:BYTE
;Desenha a letra V nas coordenadas especificas recebidas
;Recebe: coordenadas x e y
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,x
	mov dh,y 
	inc dl
	call Gotoxy
	mov ecx,3
L1: 
	call imprime_underline
	inc dl
	call Gotoxy
	loop L1
	add dl, 4
	call Gotoxy
	mov ecx,3
L11:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L11
;linha 2
    inc dh
	mov dl,x 
	inc dl
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra2
	add dl,3
	call Gotoxy
	call imprime_barra2
;linha 3
	inc dh
	mov dl, x 
	add dl,2
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra
	inc dl
	call Gotoxy
	call imprime_barra2
	add dl,3
	call Gotoxy
	call imprime_barra2
;linha 4
	inc dh
	mov dl,x
	add dl,3
	call Gotoxy
	call imprime_barra
	add dl,5
	call Gotoxy
	call imprime_barra2
;linha 5
	inc dh
	mov dl,x
	add dl,4
	call Gotoxy
	call imprime_barra
	add dl,3
	call Gotoxy
	call imprime_barra2
;linha 6
	inc dh
	mov dl,x
	add dl,6
	call Gotoxy
	call imprime_traco	
ret
desenha_menu_V ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_menu_R PROC x:BYTE,y:BYTE
;Desenha a letra R nas coordenadas especificas passadas por parametro
;Recebe: as coordenadas x e y de onde se quer desenhar
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl,x 
	mov dh,y 
	inc dl
	call Gotoxy
	mov ecx,5
L1:
	call imprime_underline
	inc dl
	call Gotoxy
	loop L1
; LINHA 2
	inc dh
	mov dl,x 
	call Gotoxy
	call imprime_pipe
	add dl,3
	call Gotoxy
	call imprime_underline
	add dl,3
	call Gotoxy
	call imprime_barra
;LINHA 3
	 inc dh
	 mov dl,x
	 call Gotoxy
	 call imprime_pipe
	 add dl,2
	 call Gotoxy
	 call imprime_pipe
	 inc dl
	 call Gotoxy
	 call imprime_underline
	 inc dl
	 call Gotoxy
	 call imprime_parentesis_dir
	 add dl,3
	 call Gotoxy
	 call imprime_pipe
;linha 4
	inc dh
	mov dl,x
	call Gotoxy
	call imprime_pipe
	add dl,6
	call Gotoxy
	call imprime_barra2
;linha 5
	inc dh
	mov dl, x 
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_barra
	add dl,2
	call Gotoxy
	call imprime_barra
;linha 6
	inc dh 
	mov dl,x
	call Gotoxy
	call imprime_pipe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
	add dl,2
	call Gotoxy
	call imprime_apostrofe
	inc dl
	call Gotoxy
	call imprime_underline
	inc dl
	call Gotoxy
	call imprime_pipe
ret
desenha_menu_R ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
volta_cor_padrao PROC
;Volta a cor padrão do prompt
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;volta a cor do cursor para a cor padrão (modificada no procedimento desenha_personagem)
	mov eax, lightGray
	call SetTextColor
ret
volta_cor_padrao ENDP



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
inicializaObstaculos PROC
;Inicializa os obstaculos com as coordenadas de x e y e o caracter
;Recebe: nada
;Retorna: nada
;Requer: nada 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov obstaculos[sizeObstaculo*0].x,85
	mov obstaculos[sizeObstaculo*0].y,5
	mov obstaculos[sizeObstaculo*0].caracter,219
	mov obstaculos[sizeObstaculo*1].x,95
	mov obstaculos[sizeObstaculo*1].y,15
	mov obstaculos[sizeObstaculo*1].caracter,219
	mov obstaculos[sizeObstaculo*2].x,105
	mov obstaculos[sizeObstaculo*2].y,20
	mov obstaculos[sizeObstaculo*2].caracter,219
	mov obstaculos[sizeObstaculo*3].x,115
	mov obstaculos[sizeObstaculo*3].y,6
	mov obstaculos[sizeObstaculo*3].caracter,219
	mov obstaculos[sizeObstaculo*4].x,125
	mov obstaculos[sizeObstaculo*4].y,24
	mov obstaculos[sizeObstaculo*4].caracter,219
	mov obstaculos[sizeObstaculo*5].x,135
	mov obstaculos[sizeObstaculo*5].y,3
	mov obstaculos[sizeObstaculo*5].caracter,219
	mov obstaculos[sizeObstaculo*6].x,145
	mov obstaculos[sizeObstaculo*6].y,14
	mov obstaculos[sizeObstaculo*6].caracter,219
	mov obstaculos[sizeObstaculo*7].x,155
	mov obstaculos[sizeObstaculo*7].y,22
	mov obstaculos[sizeObstaculo*7].caracter,219
	mov obstaculos[sizeObstaculo*8].x,165
	mov obstaculos[sizeObstaculo*8].y,9
	mov obstaculos[sizeObstaculo*8].caracter,219
	mov obstaculos[sizeObstaculo*9].x,175
	mov obstaculos[sizeObstaculo*9].y,15
	mov obstaculos[sizeObstaculo*9].caracter,219
ret
inicializaObstaculos ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Procedimento que controla o jogo
jogo PROC
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call Clrscr
	call desenha_tela
	mov nivel,0
	mov pontos,0
	call desenha_pontuacao
	call desenha_nivel
	invoke acrescenta_pontuacao,pontos
	invoke acrescenta_nivel,nivel
	;invoca o procedimento desenha_personagem, passando como parâmetro a coordenada 2,2 ou seja, o personagem será desenhado nessa coordenada
	INVOKE desenha_personagem, 2,10
	call volta_cor_padrao
	
	call inicializaObstaculos
	;loop de leitura do input do usuário
	L0:
		
		INVOKE anda_obstaculo,0
		INVOKE anda_obstaculo,1
		INVOKE anda_obstaculo,2
		INVOKE anda_obstaculo,3
		INVOKE anda_obstaculo,4
		INVOKE anda_obstaculo,5
		INVOKE anda_obstaculo,6
		INVOKE anda_obstaculo,7
		INVOKE anda_obstaculo,8
		INVOKE anda_obstaculo,9
		
		INVOKE verifica_colisao,jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		
		
		;atribui um delay de 50 para conseguir ler a entrada do usuario
		mov eax,50
		;chama o delay
		call Delay
		;tenta ler uma entrada de usuário
		call ReadKey
		;se não houve entrada do usuário (0) salta para L0 e tenta ler novamente
		jz L0
		;se houve entrada do usuário, compara o conteúdo lido com ao código correspondente ascii
		;se foi 97, então a tela foi 'a' (LEFT), salta para label LEFT
		cmp al, 97
		je LEFT
		;se foi 119, então a tela foi 'w' (UP), salta para label UP
		cmp al, 119
		je UP
		;se foi 100, então a tela foi 'd (RIGHT), salta para label RIGHT
		cmp al, 100
		je RIGHT
		;se foi 115, então a tela foi 's' (DOWN), salta para label DOWN
		cmp al, 115
		je DOWN
		cmp al,27
		je _ESC
		;se não foi nenhuma das opções, salta para label L0 e tenta ler outra tecla permitida
		jmp L0
		
	_ESC:
		call Clrscr
		call volta_cor_padrao
		call desenha_tela
		call desenha_menu
		ret
	;entrada do usuário foi 'a'
	LEFT:
		;compara se a posição x do jogador é 1, se for o movimento não é permitido para a esquerda e nada acontece (Controle de borda)
		cmp jogadorx,1
		;salta para L0 para tentar ler uma entrada válida
		je L0
		;se a posição x do jogador não for 1, então o movimento é permitido 
		;chama o procedimento apaga personagem
		call apaga_personagem
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;subtrai 1 da posicao x do jogador
		sub jogadorx,1
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;desenha o personagem na nova posicao
		INVOKE desenha_personagem, jogadorx, jogadory
		
		;salta ara L0 para tentar ler uma nova entrada
		jmp L0
		
	;entrada do usuário foi 'w'
	UP: 
		;compara se a posicao y do jogador é 1, se for, o movimento não é permitido para cima e nada acontece (Controle de borda)
		cmp jogadory,2
		;salta para L0 para tentar ler uma entrada válida
		je L0
		;se a posicao y do jogador não for 1, o movimento é permitido
		;chama o procedimento apaga personagem
		call apaga_personagem
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;subtrai 1 da posicao y do jogador
		sub jogadory,1
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;desenha o personagem na nova posicao
		INVOKE desenha_personagem, jogadorx, jogadory

		;salta para L0 para ler tentar ler uma nova entrada
		jmp L0
	
	RIGHT:
		;compara se a posicao x do jogador é 78, se for, o movimento não é permitido para a direita e nada acontece (Controle de borda)
		cmp jogadorx,78
		;salta para L0 para tentar ler uma entrada válida
		je L0
		;se a posicao x do jogador não for 78, o movimento é permitido
		;chama o procedimento apaga personagem
		call apaga_personagem
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;adiciona 1 a posicao x do jogador
		add jogadorx,1
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;desenha o personagem na nova posicao
		INVOKE desenha_personagem, jogadorx, jogadory
		
		;salta para L0 para ler tentar ler uma nova entrada
		jmp L0
		
	DOWN: 
		;compara se a posicao y do jogador é 24, se for, o movimento não é permitido para a direita e nada acontece (Controle de borda)
		cmp jogadory,24
		;salta para L0 para tentar ler uma entrada válida
		je L0
		;se a posicao y do jogador não for 24, o movimento é permitido
		;chama o procedimento apaga personagem
		call apaga_personagem
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;adiciona 1 a posicao y do jogador
		add jogadory,1
		INVOKE verifica_colisao, jogadorx,jogadory
		cmp eax,1
		je GAMEOVER
		;desenha o personagem na nova posicao
		INVOKE desenha_personagem, jogadorx, jogadory
		
		;salta para L0 para ler tentar ler uma nova entrada
		jmp L0
		
	GAMEOVER:
		call Clrscr
		call volta_cor_padrao
		call game_over
		ret
jogo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
apaga_personagem PROC
;Apaga o personagem da posicao atual para desenhá-lo na nova posicao
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;move o cursor para a posicao atual do jogador. DL controla a coluna (x), e DH controla a linha (Y)
	mov dl,jogadorx
	mov dh,jogadory
	call Gotoxy
	;substitui o personagem por ' ', ou seja, apaga ele da tela
	mov al, ' '
	call WriteChar
	ret
apaga_personagem ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_personagem PROC x:BYTE, y:BYTE
;Desenha o personagem do jogador
;Recebe: as coordenada desejadas da onde se quer desenha-lo
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;move o cursor para a posicao x,y recebida como parâmetro. DL controla a coluna (x), e DH controla a linha (Y)
	mov dl,x
	mov dh, y
	;atualiza a variavel jogador para a posicao nova
	mov jogadorx, dl
	mov jogadory,dh
	;move o cursor
	call Gotoxy
	;attribui ao registrador usado em SetTextColor, que a cor do texto vai ser amarela (cor do personagem)
	mov EAX, yellow+(black*16)
	call SetTextColor
	;move para al (caracter a ser impresso), o caracter do jogador
	mov al, jogador
	;printa o jogador
	call WriteChar
	ret
desenha_personagem ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
verifica_colisao PROC xjogador:BYTE, yjogador:BYTE
;verifica a colisão entre os obstaculos e o jogador
;Recebe: as coordenadas do jogador
;Retorna: EAX=1 SE COLIDIU, EAX=0 SE NAO COLIDIU
;Requer: calculo do endereço efetivo do obstaculo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ecx,10
;coloca o indice em edx
	mov ebx,0
VERIFICA_OBSTACULOS:
	mov edx,ebx
	;;coloca o tamanho da struct OBSTACULO em eax
	mov eax, sizeof OBSTACULO
	;multiplica eax com ecx (indice * sizeof)
	mul edx
	;coloca o endereço calculado em edx
	mov edx,eax
	;Faz a verificação da colisao em X
VERIFICAY:	
	mov al,yjogador
	cmp al,obstaculos[edx].y
	je VERIFICAX
	jmp NEXT
;Faz a verificação da colisão em Y
VERIFICAX:
	mov al,xjogador
	cmp al,obstaculos[edx].x
	je COLIDIU
	jmp NEXT
COLIDIU:
	;se colidiu coloca 1 em eax
	mov eax,1
	jmp _RET
NEXT:
	inc ebx
	loop VERIFICA_OBSTACULOS
	;se nao colidiu retorna 0 em eax
	mov eax,0
_RET:
ret
verifica_colisao ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_obstaculo PROC index:DWORD
;Desenha o obstaculo de novo
;Recebe: indice do objeto
;Retorna: nada
;Requer: calculo do endereço efetivo do obstaculo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;coloca o indice em eax 
	mov eax,index
	;coloca o tamanho da struct OBSTACULO em ecx
	mov ecx, SIZEOF OBSTACULO
	;multiplica eax com ecx (indice * sizeof)
	mul ecx
	mov ecx,eax
	;;coloca o cursor na posicao do obstaculo
	mov dl, obstaculos[ecx].x
	mov dh, obstaculos[eax].y
	call Gotoxy
	;troca a cor para azul
	mov EAX, lightBlue+(black*16)
	call SetTextColor
	;coloca em al o caracter do obstaculo 
	mov al, obstaculos[ecx].caracter
	call WriteChar
	ret
desenha_obstaculo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
apaga_obstaculo PROC index:DWORD
;Apaga o obstaculo para atualiza-lo na tela de jogo na nova posicao
;Recebe: indice do objeto
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;coloca o indice em ecx 
	mov ecx,index
	;coloca o tamanho da struct OBSTACULO em eax
	mov eax,SIZEOF OBSTACULO
	;multiplica eax com ecx (indice * sizeof)
	mul ecx
	;coloca o endereço calculado em ecx para acessá-lo
	mov ecx,eax
	;coloca o cursor na posicao do obstaculo
	mov dl, obstaculos[ecx].x
	mov dh, obstaculos[ecx].y
	call Gotoxy
	;substitui o que tem na posicao (obstaculo) por nada
	mov al, ' '
	call WriteChar
	ret
apaga_obstaculo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
anda_obstaculo PROC index:DWORD
;Faz os obstáculos andarem na tela
;Recebe: o indice do objeto que vai andar na tela
;Retorna: nada
;Requer: calculo do endereço do objeto no indice informado
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;coloca em edx, o indice
	mov edx,index
	;coloca em eax o tamanho da struct do tipo OBSTACULO
	mov eax,sizeof OBSTACULO
	;multiplca o indice pelo tamanho para achar o endereço efetivo
	mul edx
	;coloca em edx, o endereço efetivo, ele será nosso indice para acessar os elementos,x,y e caracter
	mov edx,eax
	;compara o x do obstaculo com 78 (ou seja, ele será visivel na tela de jogo)
	cmp obstaculos[edx].x,78
	;se for maior que 78, ele nao será visivel na tela de jogo
	;necessario realizar isso para que haja um espaçamento entre os obstaculos
	ja L0
	;se nao é 78, significa que ele ja está na tela de jogo
	;apaga o obstaculo, passando o indice dele
	INVOKE apaga_obstaculo, index
	;pula para L1
	jmp L1
	;entra nessa label quando a coordenada x do objeto ainda é maior que 78
	L0: 
		;decrementa a coordenada e retorna
		dec obstaculos[edx].x
		jmp RETURN
	;entra nessa label quando a coordenada x do objeto esta abaixo de 78 (visivel)
	L1: 
		;faz o calculo do endereço efetivo do objeto (como acima)
		mov edx,index
		mov eax,sizeof OBSTACULO
		mul edx
		mov edx,eax
		;CONTROLE DE NIVEL: compara o nível atual e salta para a label correspondente
		cmp nivel,0
		je _NIVEL0
		cmp nivel,1
		je _NIVEL1
		
		
		jmp L2
		;No nivel 0, as coordenadas x dos obstáculos serão acrescidas de 1
		;No nível 1 de 2 e assim por diante, dando a impressao que os obstaculos
		;estão mais rápidos
		_NIVEL0: 
			dec obstaculos[edx].x
			JMP L2
		_NIVEL1:
			sub obstaculos[edx].x,2
			JMP L2
	
	L2:
		;compara a coordenada do obstaculo com 0, ou seja, se é 0 o obstaculo vai sair da tela
		cmp obstaculos[edx].x, 0
		;se nao é 0 e nem é menor do que 0,salta para DESENHA que vai desenhar o obstaculo
		jnle DESENHA
		;incrementa a pontuação
		inc pontos
		mov edx,pontos
		cmp edx,melhor_pontuacao
		ja MELHOR_PONTUACAO_MUDA
		JMP CONTINUE
	MELHOR_PONTUACAO_MUDA:
		mov melhor_pontuacao,edx
		;exibe a pontuação atualizada
	CONTINUE:
		INVOKE acrescenta_pontuacao,pontos
		;verifica se nao mudou de nivel
		INVOKE verifica_nivel,pontos
		;calcula o endereço efetivo como acima 
		mov edx,index
		mov eax,sizeof OBSTACULO
		mul edx
		;coloca em edx o endereço efetivo
		mov edx,eax
		;como a coordenada é 0 ou menor que 0, o obstáculo 
		;volta para fora de tela de jogo para entrar novamente com outro y
		mov obstaculos[edx].x,85
		;colcoa 22 em eax, para randomizar a escolha do novo y do obstaculo
		mov eax,22
		;zera as sementes do randomico (necessario para cada execução ser diferente)
		call Randomize
		;gera um randomico de 0 até eax, ou seja, de 0 a 22
		call RandomRange
		;como a tela disponivel de jogo vai de 2 a 24, precisamos adicionar 2 ao randomico gerado
		;para ser um numero de 2 a 24
		add eax,2
		;atualiza o novo y
		mov obstaculos[edx].y, al
    jmp RETURN
	DESENHA:
		;faz o desenho do obstaculo
		INVOKE desenha_obstaculo, index
	RETURN:
		ret
anda_obstaculo ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
game_over PROC
;Chama a tela de Game Over: redesenha a tela e monta o texto de game over e menu
;Recebe: nada
;Retorna:nada 
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;limpa tela
	call Clrscr
	;redesenha a tela (bordas)
	call desenha_tela
	;desenha as letras de game over 
	invoke desenha_menu_G,3,1
	invoke desenha_menu_A,9,1
	invoke desenha_menu_M,19,1
	invoke desenha_menu_E,29,1
	invoke desenha_menu_O,39,1
	invoke desenha_menu_V,48,1
	invoke desenha_menu_E,60,1
	invoke desenha_menu_R,70,1
	;desenha menu de opçoes
	call desenha_opcoes_gameOver
	;chama o controle do menu
	call controla_menu_gameOver
ret
game_over ENDP
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instrucoes PROC
;Desenha a tela de instruções
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;posiciona o cursor em x=35 e y=5
	mov dl,35
	mov dh,5
	call Gotoxy
	;printa a primeira frase de instruções
	mov edx, OFFSET opcao2_mp
	call WriteString
	call Crlf
	;posiciona o cursor em x=15 e y=11
	mov dl,15
	mov dh,11
	call Gotoxy
	;printa a segunda frase de instruções
	mov edx, OFFSET instrucoes_jogo_1
	call WriteString
	call Crlf
	;posiciona o cursor em x=15 e y=13
	mov dl,15
	mov dh,13
	call Gotoxy
	;printa a terceira frase de insruções
	mov edx, OFFSET instrucoes_jogo_2
	call WriteString
	call Crlf
	;posiciona o cursor em x=16 e y=21
	mov dl,16
	mov dh,21
	call Gotoxy
	;printa a quarta frase de instruçoes
	mov edx, OFFSET instrucoes_jogo_3
	call WriteString
	;CONTROLE DO TECLADO PARA QUANDO O USUARIO APERTAR ESC, VOLTAR AO MENU PRINCIPAL
	L0:
		;atribui um delay de 50 para conseguir ler a entrada do usuario
		mov eax,50
		;chama o delay
		call Delay
		;tenta ler uma entrada de usuário
		call ReadKey
		;se não houve entrada do usuário (0) salta para L0 e tenta ler novamente
	jz L0
	;se houve entrada, ve se foi a tecla ESC
	cmp al,27
	;se nao foi esc, volta para tentar uma nova tecla
	jne L0
	;se foi esc, limpa a tela e chama o menu
	call Clrscr
	call desenha_tela
	call desenha_menu
ret
instrucoes ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sobre PROC
;Desenha a tela do menu principal e opção sobre
;Recebe: nada
;Retorna: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;posiciona cursor em x=35, y=3
	mov dl,35
	mov dh,3
	call Gotoxy
	;escreve a primeira frase de sobre (titulo)
	mov edx, OFFSET opcao4_mp
	call WriteString
	call Crlf
	;posiciona o cursor em x=8, y=8
	mov dl,8
	mov dh,8
	call Gotoxy
	;escreve a segunda frase de sobre 
	mov edx, OFFSET sobre_1
	call WriteString
	call Crlf
	;posiciona o cursor em x=16, y=9
	mov dl,16
	mov dh,9
	call Gotoxy
	;escreve a terceira frase de sobre 
	mov edx, OFFSET sobre_2
	call WriteString
	call Crlf
	;posiciona o cursor em x=25, y=10
	mov dl,25
	mov dh,10
	call Gotoxy
	;escreve a quarta frase de sobre 
	mov edx, OFFSET sobre_3
	call WriteString
	call Crlf
	;posiciona o cursor em x=12, y=11
	mov dl,12
	mov dh,11
	call Gotoxy
	;escreve a quinta frase de sobre 
	mov edx, OFFSET sobre_4
	call WriteString
	call Crlf
	;posiciona o cursor em x=16, y=21
	mov dl,16
	mov dh,21
	call Gotoxy
	;escreve a sexta frase de sobre 
	mov edx, OFFSET instrucoes_jogo_3
	call WriteString
	;CONTROLE DA TELA SOBRE: QUANDO O USUARIO PRESSIONA A TECLA ESC, VOLTA AO MENU PRINCIPAL
	L0:
		;atribui um delay de 50 para conseguir ler a entrada do usuario
		mov eax,50
		;chama o delay
		call Delay
		;tenta ler uma entrada de usuário
		call ReadKey
		;se não houve entrada do usuário (0) salta para L0 e tenta ler novamente
	jz L0
	;verifica se o usuario pressionou a tecla ESC
	cmp al,27
	;se nao pressionou, tenta ler uma nova tecla
	jne L0
	;se pressionou chama o menu principal
	call Clrscr
	call desenha_tela
	call desenha_menu
ret
sobre ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_pontuacao PROC
;desenha a pontuação na tela de jogo
;Recebe: nada
;Retorna: nada
;Rqeuer: nada 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call volta_cor_padrao
	mov dl,1
	mov dh,1
	call Gotoxy
	mov edx, OFFSET points
	call WriteString
ret
desenha_pontuacao ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
desenha_nivel PROC
;desenha o nivel na tela de jogo
;Recebe: nada
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call volta_cor_padrao
	mov dl,15
	mov dh,1
	call Gotoxy
	mov edx, OFFSET level
	call WriteString
ret
desenha_nivel ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
acrescenta_nivel PROC nivelJogo:DWORD
;printa o acrescimo de nível de jogo na tela de jogo
;Recebe: o nível atual
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dl, 22
	mov dh,	1
	call Gotoxy
	mov eax, nivelJogo
	call WriteInt
ret
acrescenta_nivel ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
acrescenta_pontuacao PROC pontuacao:DWORD
;printa o acrescimo da pontuação na tela de jogo
;Recebe: a pontuação atual
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call volta_cor_padrao
	mov dl, 9
	mov dh,	1
	call Gotoxy
	mov eax, pontuacao
	call WriteInt
	mov dl,30
	mov dh,1
	call Gotoxy
	mov edx, OFFSET melhor_ponto
	call WriteString
	call acrescenta_melhor_pontuacao
ret
acrescenta_pontuacao ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
acrescenta_melhor_pontuacao PROC 
;printa a melhor pontuação na tela de jogo
;Recebe: a melhor pontuacao atual
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call volta_cor_padrao
	mov dl, 48
	mov dh,	1
	call Gotoxy
	mov eax, melhor_pontuacao
	call WriteInt	
ret
acrescenta_melhor_pontuacao ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
verifica_nivel PROC pontosJogo:DWORD
;Faz a verificação de nivel do jogo. Verifica se a quantidade de pontos é multipla de
;100 e se for, acrescenta 1 no nível
;Recebe: pontos atual no jogo
;Retorna: nada
;Requer: nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;guarda edx, pois na função que ele é chamado, logo após a chamada do procedimento
	;ele é utilizado de novo
	push edx
	;zera edx (resto da divisao)
	mov edx,0
	;coloca em eax, a pontuação do jogo 
	mov eax,pontosJogo 
	;coloca em ebx, 100 (o divisor)
	mov ebx,100
	;realiza a divisao
	div ebx
	;compara se o resto (que esta em edx, apos a divisao) é zero
	cmp edx,0
	;se for 0
	je ATUALIZA
	;se nao for, retorna
	jmp NEXT
ATUALIZA:
	cmp nivel,1
	jl _ATUALIZA
	JMP NEXT
_ATUALIZA:	
	inc nivel
	INVOKE acrescenta_nivel,nivel
NEXT:
pop edx
ret
verifica_nivel ENDP

END main

