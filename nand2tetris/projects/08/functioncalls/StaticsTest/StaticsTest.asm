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
  // define subroutine Class1.set[0]
  //
  (Class1.set)

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

  // pop value from stack into static[0]
  //

  @0
  D=A
  @16
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

  // pop value from stack into static[1]
  //

  @1
  D=A
  @16
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

  // define subroutine Class1.get[0]
  //
  (Class1.get)

  // push static[0] to stack
  //

  @0
  D=A
  @16
  A=A+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push static[1] to stack
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

  // define subroutine Class2.set[0]
  //
  (Class2.set)

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

  // pop value from stack into static[0]
  //

  @0
  D=A
  @16
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

  // pop value from stack into static[1]
  //

  @1
  D=A
  @16
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

  // define subroutine Class2.get[0]
  //
  (Class2.get)

  // push static[0] to stack
  //

  @0
  D=A
  @16
  A=A+D
  D=M
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push static[1] to stack
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

  // push constant[6] to stack
  //

  @6
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push constant[8] to stack
  //

  @8
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // call subroutine Class1.set[2]
  //

  // push Class1.set_called.3 to stack
  //

  @Class1.set_called.3
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
  @2
  D=D-A
  @ARG
  M=D

  @Class1.set  // goto function
  0;JMP

  (Class1.set_called.3) // label for return address

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

  // push constant[23] to stack
  //

  @23
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push constant[15] to stack
  //

  @15
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // call subroutine Class2.set[2]
  //

  // push Class2.set_called.7 to stack
  //

  @Class2.set_called.7
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
  @2
  D=D-A
  @ARG
  M=D

  @Class2.set  // goto function
  0;JMP

  (Class2.set_called.7) // label for return address

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

  // call subroutine Class1.get[0]
  //

  // push Class1.get_called.9 to stack
  //

  @Class1.get_called.9
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

  @Class1.get  // goto function
  0;JMP

  (Class1.get_called.9) // label for return address

  // call subroutine Class2.get[0]
  //

  // push Class2.get_called.10 to stack
  //

  @Class2.get_called.10
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

  @Class2.get  // goto function
  0;JMP

  (Class2.get_called.10) // label for return address

  // create a label
  //
  (WHILE)

  // jump to label WHILE
  //
  @WHILE
  0;JMP
