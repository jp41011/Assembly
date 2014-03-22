; Juan Pedraza
; CSCI 112 - Lab 8
; Takes 10 scores (separated by spaces) from the user
; uses a function call to calculate the average score
; and a 2nd function call to calculate the max score
; then prints out the results in a single output box

.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
scoreArray	DWORD	10 DUP(?) ;array to store scores
avgScore	DWORD	0
maxScore	DWORD	0
count1		DWORD	?


prompt1		BYTE	"Enter ten scores (separated by spaces): ",0
out1		BYTE	"Scores: ",0 ;8char
out2		BYTE	"Average: ",0 ;9char
out3		BYTE	"Maximum: ",0 ;9char
results		BYTE	"Results:",0
finalStr	BYTE	250 DUP(?),0 ;final output string
temp		BYTE	11 DUP(?),0
tempx		BYTE	11 DUP(" "),0


scoreString	BYTE	40 DUP(?),0 ;store input string of scores

.CODE
_MainProc PROC

			input prompt1, scoreString, 40	;get the 10 scores
			lea ebx, scoreString			;get address of string
outerLoop: inc count1 ;outer loop counter
			lea esi, tempx ;flush temp string before using
			lea edi, temp
			cld
			mov ecx, 11
			rep movsb

			lea edx, temp
innerLoop: cmp BYTE PTR[ebx], 20H ;if ending mark(space)
			je done1 ;exit
			mov AL, BYTE PTR[ebx] ;else get 1 byte from input string
			mov [edx], AL ;move to temp

			inc ebx ;to next byte in input string
			inc edx ;to next byte in temp string
			jmp innerLoop

done1:
			atod temp ;eax <- temp
			mov ecx, count1
			dec ecx ;counter:1->array index:0
			imul ecx, 4 ;array element size = 4 bytes
			mov scoreArray[ecx], eax ;store one score in array

			inc ebx ;skip space char
			cmp count1, 10 ;loop 10 times
			jnge outerLoop
;call functions
			;mov eax, 10
			;push eax ;onto stack as the 2nd arugment
			pushd 10
			lea eax, scoreArray
			push eax ;onto stack as the 1st argument
			call average
			mov avgScore, eax ;return value in eax
			add esp, 8 ;pushed 2 4-byte values onto stack
			
			;call maximum
			pushd 10 ;push number of elements onto stack
			lea eax, scoreArray
			push eax ;push address of array onto stack
			call maximum
			mov maxScore, eax
			add esp, 8

;create output string
			lea esi, out1
			lea edi, finalStr
			mov ecx, 8
			cld
			rep movsb
			lea edi, finalStr[8]
			dtoa temp, scoreArray[0] ;1st
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+11]
			dtoa temp, scoreArray[4] ;2nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+22]
			dtoa temp, scoreArray[8] ;3nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+33]
			dtoa temp, scoreArray[12] ;4nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+44]
			dtoa temp, scoreArray[16] ;5nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+55]
			dtoa temp, scoreArray[20] ;6nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+66]
			dtoa temp, scoreArray[24] ;7nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+77]
			dtoa temp, scoreArray[28] ;8nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+88]
			dtoa temp, scoreArray[32] ;9nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			lea edi, finalStr[8+99]
			dtoa temp, scoreArray[36] ;10nd
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			mov finalStr[8+110], 0dH ;newline
			lea edi, finalStr[8+111] ;next line title average
			lea esi, out2
			mov ecx, 9
			cld
			rep movsb
			lea edi, finalStr[8+111+9] ;put average value
			dtoa temp, avgScore
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb
			mov finalStr[8+111+9+11], 0dH ;newline
			lea edi, finalStr[17+122+1] ;put title max
			lea esi, out3
			mov ecx, 9
			cld
			rep movsb
			lea edi, finalStr[27+122] ;put max value
			dtoa temp, maxScore
			lea esi, temp
			mov ecx, 11
			cld
			rep movsb

			output results, finalStr

			mov     eax, 0
			ret
_MainProc ENDP

;average PROC takes in a reference to an array and a count of elements
;go through array adding elements to current sum
;divide total sum by number of elements count
;and return sum as eax
average PROC
			push ebp		;save base pointer
			mov ebp, esp	;establish stack frame
			;push eax	;save registers. will use as temp
			push ebx	;will use a sum
			push ecx	;loop counter
			push edx	;number of elements
			push esi	;pointer to array

			mov esi, [ebp+8] ;get address of array
			mov ecx, [ebp+12] ;get count. count=10
			mov edx, ecx ;store count
			sub ebx, ebx ;reset sum
loopSum:	mov eax, [esi] ;get number
			add ebx, eax ;add to current sum
			add esi, 4 ;next element
			loop loopSum
			;out of loop
			mov ecx, edx ;reset ecx to the original count
			mov eax, ebx ;prepare for division
			cdq
			idiv ecx
			;average in eax //average is calc correctly
			;exit code restore register to before func call
			pop esi
			pop edx
			pop ecx
			pop ebx
			pop ebp
			ret
average ENDP

;maximum PROC takes in a reference to the begining of an array and a count of elements
;calculate max. set temp max equal to 1st element
; go through rest of array comparing elements to the current max
; update current max if needed. return max in eax and restore stack 
maximum PROC
			push ebp
			mov ebp, esp

			;push ebx ; current max //save registers
			push ecx ;loop counter
			;push edx ;store count
			push esi ;address of array

			mov esi, [ebp+8] ;get address of array
			mov ecx, [ebp+12] ;get count

			mov eax, [esi] ;set as initial max
			inc ecx ;start at 2nd element
			add esi, 4
loopMax:	cmp [esi], eax ;array element > max ?
			jng endIf1 ;jump if not greater than
			mov eax, [esi] ;update new max
endIf1:		add esi, 4
			loop loopMax
			;max in eax //exit loop clean up before returning
			pop esi
			pop ecx
			pop ebp
			ret
maximum ENDP

END

