  // define subroutine SimpleFunction.test[2]
  //
  (SimpleFunction.test)

  // push 0 to stack
  //

  @0
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push 0 to stack
  //

  @0
  D=A

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

  // push local[1] to stack
  //

  @1
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

  // pop value from stack into temp @R12
  //

  @SP
  M=M-1
  A=M
  D=M

  @R12
  M=D

  // not value in R12 and put result into R12
  //

  @R12
  D=M
  D=!D
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

  // push argument[1] to stack
  //

  @1
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

  // return from subroutine
  //

  // pop value from stack into *ARG
  //

  @SP
  M=M-1
  A=M
  D=M

  @ARG
  A=M
  M=D

  @ARG                // SP=ARG+1
  D=M
  @SP
  M=D+1

  @LCL                // FRAME=LCL
  D=M
  @R12
  M=D

  // copy @R12[offset] to @R13
  //

  @R12
  D=M
  @5
  A=D-A
  D=M
  @R13
  M=D

  // copy @R12[offset] to @LCL
  //

  @R12
  D=M
  @4
  A=D-A
  D=M
  @LCL
  M=D

  // copy @R12[offset] to @ARG
  //

  @R12
  D=M
  @3
  A=D-A
  D=M
  @ARG
  M=D

  // copy @R12[offset] to @THIS
  //

  @R12
  D=M
  @2
  A=D-A
  D=M
  @THIS
  M=D

  // copy @R12[offset] to @THAT
  //

  @R12
  D=M
  @1
  A=D-A
  D=M
  @THAT
  M=D

  @R13 // goto RET
  A=M
  0;JMP
