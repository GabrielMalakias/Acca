defmodule AccaTest do
  use ExUnit.Case
  doctest Acca

  test "greets the world" do
    assert Acca.hello() == :world
  end
end
