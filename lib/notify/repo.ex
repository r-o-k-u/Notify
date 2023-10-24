defmodule Notify.Repo do
  use Ecto.Repo,
    otp_app: :notify,
    adapter: Ecto.Adapters.Postgres
end
