defmodule Notify.Emails do
  @moduledoc """
  The Emails context.
  """

  import Ecto.Query, warn: false
  alias Notify.Repo

  alias Notify.Emails.Email

  alias Notify.Contacts.Contact

  @doc """
  Returns the list of emails.

  ## Examples

      iex> list_emails()
      [%Email{}, ...]

  """
  def list_emails do
    Repo.all(Email)
  end

  @doc """
  Gets a single email.

  Raises `Ecto.NoResultsError` if the Email does not exist.

  ## Examples

      iex> get_email!(123)
      %Email{}

      iex> get_email!(456)
      ** (Ecto.NoResultsError)

  """
  def get_email!(id), do: Repo.get!(Email, id)

  @doc """
  Creates a email.

  ## Examples

      iex> create_email(%{field: value})
      {:ok, %Email{}}

      iex> create_email(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_email(attrs \\ %{}) do
    %Email{}
    |> Email.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a email.

  ## Examples

      iex> update_email(email, %{field: new_value})
      {:ok, %Email{}}

      iex> update_email(email, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_email(%Email{} = email, attrs) do
    email
    |> Email.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a email.

  ## Examples

      iex> delete_email(email)
      {:ok, %Email{}}

      iex> delete_email(email)
      {:error, %Ecto.Changeset{}}

  """
  def delete_email(%Email{} = email) do
    Repo.delete(email)
  end

  def send_email_to_contact( contact, subject,body , group) do
    case Notify.Mailer.deliver(contact.email,subject, body) do
      {:ok, _message} ->
        contact.email
        |> Email.changeset(%{status: :sent, delivery_status: :delivered, contact_id: contact.id,group_id: group.id})
        |> Repo.update()

      {:error, _reason} ->
        contact.email
        |> Email.changeset(%{status: :sent, delivery_status: :failed, contact_id: contact.id,group_id: group.id})
        |> Repo.update()
    end
  end

  def send_email_to_group(%Email{} = email, subject,body , group_id) do
    # Fetch all contacts in the specified group
    contacts = Repo.all(from(c in Contact, where: c.group_id == ^group_id))

    # Iterate through the contacts and send the email to each one
    Enum.each(contacts, fn contact ->
      send_email_to_contact(email, subject,body ,contact)
    end)
  end



  @doc """
  Returns an `%Ecto.Changeset{}` for tracking email changes.

  ## Examples

      iex> change_email(email)
      %Ecto.Changeset{data: %Email{}}

  """
  def change_email(%Email{} = email, attrs \\ %{}) do
    Email.changeset(email, attrs)
  end
end
