defmodule WDcrWeb.PageLive do
  use WDcrWeb, :live_view
  import ShorterMaps

  def render(assigns) do
    ~L"""
      <header>
        <span class="">
          Привет, пользователь, твой ip: <%= @user_ip  %>
        </span>
        <div>
          <form phx-submit="set-location">
          <div class="">
            <input name="location" placeholder="Location" value="<%= @location %>"/>
            <%= @weather %>
          </div>
          <span class="capt">
            Выберите регион и нажмите Enter
          </span>
          </form>
        </div>
      </header>
      <div class="main">
        <h1>Примеры работы технологии Live View </h1>
        <p style="text-align: center; width: 100vw; heigth: auto;">JS используется исключительно для организации socket связи</p>
        <p style="text-align: center; width: 100vw; heigth: auto;">PS. внешние апи типа погоды и переводов не стаблиьны и иногда выдают не верные результаты</p>
        <%= for item <- @cards do %>
          <a class='card <%= if item.link == "#", do: "unavaliable" %>' href="<%= item.link %>">
            <%= item.name %>
          </a>
        <% end %>
      </div>
    """
  end

  def mount(_params, ~m{remote_ip}, socket) do
    send(self(), {:put, "Saint Peterburg"})
    cards = [
      %{name: "Часы", link: "/simple/clock"},
      %{name: "Змейка", link: "/games/snake"},
      %{name: "Авто скроллинг", link: "/simple/auto-scroll"},
      %{name: "Живой поиск", link: "/simple/search"},
      %{name: "Игра 'капиталист'", link: "#"},
      %{name: "Мой Black jack", link: "#"},
      %{name: "Живой Чат", link: "#"},
      %{name: "Div анимация", link: "#"},
    ]
    {:ok, assign(socket, user_ip: remote_ip, location: nil, weather: "...", cards: cards)}
  end

  def handle_event("set-location", %{"location" => location}, socket) do
    {:noreply, put_location(socket, location)}
  end
  def handle_info({:put, location}, socket) do
    {:noreply, put_location(socket, location)}
  end

  defp put_location(socket, location) do
    try do
      assign(socket, location: location, weather: weather(location))
    rescue
      _e -> assign(socket, location: location, weather: "Не могу получить данные")
    end

  end

  defp weather(local) do
    {:ok, %Tesla.Env{status: 200, body: body}} = Tesla.get("http://wttr.in/#{URI.encode(local)}", query: %{format: 1})

    case String.match?(body, ~r/Unknown/) do
      true -> "wttr.in error"
      false -> IO.iodata_to_binary(body)
    end
  end
end
