defmodule Jack.VM do
  alias Jack.VM
  alias Jack.VM.Parser
  alias Jack.VM.Compiler

  import VM.MemoryCommand
  import VM.FunctionCommand

  def compile(paths) when is_list(paths) do
    Enum.map(paths, &(Jack.VM.compile &1))
      |> Enum.join("\n")
      |> bootstrap
  end


  def compile(path) when not is_list(path) do
    File.read!(path)
      |> log
      |> Parser.parse
      |> log
      |> Compiler.to_asm
      |> log
  end


  def bootstrap(instructions) do
    call_init = call(%VM.FunctionCommand{function: "Sys.init", args: 0, line: 0})
    bootstrap = Enum.join(set_sp(256) ++ call_init, "\n")

    bootstrap <> instructions
  end


  defp log(output) do
    if Logger.level == :debug do
      if is_binary(output) do
        IO.puts("\n#{output}\n")
      else
        IO.inspect(output)
      end
    end
    output
  end

end