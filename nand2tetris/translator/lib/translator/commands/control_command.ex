defmodule ControlCommand do
  defstruct name: nil, symbol: nil

  defimpl Command, for: ControlCommand do

    def to_asm(command, line_num) do
      String.upcase command.name
    end

  end

end
