		AREA test, CODE, READWRITE
		ENTRY
		EXPORT main
			

main	PROC
        LDR     R0, =array
        LDR     R1, [R0], #4

        CMP     R1, #1
        BLE     one_element_array

        CMP     R1, #2
        BLE     two_element_array

        MOV     R10, R1, LSR #1
        SUB     R10, R10, #1
        SUB     R9, R1, #1
        MOV     R2, R10

heapify
        MOV     R3, R2
        ADD     R4, R2, R2
        ADD     R4, R4, #1
        ADD     R5, R2, R2
        ADD     R5, R5, #2

        LDR     R6, [R0, R2, LSL #2]
        MOV     R7, R6

left_heapify
        CMP     R4, R9
        BGT     right_heapify

        LDR     R8, [R0, R4, LSL #2]
        CMP     R8, R7
        BLT     right_heapify

        MOV     R3, R4
        MOV     R7, R8

right_heapify
        CMP     R5, R9
        BGT     heapify_swap

        LDR     R8, [R0, R5, LSL #2]
        CMP     R8, R7
        BLT     heapify_swap

        MOV     R3, R5
        MOV     R7, R8

heapify_swap
        CMP     R2, R3
        BEQ     heapify_next

        STR     R7, [R0, R2, LSL #2]
        STR     R6, [R0, R3, LSL #2]
        MOV     R2, R3
        B       heapify

heapify_next
        CMP     R10, #0
        BEQ     heapify_pop

        SUB     R10, R10, #1
        MOV     R2, R10
        B       heapify

heapify_pop
        LDR     R3, [R0]
        LDR     R4, [R0, R9, LSL #2]
        STR     R3, [R0, R9, LSL #2]
        STR     R4, [R0]
        SUB     R9, R9, #1
        CMP     R9, #1
        BEQ     two_element_array
        MOV     R2, #0
        B       heapify

two_element_array
        LDR     R2, [R0]
        LDR     R3, [R0, #4]
        CMP     R2, R3
        BLT     finish
        STR     R3, [R0]
        STR     R2, [R0, #4]

one_element_array
        B       finish

finish
        B       finish

array    DCD 6, 2, 8, 4, 6, 1, 12

        ENDP
        END