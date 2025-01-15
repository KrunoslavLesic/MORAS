def _parse_macros(self):
    self._init_ends()
    self._iter_lines(self.parse_WHILE)
    self._iter_lines(self.parse_ENDS)
    self._iter_lines(self.parse_MV)
    self._iter_lines(self.parse_SWP)
    self._iter_lines(self.parse_ADD)


# 2.a)
def parse_MV(self, line, p, o):
    if line.startswith('$MV(') and line.endswith(')'):
        args = line[4:-1].split(',')
        if len(args) != 2:
            self._flag = False
            self._errm = "Invalid number of arguments for $MV macro"
            self._line = o
            return ""
        A = line[4:-2].split(',')[0]
        B = line [4:-2].split(',')[1]

        new_lines = [
            f"@{A}",
            "D=M", 
            f"@{B}", 
            "M=D"      
        ]

        return new_lines

    return line


#2.b)
def parse_SWP(self, line, p, o):
    if line.startswith('$SWP(')and line.endswith(')'):
        args = line[5:-1].split(',')
        A = args[0]
        B = args[1]

        if len(args) != 2:
            self._flag = False
            self._errm = f"Invalid number of arguments for macro $SWP "
            self._line = o
            return ""
        k = p
        new_lines = [
            f'@{A}',
            'D=M',
            f'@{k}',
            'M=D',
            f'@{B}',
            'D=M',
            f'@{A}',
            'M=D',
            f'@{k}',
            'D=M',
            f'@{B}',
            'M=D'
        ]
        return new_lines

    return line


#2. c)
def parse_ADD(self, line, p, o):
    if line.startswith('$ADD(') and line.endswith(')'):
        args = line[5:-1].split(',')

        if len(args) != 3:
            self._flag = False
            self._errm = "Invalid number of aruments of ADD macro"
            self._line = o

        A = args[0]
        B = args[1]
        D = args[2]

        new_lines = [
            f'@{A}',
            'D=M',
            f'@{B}',
            'D=D+M',
            f'@{D}',
            'M=D'
        ]
        return new_lines
    
    return line

#2. d)

def parse_WHILE(self, line, p, o):
    if line.startswith('$WHILE(') and line.endswith(')'):
        arg = line[7:-1].split(',')
        n = arg[0]
        if len(arg) != 1:
            self._flag = False 
            self._line = o 
            self._errm = "Invalid number of arguments in $WHILE macro"
            return ''
        _while= f'WHILE_{len(self._ends)}'
        _end = f'END_{len(self._ends)}'
        self._ends.append(_end)

        new_lines = [
            f'({_while})',
            f'@{n}',
            'D=M',
            f'@{_end}',
            'D;JEQ'
        ]
        return new_lines
    
    return line 

def parse_ENDS(self, line, p, o):
    if line == "$END":
        if not self._ends:
            self._flag = False
            self._line = o
            self._errm = "No matching $WHILE for $END"
            return ""

        _end = self._ends.pop()
        _while = f'WHILE_{len(self._ends)}'

        new_lines = [
            f'@{_while}',
            '0;JMP',
            f'({_end})'
        ]
        return new_lines
    
    return line    

def _init_ends(self):
    self._ends = []