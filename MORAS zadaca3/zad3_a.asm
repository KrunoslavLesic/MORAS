//  Program koji u R2 sprema sumu prirodnih brojeva izmedu pozitivnih brojeva
//  zapisanih u R0 i R1, uključujući R0 i R1.

@1
D = M
@0
D = D + M
@2
M = 0
@END 
D; JLE

@0
D = M
@1
D = D - M
@SKOCI
D; JGT

@0
D = M
@i 
M = D + 1
@1
D = M
@0
D = D - M
@n
M = D - 1
@2
@SKOCI_1
0;JMP

(SKOCI)
@n 
M = D -1
@1
D = M
@i 
M = D + 1
@2
M = 0
(SKOCI_1)
$WHILE(n)
    @i
    D = M
    @SKOCI_2
    D;JLT 
    (VRATI)
    $ADD(2, i, 2)
    @i 
    M = M + 1
    @n
    M = M - 1
$END



(END)
@END
0;JMP 

(SKOCI_2)
@i
D = M
M = M - D
@n
M = M+D
@VRATI
0;JMP
