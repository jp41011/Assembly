; Juan Pedraza
; csci 126 lab5 2/19/14 - Due: 2/25/14
; This program ask the user for 4 Fahrenheit temperatures
; convert them to Celsius temperatures
; Finally in a single output box display all the temps and the average celsius temperature

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA
fTemps	DWORD	?,?,?,? ;array to hold fahrenheit temperatures
cTemps	DWORD	?,?,?,?	;to hold celsius temps
avgTemp	DWORD	0
outStr	BYTE	250 DUP(?),0 ; final output string
fstring	BYTE	"Fahrenheit temp: "
cstring	BYTE	"Celsius temp: "
avgstr	BYTE	"Average C temp: "
results	BYTE	"Results",0
elem	BYTE	11 DUP(?),0	;temp string to get inputs
f1		BYTE	"1 Farhrenheit:",0
f2		BYTE	"2 Farhrenheit:",0
f3		BYTE	"3 Farhrenheit:",0
f4		BYTE	"4 Farhrenheit:",0
c1		BYTE	"1 Celsius:",0
c2		BYTE	"2 Celsius:",0
c3		BYTE	"3 Celsius:",0
c4		BYTE	"4 Celsius:",0

.CODE
_MainProc PROC

	;ask for farhrenheit values
	input f1,elem, 11	;1st
	atod elem
	mov fTemps+0, eax
	input f2,elem, 11	;2nd
	atod elem
	mov fTemps+4, eax
	input f3,elem, 11	;3rd
	atod elem
	mov fTemps+8, eax
	input f4,elem, 11	;4th
	atod elem
	mov fTemps+12, eax

	;convert
	mov eax, fTemps+0 ;1st
	sub eax, 32
	imul eax, 5
	cdq
	mov ebx, 9
	div ebx ; also tried idiv and it gave the same answers
	mov cTemps+0, eax
	mov eax, fTemps+4 ;2nd temp
	sub eax, 32
	imul eax, 5
	cdq
	mov ebx, 9
	div ebx
	mov cTemps+4, eax
	mov eax, fTemps+8 ;3nd temp
	sub eax, 32
	imul eax, 5
	cdq
	mov ebx, 9
	div ebx
	mov cTemps+8, eax
	mov eax, fTemps+12 ;4nd temp
	sub eax, 32
	imul eax, 5
	cdq
	mov ebx, 9
	div ebx
	mov cTemps+12, eax
	; Conversion works!!
	;calc average temp
	sub eax, eax
	add eax, cTemps+0
	add eax, cTemps+4
	add eax, cTemps+8
	add eax, cTemps+12
	cdq
	mov bx, 4
	div bx
	mov avgTemp, eax ; calculates average correctly !

	; combine all info into one string
	lea edi, outStr
	lea esi, fstring ;fahrenheit string
	cld
	mov ecx, 17
	rep movsb
	;mov outStr+17, 0dH
	
	; add values
	lea edi, outStr+17
	dtoa elem, fTemps+0
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb
	;mov outStr+17+11, 20H ;1st num
	;lea edi, outStr+17+11+1
	lea edi, outStr+17+11
	dtoa elem, fTemps+4
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb
	;mov outStr+17+22+1, 20H ; space after 2nd number
	;lea edi, outStr+17+22+2
	lea edi, outStr+17+22
	dtoa elem, fTemps+8
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb
	;mov outStr+17+33+2+1, 20H ; 3rd # space
	lea edi, outStr+17+33
	dtoa elem, fTemps+12
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb	
	mov outStr+17+44, 0dH ; new line
	lea edi, outStr+18+44
	lea esi, cstring
	cld
	mov ecx, 14
	rep movsb
	lea edi, outStr+18+44+14
	dtoa elem, cTemps+0
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb ; 1st celsius
	lea edi, outStr+18+55+14
	dtoa elem, cTemps+4
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb ;2nd celsius
	lea edi, outStr+18+66+14
	dtoa elem, cTemps+8
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb ;3rd celcius
	lea edi, outStr+18+77+14
	dtoa elem, cTemps+12
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb ;4th celcius
	mov outStr+18+88+14, 0dH ; new line
	lea edi, outStr+19+88+14
	lea esi, avgstr
	cld
	mov ecx, 16
	rep movsb ;average string	
	lea edi, outStr+19+88+14+16
	dtoa elem, avgTemp
	lea esi, elem
	cld
	mov ecx, 11
	rep movsb ;celsius average

	output results, outStr ;output results

	; THE END
	mov eax, 0 ;clean up and ready to exit
	ret
_MainProc ENDP
END