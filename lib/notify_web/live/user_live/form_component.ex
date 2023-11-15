defmodule NotifyWeb.UserLive.FormComponent do
  use NotifyWeb, :live_component

  alias Notify.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user records in your database.</:subtitle>
      </.header>



      <.simple_form
        for={@form}
        id="user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="first_name" />
        <.input field={@form[:last_name]} type="text" label="last_name" />
        <.input field={@form[:email]} type="text" label="email" />
        <.input field={@form[:msisdn]} type="text" label="msisdn" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:role_id]} options={Enum.map(@role, &{&1.name, &1.id} )} type="select" label="Role" />
        <.input field={@form[:plan]} options={[:normal, :gold]} type="select" label="Plan" />
        <:actions>
          <.button phx-disable-with="Saving...">Save User</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user: user} = assigns, socket) do

    changeset = Accounts.change_user_registration(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    # IO.inspect(socket, label: "Socket in handle_event")
    # IO.inspect(user_params, label: "User Params in handle_event")

    changeset =
      socket.assigns.user
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :validate)

    # IO.inspect(changeset, label: "Changeset in handle_event")

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end



  defp save_user(socket, :edit, user_params) do
    IO.puts("UPDATING ...")
    case Accounts.update_user(socket.assigns.user, user_params) do
      {:ok, contact} ->
        notify_parent({:saved, contact})
        IO.inspect(socket.assigns.patch, label: "URI Path in save_user")
        socket
        |> put_flash(:info, "user updated successfully")
        |> push_patch(to: socket.assigns.patch)

      {:error, %Ecto.Changeset{} = changeset} ->
        # Debugging: Inspect the changeset if an error occurs
        IO.inspect(changeset, label: "Changeset error in save_user")

        {:noreply, assign_form(socket, changeset)}
    end
  end



  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    roles = Notify.Accounts.list_role()
    assign(socket, :form, to_form(changeset))
    |> assign(:role, roles)
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
