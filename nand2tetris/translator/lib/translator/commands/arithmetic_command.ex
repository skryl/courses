defmodule ArithmeticCommand do
  defstruct name: nil
end


defimpl Command, for: ArithmeticCommand do

  @commands_binary [:add, :sub, :and, :or]
  @commands_unary  [:neg, :not]
  @commands_comp   [:eq, :gt, :lt]


  def to_asm(%ArithmeticCommand{ name: cmd }) do
    case cmd do
      n when n in @commands_binary -> pop(2) |> op(cmd) |> push(1)
      n when n in @commands_comp   -> pop(2) |> op(cmd) |> push(1)
      n when n in @commands_unary  -> pop(1) |> op(cmd) |> push(1)
    end
  end


  def pop(num) do
    pop([], num)
  end


  def pop(stream, num) do
    asm = Enum.map 1..num, fn n -> """
      // pop value from stack into @arg#{n}
      //

      @SP
      M=M-1
      A=M
      D=M

      @arg#{n}
      M=D
    """
    end

    stream ++ asm
  end


  def push(stream, num) do
    asm = Enum.map 1..num, fn n -> """
      // push arg#{n} to stack
      //

      @arg#{n}
      D=M

      @SP
      A=M
      M=D

      @SP
      M=M+1
    """
    end

    stream ++ asm
  end


  def op(stream, cmd) when cmd in @commands_binary do
    asm_op = case cmd do
      :add -> "+"
      :sub -> "-"
      :and -> "&"
      :or  -> "|"
    end

    asm = """
      // #{cmd} values in arg1 and arg2 and put result in arg1
      //

      @arg1
      D=M

      @arg2
      D=D#{asm_op}M

      @arg1
      M=D
    """

    stream ++ [asm]
  end


  def op(stream, cmd) when cmd in @commands_unary do
    asm_op = case cmd do
      :neg -> "-"
      :not -> "!"
    end

    asm = """
      // #{cmd} value in arg1 and put result in arg1
      //

      @arg1
      D=M
      D=#{asm_op}D
      M=D
    """

    stream ++ [asm]
  end


  def op(stream, cmd) when cmd in @commands_comp do
    asm_op = case cmd do
      :eq  -> "EQ"
      :gt  -> "GT"
      :lt  -> "LT"
    end

    asm = """
      // #{cmd} values in arg1 and arg2 and put result in arg1
      //

      @arg1
      D=M

      @arg2
      D=D-M

      @TRUE
      D;J#{asm_op}
      (FALSE)
      D=0
      @END
      0;JMP
      (TRUE)
      D=-1
      (END)

      @arg1
      M=D
    """

    stream ++ [asm]
  end


end