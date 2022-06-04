defmodule Selfie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SelfieWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Selfie.PubSub},
      # Start the Endpoint (http/https)
      SelfieWeb.Endpoint
      # Start a worker by calling: Selfie.Worker.start_link(arg)
      # {Selfie.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Selfie.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SelfieWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
