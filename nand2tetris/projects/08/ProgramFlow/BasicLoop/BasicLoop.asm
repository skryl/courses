  // push constant[0] to stack
  //

  @0
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into local[0]
  //

  @0
  D=A
  @LCL
  D=M+D
  @R12
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R12
  A=M
  M=D

  // create a label
  //
  (LOOP_START)

  // push argument[0] to stack
  //

  @0
  D=A
  @ARG
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push local[0] to stack
  //

  @0
  D=A
  @LCL
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp @R12
  //

  @SP
  M=M-1
  A=M
  D=M

  @R12
  M=D

  // pop value from stack into temp @R13
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // add values in temp registers R12 and R13 and put result into R12
  //

  @R12
  D=M

  @R13
  D=M+D

  @R12
  M=D

  // push temp @R12 to stack
  //

  @R12
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into local[0]
  //

  @0
  D=A
  @LCL
  D=M+D
  @R12
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R12
  A=M
  M=D

  // push argument[0] to stack
  //

  @0
  D=A
  @ARG
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push constant[1] to stack
  //

  @1
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp @R12
  //

  @SP
  M=M-1
  A=M
  D=M

  @R12
  M=D

  // pop value from stack into temp @R13
  //

  @SP
  M=M-1
  A=M
  D=M

  @R13
  M=D

  // sub values in temp registers R12 and R13 and put result into R12
  //

  @R12
  D=M

  @R13
  D=M-D

  @R12
  M=D

  // push temp @R12 to stack
  //

  @R12
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into argument[0]
  //

  @0
  D=A
  @ARG
  D=M+D
  @R12
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R12
  A=M
  M=D

  // push argument[0] to stack
  //

  @0
  D=A
  @ARG
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into temp @R12
  //

  @SP
  M=M-1
  A=M
  D=M

  @R12
  M=D

  // conditional jump to label LOOP_START
  //
  @R12
  D=M
  @LOOP_START
  D;JNE

  // push local[0] to stack
  //

  @0
  D=A
  @LCL
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1
