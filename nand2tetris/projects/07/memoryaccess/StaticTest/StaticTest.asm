  // push segment[offset] to stack
  //

  @111
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @333
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @888
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @8
  D=A
  @16
  D=A+D
  @R13
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R13
  A=M
  M=D

  // pop value from stack into segment[offset]
  //

  @3
  D=A
  @16
  D=A+D
  @R13
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R13
  A=M
  M=D

  // pop value from stack into segment[offset]
  //

  @1
  D=A
  @16
  D=A+D
  @R13
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R13
  A=M
  M=D

  // push segment[offset] to stack
  //

  @3
  D=A
  @16
  A=A+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @1
  D=A
  @16
  A=A+D
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

  // push segment[offset] to stack
  //

  @8
  D=A
  @16
  A=A+D
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
