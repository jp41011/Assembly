; Juan Pedraza
; csci 126 lab6 3/5/14 - Due: 3/12/14 (next lab)
; This program will:
;	ask user's name
;	promt for number of scores to be recorded (1-10)
;	computers the total and average score
;	displays user's name, total score, and average score in one output window


.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA
scores		DWORD	?,?,?,?,?,?,?,?,?,? ;array to hold scores
numScore	DWORD	? ;number of scores stored (1-10)
sumScore	DWORD	0 ;sum of the scores
avgScore	DWORD	? ;average of the scores
tempNum		DWORD	? ;temp num for calcs
nameLen		DWORD	?


usrName		BYTE	11 DUP(?),0 ;store user name
results		BYTE	"Results",0
outStr		BYTE	250 DUP(?),0 ; finall output string
tempStr		BYTE	11 DUP(?),0 ;to store temp str inputs
label1		BYTE	"String Length: ",0

askName		BYTE	"What is your name: ",0 ;ask for user name
askNum		BYTE	"How many scores: ",0 ;ask for number of scores
askScore	BYTE	"Enter score: ",0 ; ask for score
nameStr		BYTE	"Name: ",0 ;6 chars long
sumStr		BYTE	"Sum: ",0 ;5 chars 
avgStr		BYTE	"Average: ",0 ;9 chars

.CODE
_MainProc PROC

		input askName, usrName, 11 ;ask for user name and store
		atod askName
		dtoa askName, eax
	
askN:	input askNum, tempStr, 11 ;ask number of scores
		atod tempStr
		cmp eax, 1 ;check if less than 1
		jl askN
		cmp eax, 10 ;check if greater than 10
		jg askN

		mov numScore, eax ;otherwise store valid number and continue
		mov ecx, eax ;prepare for loop
		mov edi, [scores] ;get address for scores
		mov sumScore, 0 ;make sure starting off from 0

askS:	input askScore, tempStr, 11
		atod tempStr
		add sumScore, eax ;; add new score to current sum
		mov scores[edi], eax ;store in array
		inc edi ;move to next index
		loop askS

		mov eax, sumScore ;start to calc average
		cdq
		mov ebx, numScore
		div ebx
		mov avgScore, eax

		;count length of usrStr
		mov nameLen, 0
		mov eax, 0
		lea ebx, usrName
loop1:	cmp BYTE PTR [ebx], 0 ;null char
		je	done1
		inc eax
		inc ebx
		jmp loop1
done1:	mov nameLen, eax

		;combine into one output string
		lea edi, outStr
		lea esi, nameStr
		mov ecx, 6
		cld
		rep movsb
		mov eax, nameLen
		lea edi, outStr[6];outStr+6
		lea esi, usrName
		mov ecx, eax
		cld
		rep movsb
		
		mov outStr[eax+6], 0dH

		lea edi, outStr[eax+7] ;outStr+17+1
		lea esi, sumStr
		mov ecx, 5
		cld
		rep movsb
		lea edi, outStr[eax+7+5] ;outStr+17+6
		dtoa tempStr, sumScore
		lea esi, tempStr
		mov ecx, 11
		cld
		rep movsb

		;mov outStr+17+6+11, 0dH
		mov outStr[eax+7+5+11], 0dH

		lea edi, outStr[eax+7+5+11+1] ;outStr+17+6+11+1
		lea esi, avgStr
		mov ecx, 9
		cld
		rep movsb
		lea edi, outStr[eax+7+5+11+1+9] ;outStr+17+6+11+9
		dtoa tempStr, avgScore
		lea esi, tempStr
		mov ecx, 11
		cld
		rep movsb
		;mov outStr+17+6+22+9, 0dH
		mov outStr[eax+7+5+11+1+9+11], 0dH

		output results, outStr

	; THE END
	mov eax, 0 ;clean up and ready to exit
	ret
_MainProc ENDP
END