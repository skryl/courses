defmodule JackTest do
  use ExUnit.Case
  doctest Jack

  test "greets the world" do
    assert Jack.hello() == :world
  end
end
