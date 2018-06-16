defmodule ArithmeticCommand do
  defstruct name: nil
end


defimpl Command, for: ArithmeticCommand do
  import MemoryCommand

  @commands_binary [:add, :sub, :and, :or]
  @commands_unary  [:neg, :not]
  @commands_comp   [:eq, :gt, :lt]


  def to_asm(%ArithmeticCommand{ name: cmd }, line_num) do
    case cmd do
      n when n in @commands_binary -> pop(2) |> op(cmd, line_num) |> push(1)
      n when n in @commands_comp   -> pop(2) |> op(cmd, line_num) |> push(1)
      n when n in @commands_unary  -> pop(1) |> op(cmd, line_num) |> push(1)
    end
  end


  def pop(num) do
    [pop_temp(num)]
  end


  def push(stream, num) do
    stream ++ [push_temp(num)]
  end


  def op(stream, cmd, line_num) when cmd in @commands_binary do
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


  def op(stream, cmd, line_num) when cmd in @commands_unary do
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


  def op(stream, cmd, line_num) when cmd in @commands_comp do
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

      @TRUE.#{line_num}
      D;J#{asm_op}
      (FALSE.#{line_num})
      D=0
      @END.#{line_num}
      0;JMP
      (TRUE.#{line_num})
      D=-1
      (END.#{line_num})

      @R#{tempRegister}
      M=D
    """

    stream ++ [asm]
  end


end