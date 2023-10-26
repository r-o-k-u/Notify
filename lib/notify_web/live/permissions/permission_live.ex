defmodule NotifyWeb.PermissionLive  do
  use Phoenix.LiveView

  alias Notify.Accounts.Permission
  alias Notify.Repo


  def mount(_params, _session, socket) do
    permissions = Repo.all(Permission)
    {:ok, assign(socket, permissions: permissions, permission: %Permission{}, action: :index)}
  end

  def render(assigns) do

    ~H"""
    <div>
    <h2>Permissions</h2>
    <button phx-click="new">Create Permission</button>
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Active</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <%= for permission <- @permissions do %>
          <tr>
            <td><%= permission.name %></td>
            <td><%= permission.active %></td>
            <td>
            </td>
          </tr>
        <% end %>
      </tbody>
    </table>
  </div>
  """
  end

  # <%= live_patch("Delete", to: Routes.permission_path(@socket, :delete, permission), phx-value-id: permission.id) %>

  # def render("form.html", %{assigns: assigns}) do
  #   permission = assigns.permission
  #   action = assigns.action

  #   ~H"""
  #   <h2><%= if action == :new, do: "New", else: "Edit" %> Permission</h2>
  #   <%= render("permission_form.html", Map.put(assigns, :action, action)) %>
  #   """
  # end

  # def render("show.html", %{assigns: assigns}) do
  #   permission = assigns.permission

  #   ~H"""
  #   <h2>Permission Details</h2>
  #   <!-- Display permission details here -->
  #   """
  # end

  def handle_event("new", _params, socket) do
    {:noreply, assign(socket, permission: %Permission{}, action: :new)}
  end

  # ... (rest of the event handlers)
end
