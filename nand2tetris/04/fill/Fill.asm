// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
//


@fill
M=0

// check keyboard value and fill screen if non zero, clear otherwise
//
(MLOOP)
  @KBD
  D=M

  @fill
  M=-1
  @FILL
  D;JGT

  @fill
  M=0
  @FILL
  D;JEQ

  @MLOOP
  0;JMP


// fill subroutine, uses @fill value to fill screen
//
(FILL)
  // set p to screen address
  @SCREEN
  D=A
  @p
  M=D

  @24576
  D=A
  @pend
  M=D

(FLOOP)

  // finish if done
  @p
  D=M
  @pend
  D=M-D
  @MLOOP
  D;JEQ

  // fill pixel
  @fill
  D=M
  @p
  A=M
  M=D

  // increment p
  @p
  M=M+1

  // repeat
  @FLOOP
  0;JMP
