defprotocol Jack.VM.Command do
  @fallback_to_any true

  def to_asm(command)
end

defimpl Jack.VM.Command, for: Any do

  def to_asm(_) do
    """

      // NOOP

    """
  end

end