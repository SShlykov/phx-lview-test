defmodule WDcrWeb.Router do
  use WDcrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WDcrWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WDcr.Plugs.IpPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :game do
    plug :put_root_layout, {WDcrWeb.LayoutView, :game}
  end

  pipeline :simple do
    plug :put_root_layout, {WDcrWeb.LayoutView, :simple}
  end

  scope "/", WDcrWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/simple", WDcrWeb do
    pipe_through [:browser, :simple]

    live "/clock", ClockLive
    live "/search", SearchLive
    live "/auto-scroll", UserLive.AutoScroll
  end

  scope "/games", WDcrWeb do
    pipe_through [:browser, :game]

    live "/snake", SnakeLive
  end
end
