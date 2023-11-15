defmodule NotifyWeb.EmailLive.FormComponent do
  use NotifyWeb, :live_component
  import Phoenix.HTML.Form, only: [select: 4]

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
        <.input field={@form[:content]} type="textarea" label="Content" />
        <label for="email_group_id">Group</label>
        <%= select @form, :group_id, [{nil, nil} | Enum.map(@groups, &{&1.name, &1.id})], label: "Group" %>
        <.input field={@form[:contact_id]} options={Enum.map(@contacts, &{&1.name, &1.id})} type="select" label="Contact" />

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
     |> assign(:groups, Groups.list_groups())
     |> assign(:contacts, Contacts.list_contacts())
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
    case Notify.Emails.send_email(email_params) do
      {:ok, message} ->
        IO.puts("Email sending was successful")
        # Sending email was successful, now save the email and update the socket
        save_email(socket, socket.assigns.action, message)

      {:error, message} ->
        IO.puts("Email sending failed:")
        # Sending email failed; you can handle this case as needed
        # In this example, I'm just printing an error message
        IO.puts("Failed to send the email")
        {:noreply, socket}
    end
  end

  defp save_email(socket, :edit, email_params) do
    IO.inspect email_params
    case Emails.update_email(socket.assigns.email, email_params) do
      {:ok, email} ->
        notify_parent({:saved, email})

        {:noreply,
         socket
         |> put_flash(:info, "Email updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "Update Email Errors")
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
