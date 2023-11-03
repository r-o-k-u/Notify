defmodule NotifyWeb.EmailLive.Index do
  use NotifyWeb, :live_view

  alias Notify.Emails
  alias Notify.Emails.Email
  import Notify.Accounts

  @impl true
  def mount(_params, session, socket) do
    IO.inspect socket.assigns.current_user
    # {:ok, stream(socket, :emails, Emails.list_emails())}

    {:ok, assign(socket, current_user: socket.assigns.current_user, emails: Emails.list_emails())}


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

  # Status functions with placeholder values
  defp number_of_emails_sent() do
    # Replace with logic to calculate the number of emails sent
    100
  end

  defp number_of_group_emails_sent() do
    # Replace with logic to calculate the number of group emails sent
    50
  end

  defp number_of_pending_emails() do
    # Replace with logic to calculate the number of pending emails
    25
  end

  defp number_of_failed_emails() do
    # Replace with logic to calculate the number of failed emails
    10
  end

  defp number_of_retried_emails() do
    # Replace with logic to calculate the number of retried emails
    5
  end

  defp list_failed_emails() do
    # Replace with logic to fetch and return a list of failed emails
    [
      %Email{subject: "Failed Email 1"},
      %Email{subject: "Failed Email 2"}
    ]
  end
end
