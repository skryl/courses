defmodule Translator.Parser do
  require Logger

  @memory_commands     ["push", "pop"]
  @function_commands   ["function", "call", "return"]
  @control_commands    ["label", "goto", "if-goto"]
  @arithmetic_commands ["add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"]


  def parse(path) do
    IO.inspect "parse: #{path}"
    out = String.replace(path, ".vm", ".asm")

    instructions = File.read!(path)
      |> String.split("\n")
      |> clean
      |> tokenize
      |> List.flatten
      |> Enum.join("\n")

    IO.puts instructions
    File.write!(out, instructions)
  end


  # clear comments and empty lines
  #
  defp clean(lines) do
    Enum.filter lines, fn(line) ->
      trimmed = String.trim(line)
      String.length(trimmed) > 0 &&
      String.slice(trimmed, 0..1) != "//"
    end
  end


  # convert instructions to tuples of the form { instr, arg1, arg2 }
  #
  defp tokenize(lines) do
    Enum.map (lines |> Enum.with_index), fn({ line, num }) ->
      line |> String.trim
           |> String.split(" ")
           |> List.to_tuple
           |> from_tuple
           |> Command.to_asm(num)
    end
  end


  # convert tuples to proper types
  #
  defp from_tuple(tuple) do
    case tuple do
      {name, seg, idx} when name in @memory_commands ->
        %MemoryCommand{name: String.to_atom(name), segment: String.to_atom(seg), index: idx}

      {name, fname, vars} when name in @function_commands ->
        %FunctionCommand{name: String.to_atom(name), function_name: fname, num_vars: vars}

      {name, sym} when name in @control_commands ->
        %ControlCommand{name: String.to_atom(name), symbol: sym}

      {name} when name in @arithmetic_commands ->
        %ArithmeticCommand{name: String.to_atom(name)}

      _ -> %NoOpCommand{name: String.to_atom(elem(tuple, 0))}
    end
  end


end
