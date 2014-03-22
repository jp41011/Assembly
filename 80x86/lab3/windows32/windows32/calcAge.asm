; Juan Pedraza
; csci 126 lab3 2/5/14
; Ask for name and birth day. Calculate age and then display along with their name.

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA
;user's info
usrName	Byte	40 DUP (?),0; user's name
month	DWORD	?			; month of birthday
day		DWORD	?			; day of birthday
year	DWORD	?			; year of birthday
temp	DWORD	?			; temp

;todays
month2	DWORD	2			; today's month
day2	DWORD	5			; today's day
year2	DWORD	2014		; today's year
age		DWORD	?
ageString	Byte	20 DUP(?),0	; to store age


;ask strings
askName	Byte	"What is your name?",0
askDay	Byte	"What is your birthday (Day)?",0
askMonth Byte	"What is your birthday (Month)?",0
askYear	Byte	"What is your birthday (Year)?",0
; for debugging
usrDay	Byte	"Your Day",0
usrMonth Byte	"Your Month",0
usrYear	Byte	"Your Year",0
myYear	Byte	"My Year",0
myMonth Byte	"My Month",0
myDay	Byte	"My Day",0

;output strings
printName	Byte	"Hello ",0
printAge	Byte	"Your age is: ",0

.CODE
_MainProc PROC
	;dtoa ageString, month2
	;output myMonth, ageString
	;dtoa ageString, day2
	;output myDay, ageString
	;dtoa ageString, year2
	;output myYear, ageString

	; get values
	input askName, usrName, 40 ; read ASCII chars
	
	input askMonth, temp, 4
	atod temp		;convert from ascii to integer
	mov month, eax	; move to month variable
	
	input askDay, temp, 4
	atod temp
	mov day, eax

	input askYear, temp, 5
	atod temp
	mov	year, eax
	
	; calculate age
	;mov eax, 0
	mov eax, year2
	sub eax, year
	mov age, eax
	
	;check month and day
	;dtoa ageString, month
	;output usrMonth, ageString
	;dtoa ageString, day
	;output usrDay, ageString
	;dtoa ageString, month2		; my month2 (2 - Feb) changes to 0 for some reason
	;output myMonth, ageString
	;dtoa ageString, day2
	;output myDay, ageString
	
	;check month and day
	mov eax, month
	cmp eax, month2
	jl endd
	mov eax, day
	cmp eax, day2
	jl endd

	;minus one
	mov ebx, age
	sub ebx, 1
	mov age, ebx

endd:	
	dtoa ageString, age

	;print
	output printName, usrName
	output printAge, ageString

	mov eax, 0 ;clean up and ready to exit
	ret
_MainProc ENDP
END