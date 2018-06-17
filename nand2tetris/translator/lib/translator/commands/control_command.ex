defmodule ControlCommand do
  defstruct name: nil, symbol: nil
end

defimpl Command, for: ControlCommand do
  import MemoryCommand

  @commands_label [:label]
  @commands_goto  [:goto]
  @commands_cond  [:"if-goto"]


  def to_asm(%ControlCommand{ name: name } = command, line_num) do
    case name do
      n when n in @commands_label -> label(command, line_num)
      n when n in @commands_goto  -> goto(command, line_num)
      n when n in @commands_cond  -> pop(1) |> cond(command, line_num)
    end
  end


  def pop(num) do
    [pop_temp(num)]
  end


  defp label(%{symbol: sym}, line_num) do
    asm = """
      // create a label
      //
      (#{sym})
    """

    [asm]
  end


  defp goto(%{name: name, symbol: sym}, line_num) do
    asm = """
      // jump to label #{sym}
      //
      @#{sym}
      0;JMP
    """

    [asm]
  end


  defp cond(stream, %{name: name, symbol: sym}, line_num) do
    asm = """
      // conditional jump to label #{sym}
      //
      @R#{tempRegister}
      D=M
      @#{sym}
      D;JNE
    """

    stream ++ [asm]
  end

end