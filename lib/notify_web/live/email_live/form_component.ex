defmodule NotifyWeb.EmailLive.FormComponent do
  use NotifyWeb, :live_component

  alias Notify.Emails
  alias Notify.Contacts
  alias Notify.Groups

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage email records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="email-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:subject]} type="text" label="Subject" />
        <.input  field={@form[:content]} type="text" label="Content" />
        <label>
        Single Email
          <input type="radio" name="email_type" value="single" phx-click="toggle_email_type" />
        </label>
        <label>
          Group Email
          <input type="radio" name="email_type" value="group" phx-click="toggle_email_type" />
        </label>
        <%= if assigns[:email_type] != "single" do %>
          <.live_component module={NotifyWeb.EmailLive.ContactSelect} id="contact" />
          <% else %>
          <.live_component module={NotifyWeb.EmailLive.GroupSelect} id="group" />
          <% end %>


        <:actions>
          <.button phx-disable-with="Saving...">Save Email</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(%{email: email} = assigns, socket) do
    changeset = Emails.change_email(email)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"email" => email_params}, socket) do
    changeset =
      socket.assigns.email
      |> Emails.change_email(email_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"email" => email_params}, socket) do
    save_email(socket, socket.assigns.action, email_params)
  end

  def handle_event("toggle_email_type", %{"value" => email_type}, socket) do
    {:noreply, assign(socket, email_type: email_type)}
  end

  defp save_email(socket, :edit, email_params) do
    case Emails.update_email(socket.assigns.email, email_params) do
      {:ok, email} ->
        notify_parent({:saved, email})

        {:noreply,
         socket
         |> put_flash(:info, "Email updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_email(socket, :new, email_params) do
    case Emails.create_email(email_params) do
      {:ok, email} ->
        notify_parent({:saved, email})

        {:noreply,
         socket
         |> put_flash(:info, "Email created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
