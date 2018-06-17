defmodule FunctionCommand do
  defstruct name: nil, function: nil, args: 0
end

defimpl Command, for: FunctionCommand do
  import MemoryCommand

  @commands_func   [:function]
  @commands_call   [:call]
  @commands_return [:return]


  def to_asm(%FunctionCommand{ name: name } = command, line_num) do
    case name do
      n when n in @commands_func   -> func(command)
      n when n in @commands_call   -> call(command, line_num)
      n when n in @commands_return -> return
    end
  end


  defp func(%FunctionCommand{ function: function, args: args }) do
    label = """
      // define subroutine #{function}[#{args}]
      //
      (#{function})
    """

    clear_locals = Enum.map(1..args, fn(_) -> push_val(0) end)

    [label] ++ clear_locals
  end


  defp call(%FunctionCommand{ function: function, args: args }, line_num) do
    registers = ["#{function}_called.#{line_num}", "LCL", "ARG", "THIS", "THAT"]

    comment = """
      // call subroutine #{function}[#{args}]
      //
    """

    store = Enum.map(registers, &(push_reg &1))

    call = """
      @SP
      D=M
      @#{tempRegister}
      M=D

      @SP               // ARG = SP-n-5
      D=M
      @5
      D=D-A
      @#{args}
      D=D-A
      @SP
      M=D

      @#{tempRegister}  // LCL=SP
      D=M
      @LCL
      M=D

      @#{function}      // goto function
      0;JMP

      (#{function}_called.#{line_num}) // label for return address
    """


    [comment] ++ store ++ [call]
  end


  defp return do
    registers = ["R#{tempRegister+1}", "LCL", "ARG", "THIS", "THAT"]

    comment = """
      // return from subroutine
      //
    """

    pop_arg = pop_reg("ARG")

    frame = """
      @ARG                // SP=ARG+1
      D=M
      @SP
      M=D+1

      @LCL                // FRAME=LCL
      D=M
      @R#{tempRegister}
      M=D
    """

    restore = registers
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reverse
      |> Enum.map(fn({reg, offset}) -> copy_reg(reg, "R#{tempRegister}", -(offset+1)) end)


    jump = """
      @R#{tempRegister+1} // goto RET
      A=M
      0;JMP
    """

    [comment] ++ [pop_arg] ++ [frame] ++ restore ++ [jump]
  end

end