; Juan Pedraza
; csci 126 lab4 2/12/14
; Delcare two 5 element DW arrays
; add 2 to the first array
; sub 2 from the second array
; exchange in reverse order between arrays
; see how using ebx vs eax changes the 

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA
array1	DWORD	21H, 22H, 23H, 24H, 25H ;1st array
array2	DWORD	31H, 32H, 33H, 34H, 35H	;2nd array

elem	BYTE	10 DUP(?),0	; to print number in array
count	DWORD	0			;counter for array

one1	BYTE	"Array1 element1 is:",0
one2	BYTE	"Array1 element2 is:",0
one3	BYTE	"Array1 element3 is:",0
one4	BYTE	"Array1 element4 is:",0
one5	BYTE	"Array1 element5 is:",0

two1	BYTE	"Array2 element1 is",0	;for second array
two2	BYTE	"Array2 element2 is",0
two3	BYTE	"Array2 element3 is",0
two4	BYTE	"Array2 element4 is",0
two5	BYTE	"Array2 element5 is",0

.CODE
_MainProc PROC

	;add 2 to each element of array 1
	mov ebx, array1+0
	inc ebx
	inc ebx
	mov array1+0, ebx

	mov ebx, array1+4
	inc ebx
	inc ebx
	mov array1+4, ebx

	mov ebx, array1+8
	inc ebx
	inc ebx
	mov array1+8, ebx

	mov ebx, array1+12
	inc ebx
	inc ebx
	mov array1+12, ebx

	mov ebx, array1+16
	inc ebx
	inc ebx
	mov array1+16, ebx

	; subtract 2 from each element of array2
	mov ebx, array2+0
	dec ebx
	dec ebx
	mov array2+0, ebx

	mov ebx, array2+4
	dec ebx
	dec ebx
	mov array2+4, ebx

	mov ebx, array2+8
	dec ebx
	dec ebx
	mov array2+8, ebx
	
	mov ebx, array2+12
	dec ebx
	dec ebx
	mov array2+12, ebx

	mov ebx, array2+16
	dec ebx
	dec ebx
	mov array2+16, ebx

	;swap in reverse order
	mov ebx, array1+0	;1st array1
	xchg ebx, array2+16	;5th array2
	mov array1+0, ebx
	
	mov ebx, array1+4
	xchg ebx, array2+12
	mov array1+4, ebx
	
	mov ebx, array1+8
	xchg ebx, array2+8
	mov array1+8, ebx

	mov ebx, array1+12
	xchg ebx, array2+4
	mov array1+12, ebx

	mov ebx, array1+16
	xchg ebx, array2+0
	mov array1+16, ebx

	;print arrays
	dtoa	elem, array1+0
	output	one1, elem
	dtoa	elem, array1+4
	output	one2, elem
	dtoa	elem, array1+8
	output	one3, elem
	dtoa	elem, array1+12
	output	one4, elem
	dtoa	elem, array1+16
	output	one5, elem

	dtoa	elem, array2+0
	output	two1, elem
	dtoa	elem, array2+4
	output	two2, elem
	dtoa	elem, array2+8
	output	two3, elem
	dtoa	elem, array2+12
	output	two4, elem
	dtoa	elem, array2+16
	output	two5, elem

	; THE END
	mov eax, 0 ;clean up and ready to exit
	ret
_MainProc ENDP
END