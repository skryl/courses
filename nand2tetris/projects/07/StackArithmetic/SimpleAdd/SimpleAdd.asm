  // push segment[offset] to stack
  //

  @7
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @8
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
