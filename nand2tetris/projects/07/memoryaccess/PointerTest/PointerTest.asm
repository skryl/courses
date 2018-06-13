  // push segment[offset] to stack
  //

  @3030
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @0
  D=A
  @3
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

  @3040
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @1
  D=A
  @3
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

  @32
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @2
  D=A
  @THIS
  D=M+D
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

  @46
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @6
  D=A
  @THAT
  D=M+D
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

  @0
  D=A
  @3
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
  @3
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

  // push segment[offset] to stack
  //

  @2
  D=A
  @THIS
  A=M+D
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

  @6
  D=A
  @THAT
  A=M+D
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
