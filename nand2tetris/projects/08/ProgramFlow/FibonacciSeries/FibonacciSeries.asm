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

  // pop value from stack into pointer[1]
  //

  @1
  D=A
  @3
  D=A+D
  @R12
  M=D

  @SP
  M=M-1
  A=M
  D=M

  @R12
  A=M
  M=D

  // push constant[0] to stack
  //

  @0
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into that[0]
  //

  @0
  D=A
  @THAT
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

  // push constant[1] to stack
  //

  @1
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into that[1]
  //

  @1
  D=A
  @THAT
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

  // push constant[2] to stack
  //

  @2
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

  // create a label
  //
  (MAIN_LOOP_START)

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

  // conditional jump to label COMPUTE_ELEMENT
  //
  @R12
  D=M
  @COMPUTE_ELEMENT
  D;JNE

  // jump to label END_PROGRAM
  //
  @END_PROGRAM
  0;JMP

  // create a label
  //
  (COMPUTE_ELEMENT)

  // push that[0] to stack
  //

  @0
  D=A
  @THAT
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push that[1] to stack
  //

  @1
  D=A
  @THAT
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

  // pop value from stack into that[2]
  //

  @2
  D=A
  @THAT
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

  // push pointer[1] to stack
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

  // pop value from stack into pointer[1]
  //

  @1
  D=A
  @3
  D=A+D
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

  // jump to label MAIN_LOOP_START
  //
  @MAIN_LOOP_START
  0;JMP

  // create a label
  //
  (END_PROGRAM)
