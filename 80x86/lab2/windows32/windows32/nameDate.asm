; Juan Pedraza
; csci 126 lab2
; get name and date and print out

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA
name0	BYTE	40 DUP (?)	;to store name
name1	DWORD	?
name2	BYTE	4 DUP (?)	; same as name1?
date	BYTE	10 DUP (?)	; to store date mm/dd/yyyy
string	BYTE	"Your Name & Date",0 ; the comma and 0 is an ending character
askName	BYTE	"Enter your name:",0
askDate BYTE	"What is the date:",0

.CODE
_MainProc PROC
	input askName, name0, 40	; Double word is 4 bytes

	input askDate, date, 10

	output string, name0
	output string, date

	mov eax, 0 ;clean up and ready to exit
	ret
_MainProc ENDP
END