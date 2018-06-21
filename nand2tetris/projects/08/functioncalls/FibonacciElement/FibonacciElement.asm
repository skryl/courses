  @256
  D=A
  @SP
  M=D

  // call subroutine Sys.init[0]
  //

  // push Sys.init_called.0 to stack
  //

  @Sys.init_called.0
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @LCL to stack
  //

  @LCL
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @ARG to stack
  //

  @ARG
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THIS to stack
  //

  @THIS
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THAT to stack
  //

  @THAT
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  @SP           // LCL=SP
  D=M
  @LCL
  M=D

  @SP           // ARG = SP-args-5
  D=M
  @5
  D=D-A
  @0
  D=D-A
  @ARG
  M=D

  @Sys.init  // goto function
  0;JMP

  (Sys.init_called.0) // label for return address
  // define subroutine Main.fibonacci[0]
  //
  (Main.fibonacci)

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

  // lt values in R12 and R13 and put result into R12
  //

  @R12
  D=M

  @R13
  D=M-D

  @TRUE.3
  D;JLT
  (FALSE.3)
  D=0
  @END.3
  0;JMP
  (TRUE.3)
  D=-1
  (END.3)

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

  // conditional jump to label IF_TRUE
  //
  @R12
  D=M
  @IF_TRUE
  D;JNE

  // jump to label IF_FALSE
  //
  @IF_FALSE
  0;JMP

  // create a label
  //
  (IF_TRUE)

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

  // return from subroutine
  //

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

  // create a label
  //
  (IF_FALSE)

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

  // call subroutine Main.fibonacci[1]
  //

  // push Main.fibonacci_called.13 to stack
  //

  @Main.fibonacci_called.13
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @LCL to stack
  //

  @LCL
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @ARG to stack
  //

  @ARG
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THIS to stack
  //

  @THIS
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THAT to stack
  //

  @THAT
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  @SP           // LCL=SP
  D=M
  @LCL
  M=D

  @SP           // ARG = SP-args-5
  D=M
  @5
  D=D-A
  @1
  D=D-A
  @ARG
  M=D

  @Main.fibonacci  // goto function
  0;JMP

  (Main.fibonacci_called.13) // label for return address

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

  // call subroutine Main.fibonacci[1]
  //

  // push Main.fibonacci_called.17 to stack
  //

  @Main.fibonacci_called.17
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @LCL to stack
  //

  @LCL
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @ARG to stack
  //

  @ARG
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THIS to stack
  //

  @THIS
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THAT to stack
  //

  @THAT
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  @SP           // LCL=SP
  D=M
  @LCL
  M=D

  @SP           // ARG = SP-args-5
  D=M
  @5
  D=D-A
  @1
  D=D-A
  @ARG
  M=D

  @Main.fibonacci  // goto function
  0;JMP

  (Main.fibonacci_called.17) // label for return address

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

  // return from subroutine
  //

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

  // define subroutine Sys.init[0]
  //
  (Sys.init)

  // push constant[4] to stack
  //

  @4
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // call subroutine Main.fibonacci[1]
  //

  // push Main.fibonacci_called.2 to stack
  //

  @Main.fibonacci_called.2
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @LCL to stack
  //

  @LCL
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @ARG to stack
  //

  @ARG
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THIS to stack
  //

  @THIS
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push @THAT to stack
  //

  @THAT
  D=M

  @SP
  A=M
  M=D

  @SP
  M=M+1

  @SP           // LCL=SP
  D=M
  @LCL
  M=D

  @SP           // ARG = SP-args-5
  D=M
  @5
  D=D-A
  @1
  D=D-A
  @ARG
  M=D

  @Main.fibonacci  // goto function
  0;JMP

  (Main.fibonacci_called.2) // label for return address

  // create a label
  //
  (WHILE)

  // jump to label WHILE
  //
  @WHILE
  0;JMP
