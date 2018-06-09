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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // eq values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JEQ
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // eq values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JEQ
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // eq values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JEQ
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // lt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JLT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // lt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JLT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // lt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JLT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // gt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JGT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // gt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JGT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // gt values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @TRUE
  D;JGT
  (FALSE)
  D=0
  @END
  0;JMP
  (TRUE)
  D=-1
  (END)

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // add values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D+M

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // sub values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D-M

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // neg value in arg1 and put result in arg1
  //

  @arg1
  D=M
  D=-D
  M=D

  // push arg1 to stack
  //

  @arg1
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // and values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D&M

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
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

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // pop value from stack into @arg2
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg2
  M=D

  // or values in arg1 and arg2 and put result in arg1
  //

  @arg1
  D=M

  @arg2
  D=D|M

  @arg1
  M=D

  // push arg1 to stack
  //

  @arg1
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into @arg1
  //

  @SP
  M=M-1
  A=M
  D=M

  @arg1
  M=D

  // not value in arg1 and put result in arg1
  //

  @arg1
  D=M
  D=!D
  M=D

  // push arg1 to stack
  //

  @arg1
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1
