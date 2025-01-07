@2054
D = A
@i
M = D;


(VERTIKALNA_CRTA)
    @i 
    D = M;
    @6150
    D = D - A;
    @KRAJ_VERTIKALNE_CRTE
    D; JGE


    @i
    D = M;
    @SCREEN
    A = A + D;
    M = 1
    

    @32
    D = A;
    @i
    M = M + D;
    @VERTIKALNA_CRTA
    0; JMP

(KRAJ_VERTIKALNE_CRTE)

(DONJA_CRTA)

    @i
    D = M
    @6158
    D = D - A
    @DONJA_CRTA_KRAJ
    D; JGE

    @i
    D = M;
    @SCREEN
    A = A + D;
    M = -1

    @1
    D = A 
    @i 
    M = M + D;
    @DONJA_CRTA
    0; JMP 

(DONJA_CRTA_KRAJ)


@j
M = 0

@2054
D = A
@i
M = D;

(KOSA_CRTA)
    @i 
    D = M;
    @6158
    D = D - A;
    @KOSA_CRTA_KRAJ
    D; JGE

    @j 
    D = M
    @16
    D = D - A 
    @preskoci
    D; JGE

    @j 
    D= M

    (Vrati)
    @pomakni
    M = D 

    @vrijednost
    M = 1



(POMAKNI_PETLJA)
    @pomakni 
    D = M
    @KRAJ_POMAKNI_PETLJE
    D; JEQ

    @vrijednost
    D = M 
    D = D + M 
    M = D

    @pomakni 
    M = M - 1
    @POMAKNI_PETLJA
    0;JMP 

(KRAJ_POMAKNI_PETLJE)


@i 
D = M 
@SCREEN
D = A + D
M = D 

@vrijednost 
D = M 
@SCREEN
A = M 
M = D 



@j 
M = M + 1

@i
D=M
@32
D=D+A
@i
M=D

@KOSA_CRTA
0; JMP

(KOSA_CRTA_KRAJ)
@SCREEN 
M = 0
(TEST)
@2086
D = A
@k
M = D
@x
M=1
(LOOP)
@16
D = A
@x
D=M-D 
@LOOP_END
D; JGE

@k
D = M 
@SCREEN
A = A + D
M = M + 1

@32 
D = A 
@k 
M = M + D 

@x 
M = M + 1

@LOOP
0;JMP
(LOOP_END)

(END)
@END
0; JMP


(preskoci)
    @j 
    M = 0
    @i 
    M = M + 1
    @Vrati
    0;JMP