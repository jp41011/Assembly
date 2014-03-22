; Juan Pedraza
; CSCI 112 - Lab 7
; Takes 10 numbers from the user
; numbers separated by a space
; puts the numbers into an array and sorts the array using selection sort
; print out the original array and the sorted array in one output box
 
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
scoreArray	DWORD 10 dup (?) ; unsorted values
sortedArr	DWORD 10 dup(?) ;sorted array. not used. inplace sorting instead w/ scoreArray 
count1		dword 0
indexi		DWORD 0	;index to use in outer loop
indexj		DWORD 0 ;index to use in inner loop
min			DWORD 0 ; current min
tmpVal		DWORD 0 ;

prompt1		BYTE "Enter ten scores (separated by a space each): ",0
prompt2		BYTE "output is: ",0

out1		BYTE "Original scores: ",0	;17 char
out2		BYTE "Sorted scores: ",0	;15 char
results		BYTE "Results",0
finalStr	BYTE 250 DUP(?),0 ;final output string
tmpStr		BYTE 11 DUP(?),0 ;temp string

scoreString	byte 40 dup(?),0; //for 5 scores - make enough room


temp byte 11 dup(?),0
tempx byte 11 dup(" "),0;     //or,..dup(20H); 20H=space
temp2 byte 11 dup(?),0


.CODE
_MainProc PROC
		input	prompt1, scoreString, 40; //gets ten scores
		lea ebx, scoreString
		
outerLoop: inc count1; //outer loop counter++
		lea esi, tempx; //flush temp string before using
		lea edi, temp
		cld
		mov ecx, 11
		rep movsb
		
		lea edx, temp;
innerLoop: cmp byte ptr[ebx], 20h; //if ending mark(space), done
		je done1; 
		cmp byte ptr[ebx], 00h;     //elsif null char, also done
		je done1;
		mov AL, byte ptr[ebx]; //otherwise, get 1 byte from input string
		mov [edx], AL;         //and move it to temp

		inc ebx;       //to next byte in input string
		inc edx;       //to next byte in temp string
		jmp innerLoop; //inner loop (temp <- one score)
		
done1: ;output prompt2, temp; test display of temp 
		atod temp; //eax <- temp

		mov ecx, count1;
		dec ecx;       //counter:1 -> array index:0
		imul ecx, 4;   //array ele size = 4 bytes
		mov scoreArray[ecx], eax; //store one score in array
		 
		inc ebx;       //skip the end mark(space) in the input string
		cmp count1, 10; //loop 10 times
		;cmp count1, 5; //loop 5 times
		jnge outerLoop
		
		;dtoa temp2, scoreArray[0]; or, scorearray+0; //testing display
		;output  prompt2, temp2
;Juan's code
		;make first part of final output string
		lea esi, out1
		lea edi, finalStr
		mov ecx, 17
		cld
		rep movsb
		lea edi, finalStr[17]
		dtoa tmpStr, scoreArray[0] ;first 
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+11]
		dtoa tmpStr, scoreArray[4] ;2nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+22]
		dtoa tmpStr, scoreArray[8] ;3nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+33]
		dtoa tmpStr, scoreArray[12] ;4nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+44]
		dtoa tmpStr, scoreArray[16] ;5nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+55]
		dtoa tmpStr, scoreArray[20] ;6nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+66]
		dtoa tmpStr, scoreArray[24] ;7nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+77]
		dtoa tmpStr, scoreArray[28] ;8nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+88]
		dtoa tmpStr, scoreArray[32] ;9nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[17+99]
		dtoa tmpStr, scoreArray[36] ;10nd
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		mov finalStr[17+110], 0dH ;new line
		lea edi, finalStr[17+111]
		lea esi, out2
		mov ecx, 15
		cld
		rep movsb ;finalStr[32+111] next spot

		;selection sort
		mov indexi, 0 ;reset indexes
		mov indexj, 0
		lea ebx, scoreArray ;get address of array
outloop: cmp indexi, 10 ;ten values in array
		jge done2 ;exit if went through whole array
		mov eax, [ebx]
		mov min, eax ;set current index as min
		mov ecx, ebx
		add ecx, 4 ;second pointer to the next index
		mov eax, indexi
		inc eax
		mov indexj, eax

inloop: cmp indexj, 10
		jge inOut
		mov eax, [ecx]
		cmp min, eax ;check if less than
		jle endIn ;don't need to update min
		mov min, eax ;need to update min
		mov edx, ecx ;store address of min
endIn: inc indexj
		add ecx, 4 ;move to next index
		jmp inloop

inOut: ;swap min to front ebx <- edx
		mov eax, [ebx] ;temp store value that needs to be swapped
		mov tmpVal, eax
		mov eax, [edx] ;put min at the front (left)
		mov [ebx], eax
		mov eax, tmpVal
		mov [edx], eax
		inc indexi
		add ebx, 4
		jmp outloop

done2: ;copy sorted array to final string
		lea edi, finalStr[32+111] ;1st
		dtoa tmpStr, scoreArray[0]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+11] ;2nd
		dtoa tmpStr, scoreArray[4]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+22] ;3nd
		dtoa tmpStr, scoreArray[8]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+33] ;4nd
		dtoa tmpStr, scoreArray[12]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+44] ;5nd
		dtoa tmpStr, scoreArray[16]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+55] ;6nd
		dtoa tmpStr, scoreArray[20]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+66] ;7nd
		dtoa tmpStr, scoreArray[24]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+77] ;8nd
		dtoa tmpStr, scoreArray[28]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+88] ;9nd
		dtoa tmpStr, scoreArray[32]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb
		lea edi, finalStr[32+111+99] ;10nd
		dtoa tmpStr, scoreArray[36]
		lea esi, tmpStr
		mov ecx, 11
		cld
		rep movsb

		output results, finalStr

		mov     eax, 0
		ret
_MainProc ENDP
END

