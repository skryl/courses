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


  # repeat k times:
  #  PUSH 0
  #
  defp func(%FunctionCommand{ function: function, args: args }) do
    label = """
      // define subroutine #{function}[#{args}]
      //
      (#{function})
    """

    clear_locals = Enum.map(0..args |> Enum.filter(&(&1>0)), fn(i) -> push_val(0) end)

    [label] ++ clear_locals
  end


  #   push return-address // (using label below)
  #   push LCL
  #   push ARG
  #   push THIS
  #   push THAT
  #   ARG = SP-n-5
  #   LCL = SP
  #   goto f
  # (return-address)
  #
  defp call(%FunctionCommand{ function: function, args: args }, line_num) do
    addresses = ["#{function}_called.#{line_num}"]
    registers = ["LCL", "ARG", "THIS", "THAT"]

    comment = """
      // call subroutine #{function}[#{args}]
      //
    """

    store_addresses = Enum.map(addresses, &(push_val &1))
    store_registers = Enum.map(registers, &(push_reg &1))

    call = """
      @SP           // LCL=SP
      D=M
      @LCL
      M=D

      @SP           // ARG = SP-args-5
      D=M
      @5
      D=D-A
      @#{args}
      D=D-A
      @ARG
      M=D

      @#{function}  // goto function
      0;JMP

      (#{function}_called.#{line_num}) // label for return address
    """


    [comment] ++ store_addresses ++ store_registers ++ [call]
  end


  #  FRAME=LCL
  #  RET=*(FRAME-5)
  #  *ARG=pop()
  #  SP=ARG+1
  #  THAT=*(FRAME-1)
  #  THIS=*(FRAME-2)
  #  ARG=*(FRAME-3)
  #  LCL=*(FRAME-4)
  #  goto RET
  #
  defp return do
    registers = ["LCL", "ARG", "THIS", "THAT"]

    frame = """
      // return from subroutine
      //

      @LCL                // FRAME=LCL
      D=M
      @R#{tempRegister}
      M=D
    """

    ret = copy_reg("R#{tempRegister+1}", "R#{tempRegister}", -5)

    pop_arg = pop_reg("ARG")

    sp = """
      @ARG                // SP=ARG+1
      D=M
      @SP
      M=D+1
    """

    restore_regs = registers
      |> Enum.reverse |> Enum.with_index |> Enum.reverse
      |> Enum.map(fn({reg, offset}) -> copy_reg(reg, "R#{tempRegister}", -(offset+1)) end)

    jump = """
      @R#{tempRegister+1} // goto RET
      A=M
      0;JMP
    """

    [frame] ++ [ret] ++ [pop_arg] ++ [sp] ++ restore_regs ++ [jump]
  end

end