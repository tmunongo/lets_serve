defmodule LetsServe.Server do
  @moduledoc """
  Provides a simple interface for creating TCP and UDP servers.

  ## Examples

    iex> server = LetsServe.Server.new(:tcp, "127.0.0.1", 4040, MyHandler)
    iex> server.type
    :tcp
  """

  @type t :: %__MODULE__{
    type: :tcp | :udp,
    host: String.t(),
    port: integer(),
    handler: module()
  }

  defstruct [:type, :host, :port, :handler]

  @spec new(atom(), String.t(), integer(), module()) :: t()
  def new(type, host, port, handler) when type in [:tcp, :udp] do
    with :ok <- validate_port(port),
         :ok <- validate_ip(host) do
           %__MODULE__{
            type: type,
            host: host,
            port: port,
            handler: handler
           }
         end
  end

  defp validate_port(port) when is_integer(port) and port > 0 and port < 65535, do: :ok
  defp validate_port(_), do: (raise ArgumentError, "port must be between 1 and 65535")

  defp validate_ip(ip) do
    case String.split(ip, ".") do
      [a,b,c,d] ->
        if Enum.all?([a,b,c,d], &valid_octet?/1) do
          :ok
        else
          raise ArgumentError, "invalid IP address"
        end
      _ ->
        raise ArgumentError, "invalid IP address"
    end
  end

  defp valid_octet?(str) do
    case Integer.parse(str) do
      {num, ""} -> num >= 0 and num <= 255
      _ -> false
    end
  end
end
