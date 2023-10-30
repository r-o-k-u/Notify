defmodule NotifyWeb.EmailLive.Index do
  use NotifyWeb, :live_view

  alias Notify.Emails
  alias Notify.Emails.Email


  # @impl true
  # def render(assigns) do
  #   ~L"""
  #   <div>
  #     <%= if assigns[:contact] do %>
  #       <%= live_render(@socket, NotifyWeb.EmailLive.FormComponent, contact: assigns[:contact]) %>
  #     <% else %>
  #       <%= live_render(@socket, NotifyWeb.EmailLive.FormComponent) %>
  #     <% end %>
  #   </div>
  #   """
  # end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :emails, Emails.list_emails() )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Email")
    |> assign(:email, Emails.get_email!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Email")
    |> assign(:email_type, "single")

    |> assign(:email, %Email{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Emails")
    |> assign(:email, nil)
  end

  @impl true
  def handle_info({NotifyWeb.EmailLive.FormComponent, {:saved, email}}, socket) do
    {:noreply, stream_insert(socket, :emails, email)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    email = Emails.get_email!(id)
    {:ok, _} = Emails.delete_email(email)

    {:noreply, stream_delete(socket, :emails, email)}
  end
end
