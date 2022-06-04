defmodule SelfieWeb.Router do
  use SelfieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SelfieWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :default do
    scope "/", SelfieWeb do
      pipe_through :browser
      live "/liveview", LiveViewLive
      live "/surface/phoenix_component", SurfacePhoenixComponentLive
      live "/surface/1", SurfaceLive1
      live "/surface/2", SurfaceLive2
      live "/surface/3", SurfaceLive3
      live "/surface/4", SurfaceLive4
      live "/surface/5", SurfaceLive5
    end
  end

  # scope "/", SelfieWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  # scope "/api", SelfieWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SelfieWeb.Telemetry
    end
  end
end
