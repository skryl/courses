defmodule Translator.CLI do
  require Logger

  def main(argv) do
    argv
    |> parse_args
    |> process
  end


  def run(argv) do
    parse_args(argv)
  end


  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    IO.inspect("parse_args: #{inspect parse}")

    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ path ], _ } -> { path }
      _ -> :help
    end
  end


  def process(:help) do
    IO.puts "usage: translator PATH"
    System.halt(0)
  end


  def process({ path }) do
    Translator.Parser.parse(path)
  end

end