defmodule NotifyWeb.Plugs.CheckPermissions do
  import Plug.Conn
  import Phoenix.Controller, only: [action_name: 1]

  alias Notify.Accounts.Permissions
  alias Notify.Repo

  def init(opts), do: opts

  def call(conn, opts) do
    user = get_user(conn)
    required_permission = get_required_permission(conn, opts)

    if Permissions.has_permission?(user, required_permission) do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> halt()
    end
  end
  defmodule NotifyWeb.Plugs.CheckPermissions do
    import Plug.Conn
    import Phoenix.Controller, only: [action_name: 1]

    alias Notify.Accounts.Permissions
    alias Notify.Repo

    def init(opts), do: opts

    def call(conn, opts) do
      user = get_user(conn)
      required_permissions = get_required_permissions(conn, opts)

      if has_required_permissions?(user, required_permissions) do
        conn
      else
        conn
        |> put_status(:forbidden)
        |> halt()
      end
    end

    defp get_user(conn) do
      user = conn.assigns.current_user
      Repo.preload(user, :role)
    end

    defp get_required_permissions(conn, opts) do
      action = action_name(conn)

      opts
      |> Keyword.fetch!(:permissions)
      |> Keyword.fetch!(action)
    end

    defp has_required_permissions?(_user, []), do: true

    defp has_required_permissions?(user, [permission | rest]) do
      if Permissions.has_permission?(user, permission) do
        has_required_permissions?(user, rest)
      else
        false
      end
    end
  end

  defp get_user(conn) do
    user = conn.assigns.current_user
    Repo.preload(user, :role)
  end

  defp get_required_permission(conn, opts) do
    action = action_name(conn)

    opts
    |> Keyword.fetch!(:actions)
    |> Keyword.fetch!(action)
  end
end
