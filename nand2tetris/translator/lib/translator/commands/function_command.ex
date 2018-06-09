defmodule FunctionCommand do
  defstruct name: nil, function_name: nil, num_vars: 0

  defimpl Command, for: FunctionCommand do

    def to_asm(command) do
      String.upcase command.name
    end

  end
end