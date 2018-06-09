defmodule MemoryCommand do
  defstruct name: nil, segment: nil, index: 0
end

defimpl Command, for: MemoryCommand do

  @segment_map %{ constant: "0",
                  pointer:  "3",
                  temp:     "5",
                  local:    "LCL",
                  argument: "ARG",
                  this:     "THIS",
                  that:     "THAT" }


  def to_asm(%MemoryCommand{ name: cmd, segment: seg, index: idx }) do
    case cmd do
      :push -> push(seg, idx)
      :pop  -> pop(seg, idx)
    end
  end


  def push(seg, offset) do
    offset = """
      // push segment[offset] to stack
      //

      @#{offset}
      D=A
    """

    mem_load = """
      @#{@segment_map[seg]}
      A=A+D
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
      // pop value from stack into segment[offset]
      //

      @SP
      M=M-1
      A=M
      D=M

      @#{offset}
      D=A
      @#{@segment_map[seg]}
      A=A+D
      D=M
    """

    [asm]
  end

end