defprotocol Command do
  @fallback_to_any true

  def to_asm(command, line_num)
end

defimpl Command, for: Any do

  def to_asm(command, line_num) do
    """

      // NOOP

    """
  end

end
