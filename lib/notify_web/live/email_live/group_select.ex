defmodule NotifyWeb.EmailLive.GroupSelect do
  use Phoenix.LiveComponent

  alias Notify.Emails
  alias Notify.Groups
  alias Notify.Contacts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :emails, Emails.list_emails(), groups: Groups.list_groups(), contacts: Contacts.list_contacts())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>Group</div>
    """
  end
end


# ~L"""
# <select name="group_id" id="group_id">
#   <option value="">Select a group</option>
#   <%= for group <- assigns.groups do %>
#     <option value="<%= group.id %>"><%= group.name %></option>
#   <% end %>
# </select>
# """
