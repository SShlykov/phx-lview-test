defmodule WDcr.Plugs.IpPlug do
  alias Plug.Conn
  def init(deflt), do: deflt
  def call(%Conn{} = conn, _def), do: Conn.put_session(conn, :remote_ip, fetch_ip(conn))

  def fetch_ip(conn) do
    conn.remote_ip
    |> Tuple.to_list
    |> Enum.reduce("", fn x, acc ->
      case acc do
        "" -> "#{x}"
        _  -> "#{acc}.#{x}"
      end
    end)
  end
end
