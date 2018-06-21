defmodule Jack.VM.Compiler do
  alias Jack.VM.Command

  def to_asm(tokens) do
    Enum.map(tokens, &(Command.to_asm(&1)))
      |> List.flatten
      |> Enum.join("\n")
  end

end