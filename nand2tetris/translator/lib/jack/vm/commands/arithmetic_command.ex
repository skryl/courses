defmodule Jack.VM.ArithmeticCommand do
  defstruct name: nil, line: nil
  import Jack.VM.MemoryCommand

  @commands_binary [:add, :sub, :and, :or]
  @commands_unary  [:neg, :not]
  @commands_comp   [:eq, :gt, :lt]


  def pop(num) do
    [pop_temp(num)]
  end


  def push(stream, num) do
    stream ++ [push_temp(num)]
  end


  def op(stream, cmd, _) when cmd in @commands_binary do
    asm_op = case cmd do
      :add -> "+"
      :sub -> "-"
      :and -> "&"
      :or  -> "|"
    end

    asm = """
      // #{cmd} values in temp registers R#{tempRegister} and R#{tempRegister+1} and put result into R#{tempRegister}
      //

      @R#{tempRegister}
      D=M

      @R#{tempRegister+1}
      D=M#{asm_op}D

      @R#{tempRegister}
      M=D
    """

    stream ++ [asm]
  end


  def op(stream, cmd, _) when cmd in @commands_unary do
    asm_op = case cmd do
      :neg -> "-"
      :not -> "!"
    end

    asm = """
      // #{cmd} value in R#{tempRegister} and put result into R#{tempRegister}
      //

      @R#{tempRegister}
      D=M
      D=#{asm_op}D
      M=D
    """

    stream ++ [asm]
  end


  def op(stream, cmd, line) when cmd in @commands_comp do
    asm_op = case cmd do
      :eq  -> "EQ"
      :gt  -> "GT"
      :lt  -> "LT"
    end

    asm = """
      // #{cmd} values in R#{tempRegister} and R#{tempRegister+1} and put result into R#{tempRegister}
      //

      @R#{tempRegister}
      D=M

      @R#{tempRegister+1}
      D=M-D

      @TRUE.#{line}
      D;J#{asm_op}
      (FALSE.#{line})
      D=0
      @END.#{line}
      0;JMP
      (TRUE.#{line})
      D=-1
      (END.#{line})

      @R#{tempRegister}
      M=D
    """

    stream ++ [asm]
  end

end


defimpl Jack.VM.Command, for: Jack.VM.ArithmeticCommand do
  alias Jack.VM
  import VM.ArithmeticCommand

  @commands_binary [:add, :sub, :and, :or]
  @commands_unary  [:neg, :not]
  @commands_comp   [:eq, :gt, :lt]

  def to_asm(%VM.ArithmeticCommand{ name: cmd, line: line }) do
    case cmd do
      n when n in @commands_binary -> pop(2) |> op(cmd, line) |> push(1)
      n when n in @commands_comp   -> pop(2) |> op(cmd, line) |> push(1)
      n when n in @commands_unary  -> pop(1) |> op(cmd, line) |> push(1)
    end
  end
end