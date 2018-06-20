  // define subroutine Sys.init[0]
  //
  (Sys.init)

  // push constant[4000] to stack
  //

  @4000
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into pointer[0]
  //

  @0
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

  // push constant[5000] to stack
  //

  @5000
  D=A
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

  // call subroutine Sys.main[0]
  //

  // push Sys.main_called.5 to stack
  //

  @Sys.main_called.5
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

  @Sys.main  // goto function
  0;JMP

  (Sys.main_called.5) // label for return address

  // pop value from stack into temp[1]
  //

  @1
  D=A
  @5
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

  // create a label
  //
  (LOOP)

  // jump to label LOOP
  //
  @LOOP
  0;JMP

  // define subroutine Sys.main[5]
  //
  (Sys.main)

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

  // push 0 to stack
  //

  @0
  D=A

  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push constant[4001] to stack
  //

  @4001
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into pointer[0]
  //

  @0
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

  // push constant[5001] to stack
  //

  @5001
  D=A
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

  // push constant[200] to stack
  //

  @200
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into local[1]
  //

  @1
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

  // push constant[40] to stack
  //

  @40
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into local[2]
  //

  @2
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

  // push constant[6] to stack
  //

  @6
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into local[3]
  //

  @3
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

  // push constant[123] to stack
  //

  @123
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // call subroutine Sys.add12[1]
  //

  // push Sys.add12_called.21 to stack
  //

  @Sys.add12_called.21
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

  @Sys.add12  // goto function
  0;JMP

  (Sys.add12_called.21) // label for return address

  // pop value from stack into temp[0]
  //

  @0
  D=A
  @5
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

  // push local[2] to stack
  //

  @2
  D=A
  @LCL
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push local[3] to stack
  //

  @3
  D=A
  @LCL
  A=M+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push local[4] to stack
  //

  @4
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

  // define subroutine Sys.add12[0]
  //
  (Sys.add12)

  // push constant[4002] to stack
  //

  @4002
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into pointer[0]
  //

  @0
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

  // push constant[5002] to stack
  //

  @5002
  D=A
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

  // push constant[12] to stack
  //

  @12
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
