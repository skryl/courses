defprotocol Command do
  @fallback_to_any true

  def to_asm(command)
end

defimpl Command, for: Any do

  def to_asm(command) do
    "// NOOP"
  end

end
