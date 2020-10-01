defmodule WDcr.Accounts do
  @moduledoc """
  Нынче без соединения, так просто генерим
  """

  def list_users(page, per) do
    1..per
    |> Enum.map(fn x ->
      x = x*page
      num = Enum.random(x..1000000000)

      %{
        email: "user#{num}@test",
        id: num,
        inserted_at: ~N[2020-09-28 10:45:40],
        password: nil,
        password_confirmation: nil,
        phone_number: "555-555-5555",
        updated_at: ~N[2020-09-28 10:45:40],
        username: "user#{num}"
      }
    end)
  end
end
