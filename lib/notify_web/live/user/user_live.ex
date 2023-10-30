defmodule NotifyWeb.UserLive do
  use NotifyWeb, :live_view


  alias Notify.Accounts
  alias Notify.Accounts.User




  def mount(_params, _session, socket) do
    users = Accounts.list_users() # Implement this function to retrieve users
    {:ok, assign(socket, users: users)}
  end


  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Group")
    # |> assign(:user, Accounts.get_users!(id))
  end

  def apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  def apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:users, Accounts.list_users())
  end





end
