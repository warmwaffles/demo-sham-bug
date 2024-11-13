defmodule Demosham.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DemoshamWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:demosham, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Demosham.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Demosham.Finch},
      # Start a worker by calling: Demosham.Worker.start_link(arg)
      # {Demosham.Worker, arg},
      # Start to serve requests, typically the last entry
      DemoshamWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Demosham.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DemoshamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
