defmodule Notify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NotifyWeb.Telemetry,
      Notify.Repo,
      {DNSCluster, query: Application.get_env(:notify, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Notify.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Notify.Finch},
      # Start a worker by calling: Notify.Worker.start_link(arg)
      # {Notify.Worker, arg},
      # Start to serve requests, typically the last entry
      NotifyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Notify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NotifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
