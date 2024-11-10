defmodule LetsServe.ServerTest do
  use ExUnit.Case
  doctest LetsServe.Server

  alias LetsServe.Server

  describe "TCP server" do
    test "creates a new TCP server instance with valid config" do
      server = Server.new(:tcp, "127.0.0.1", 4040, TestHandler)

      assert server.type == :tcp
      assert server.host == "127.0.0.1"
      assert server.port == 4040
      assert server.handler == TestHandler
    end

    test "raise error with invalid IP address" do
      assert_raise ArgumentError, ~r/port must be between 1 and 65535/, fn ->
        Server.new(:tcp, "127.0.0.1", 70000, TestHandler)
      end
    end

    test "raises error with invalid IP address" do
      assert_raise ArgumentError, ~r/invalid IP address/, fn ->
        Server.new(:tcp, "300.300.300.300", 4040, TestHandler)
      end
    end
  end
end
