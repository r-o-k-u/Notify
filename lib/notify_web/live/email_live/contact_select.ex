defmodule NotifyWeb.EmailLive.ContactSelect do
  use Phoenix.LiveComponent

  alias Notify.Emails
  alias Notify.Groups
  alias Notify.Contacts

  def mount(_params, _session, socket) do
    {:ok, assign(socket, contacts: Contacts.list_contacts())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <datalist id="matches">
      </datalist>
    """
  end
end


# ~L"""
# <select name="contact_id" id="contact_id">
#   <option value="">Select a contact</option>
#   <%= for contact <- assigns.contacts do %>
#     <option value="<%= contact.id %>"><%= contact.name %></option>
#   <% end %>
# </select>
# """
