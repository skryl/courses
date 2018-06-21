defmodule Jack.CLI do
  require Logger

  def main(argv) do
    { path, opts } = parse_args(argv)
    configure(opts)
    compile(path, opts)
  end


  def run(argv) do
    parse_args(argv)
  end


  def parse_args(argv) do
    parse = OptionParser.parse(argv,
      switches: [ help:    :boolean,
                  verbose: :boolean,
                  vm:      :boolean,
                  output:  :string],
      aliases:  [ h: :help,
                  v: :verbose,
                  m: :vm,
                  o: :output ])

    Logger.debug("parse_args: #{inspect parse}")

    case parse do
      { [ help: true ], _, _  } -> help()
      { _ = opts, [ path ], _ } -> { path, opts }
      _ -> help()
    end
  end


  defp help do
    IO.puts "usage: jack [opts] PATH"
    System.halt(0)
  end


  defp configure(opts) do
    if opts[:verbose] do
      Logger.configure(level: :debug)
    end
  end


  defp compile(path, opts) do
    { filename, instructions } =
      if File.dir?(path) do
        process_directory(path, opts)
      else
        process_file(path, opts)
      end

    Logger.info("writing output to #{filename}")
    File.write!(filename, instructions)
  end


  defp process_file(path, opts) do
    Logger.info("compiling file #{path}")
    output = opts[:output] || String.replace(path, ".vm", ".asm")
    instructions = Jack.VM.compile([path])

    { output, instructions }
  end


  defp process_directory(path, opts) do
    Logger.info("compiling directory #{path}")
    output = opts[:output] || "#{path}/#{Path.basename(path)}.asm"
    paths = Path.wildcard("#{path}/*.vm")
    Logger.info("compiling files #{paths}")
    instructions = Jack.VM.compile(paths)

    { output, instructions }
  end

end