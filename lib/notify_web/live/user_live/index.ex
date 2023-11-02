defmodule NotifyWeb.UserLive.Index do
  use NotifyWeb, :live_view


  alias Notify.Accounts
  alias Notify.Accounts.User



  @impl true
  def mount(_params, _session, socket) do
    users = Accounts.list_users() # Implement this function to retrieve users
    {:ok, assign(socket, users: users)}
  end


  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  # @impl true
  # def handle_params(params, _url, socket) do
  #   plans = [%{name: "normal"}, %{name: "gold"}]
  #   if params["id"] do
  #      user = Accounts.get_user!(params["id"])
  #      assign(socket,plans: plans)
  #      assign(:user, user)
  #      {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  #    else
  #      assign(socket,plans: plans)
  #     {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  #    end
  # end

  def apply_action(socket, :edit, %{"id" => id}) do
    IO.puts("EDITTING")
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:_user, Accounts.get_user!(id))
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
