defmodule KeytarTest do
  use ExUnit.Case
  doctest Keytar

  test "greets the world" do
    assert Keytar.hello() == :world
  end
end
