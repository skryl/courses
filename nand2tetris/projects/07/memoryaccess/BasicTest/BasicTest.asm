  // push segment[offset] to stack
  //

  @10
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
  @LCL
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

  @21
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @22
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
  @ARG
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

  // pop value from stack into segment[offset]
  //

  @1
  D=A
  @ARG
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

  @36
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

  @42
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // push segment[offset] to stack
  //

  @45
  D=A
  @SP
  A=M
  M=D

  @SP
  M=M+1

  // pop value from stack into segment[offset]
  //

  @5
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

  // pop value from stack into segment[offset]
  //

  @2
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

  @510
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
  @5
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

  // push segment[offset] to stack
  //

  @5
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

  // push segment[offset] to stack
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
  @THIS
  A=M+D
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
  @5
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
