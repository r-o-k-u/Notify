defmodule NotifyWeb.RolesLiveView do
  use NotifyWeb, :live_view

  def render(assigns) do
    ~H"""
    """
  end

  # def mount(_params, _session, socket) do
  #   roles = Notify.Roles.list_roles() # Implement this function to retrieve roles
  #   {:ok, assign(socket, roles: roles)}
  # end

  def handle_event("delete", %{"id" => _id}, socket) do
    # Implement the delete logic
    {:noreply, socket}
  end

  def handle_event("edit", %{"id" => _id}, socket) do
    # Implement the edit logic
    {:noreply, socket}
  end
end
