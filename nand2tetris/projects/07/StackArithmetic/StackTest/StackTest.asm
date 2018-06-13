  // push segment[offset] to stack
  //

  @17
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @17
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // eq values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.2
  D;JEQ
  (FALSE.2)
  D=0
  @END.2
  0;JMP
  (TRUE.2)
  D=-1
  (END.2)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @17
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @16
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // eq values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.5
  D;JEQ
  (FALSE.5)
  D=0
  @END.5
  0;JMP
  (TRUE.5)
  D=-1
  (END.5)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @16
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @17
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // eq values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.8
  D;JEQ
  (FALSE.8)
  D=0
  @END.8
  0;JMP
  (TRUE.8)
  D=-1
  (END.8)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @892
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @891
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // lt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.11
  D;JLT
  (FALSE.11)
  D=0
  @END.11
  0;JMP
  (TRUE.11)
  D=-1
  (END.11)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @891
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @892
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // lt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.14
  D;JLT
  (FALSE.14)
  D=0
  @END.14
  0;JMP
  (TRUE.14)
  D=-1
  (END.14)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @891
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @891
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // lt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.17
  D;JLT
  (FALSE.17)
  D=0
  @END.17
  0;JMP
  (TRUE.17)
  D=-1
  (END.17)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32767
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32766
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // gt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.20
  D;JGT
  (FALSE.20)
  D=0
  @END.20
  0;JMP
  (TRUE.20)
  D=-1
  (END.20)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32766
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32767
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // gt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.23
  D;JGT
  (FALSE.23)
  D=0
  @END.23
  0;JMP
  (TRUE.23)
  D=-1
  (END.23)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32766
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @32766
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // gt values in R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @TRUE.26
  D;JGT
  (FALSE.26)
  D=0
  @END.26
  0;JMP
  (TRUE.26)
  D=-1
  (END.26)

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @57
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @31
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @53
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // add values in temp registers R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M+D

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @112
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // sub values in temp registers R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M-D

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // neg value in R13 and put result into R13
  //

  @R13
  D=M
  D=-D
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // and values in temp registers R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M&D

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @82
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R14
  M=D

  // or values in temp registers R13 and R14 and put result into R13
  //

  @R13
  D=M

  @R14
  D=M|D

  @R13
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp register @R{12+n}
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // not value in R13 and put result into R13
  //

  @R13
  D=M
  D=!D
  M=D

  // push temp register @R{12+n} to stack
  //

  @R13
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1
