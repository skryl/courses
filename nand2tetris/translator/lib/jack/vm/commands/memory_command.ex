defmodule Jack.VM.MemoryCommand do
  defstruct name: nil, segment: nil, index: 0, line: nil

  @segment_map %{ constant: "0",
                  pointer:  "3",
                  temp:     "5",
                  static:   "16",
                  local:    "LCL",
                  argument: "ARG",
                  this:     "THIS",
                  that:     "THAT" }

  def tempRegister, do: 12

  def pop_temp(num) do
    asm = Enum.map Range.new(0, num-1), fn n -> """
      // pop value from stack into temp @R#{tempRegister+n}
      //

      @SP
      M=M-1
      A=M
      D=M

      @R#{tempRegister+n}
      M=D
    """
    end

    asm
  end


  def pop_reg(reg) do
    asm = """
      // pop value from stack into *#{reg}
      //

      @SP
      M=M-1
      A=M
      D=M

      @#{reg}
      A=M
      M=D
    """

    [asm]
  end


  def push_temp(num) do
    asm = Enum.map Range.new(0, num-1), fn n -> """
      // push temp @R#{tempRegister+n} to stack
      //

      @R#{tempRegister+n}
      D=M

      @SP
      A=M
      M=D

      @SP
      M=M+1
    """
    end

    asm
  end


  def push_reg(reg) do
    asm = """
      // push @#{reg} to stack
      //

      @#{reg}
      D=M

      @SP
      A=M
      M=D

      @SP
      M=M+1
    """

    [asm]
  end


  def push_val(val) do
    asm = """
      // push #{val} to stack
      //

      @#{val}
      D=A

      @SP
      A=M
      M=D

      @SP
      M=M+1
    """

    [asm]
  end


  def copy_reg(destination, origin, offset) do
    asm = """
      // copy @#{origin}[offset] to @#{destination}
      //

      @#{origin}
      D=M
      @#{abs(offset)}
      A=D#{offset < 0 && "-" || "+"}A
      D=M
      @#{destination}
      M=D
    """

    [asm]
  end


  def push(seg, offset) do
    offset = """
      // push #{seg}[#{offset}] to stack
      //

      @#{offset}
      D=A
    """

    mem_load = """
      @#{@segment_map[seg]}
      A=#{indirect?(seg) && "M" || "A"}+D
      D=M
    """

    push_stack = """
      @SP
      A=M
      M=D

      @SP
      M=M+1
    """

    asm = offset <> (if seg != :constant, do: mem_load, else: "") <> push_stack

    [asm]
  end


  def pop(seg, offset) do
    asm = """
      // pop value from stack into #{seg}[#{offset}]
      //

      @#{offset}
      D=A
      @#{@segment_map[seg]}
      D=#{indirect?(seg) && "M" || "A"}+D
      @R#{tempRegister}
      M=D

      @SP
      M=M-1
      A=M
      D=M

      @R#{tempRegister}
      A=M
      M=D
    """

    [asm]
  end


  def set_sp(val) do
    asm = """
      @#{val}
      D=A
      @SP
      M=D
    """

    [asm]
  end


  defp indirect?(seg) do
    try do
      addr = @segment_map[seg]
      String.to_integer(addr)
      false
    rescue
      ArgumentError -> true
    end
  end

end


defimpl Jack.VM.Command, for: Jack.VM.MemoryCommand do
  alias Jack.VM
  import VM.MemoryCommand

  def to_asm(%VM.MemoryCommand{ name: cmd, segment: seg, index: idx}) do
    case cmd do
      :push -> push(seg, idx)
      :pop  -> pop(seg, idx)
    end
  end
end