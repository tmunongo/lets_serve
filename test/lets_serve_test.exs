defmodule LetsServeTest do
  use ExUnit.Case
  doctest LetsServe

  test "greets the world" do
    assert LetsServe.hello() == :world
  end
end
