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

  // op values in arg1 and arg2 and put result in arg1
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
