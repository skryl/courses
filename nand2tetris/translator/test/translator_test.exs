defmodule TranslatorTest do
  use ExUnit.Case
  doctest Translator

  test "greets the world" do
    assert Translator.hello() == :world
  end
end
