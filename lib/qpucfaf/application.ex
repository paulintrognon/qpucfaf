defmodule Qpucfaf.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      QpucfafWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:qpucfaf, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Qpucfaf.PubSub},
      # Start a worker by calling: Qpucfaf.Worker.start_link(arg)
      # {Qpucfaf.Worker, arg},
      # Start to serve requests, typically the last entry
      QpucfafWeb.Endpoint,
      # Start your Stack GenServer
      # initial stack elements as a comma-separated string
      GamesServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Qpucfaf.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QpucfafWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
