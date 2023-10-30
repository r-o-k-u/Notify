defmodule NotifyWeb.UserLive do
  use Phoenix.LiveView




  def mount(_params, _session, socket) do
    users = Notify.Accounts.list_users() # Implement this function to retrieve users
    {:ok, assign(socket, users: users)}
  end

end
