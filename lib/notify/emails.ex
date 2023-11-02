defmodule Notify.Emails do
  @moduledoc """
  The Emails context.
  """
  import Swoosh.Email
  # import Ecto.Query, warn: false
  alias Notify.Repo

  alias Notify.Emails.Email

  alias Notify.Contacts.Contact
  alias Notify.Mailer

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
    IO.puts("CREATING EMAIL")
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

  def send_email(email) do
    IO.inspect email

    case email do
      %{
        "contact_id" => contact_id,
        "content" => content,
        "group_id" => group_id,
        "subject" => subject
      } ->
        IO.puts("Contact ID: #{contact_id}")
        IO.puts("Content: #{content}")
        IO.puts("Group ID: #{group_id}")
        IO.puts("Subject: #{subject}")

        if group_id == 1 do
          IO.puts("SENDING group email #{group_id}")
          # If sending is successful, return a response like:
          {:ok, "Group email sent successfully"}
          # If sending fails, you can return:
          {:error, "Failed to send group email"}
        else
          IO.puts("Sending individual email #{contact_id}")
          case send_email_to_contact(email) do
            {:ok, _} ->
              {:ok, "Individual email sent successfully"}
            {:error, reason} ->
              IO.puts("Failed to send individual email: #{reason}")
              {:error, "Failed to send individual email"}
          end
        end

      _ ->
        IO.puts("One or more keys not found in the map")
        {:error, "One or more keys not found in the map"}
    end
  end

  def send_email_to_contact(email) do
    case email do
      %{
        "contact_id" => contact_id,
        "content" => content,
        "group_id" => group_id,
        "subject" => subject
      } ->
        IO.puts("Contact ID: #{contact_id}")
        IO.puts("Content: #{content}")
        IO.puts("Group ID: #{group_id}")
        IO.puts("Subject: #{subject}")

        IO.puts("Sending email to contact - #{contact_id}")

        case Repo.get(Contact, contact_id) do
          %Contact{email: contact_email} ->
            IO.puts("Contact Email: #{contact_email}")

            email =
              new()
              |> to(contact_email)
              |> from({"Notify", "contact@example.com"})
              |> subject(subject)
              |> text_body(content)
            IO.inspect email
            case Mailer.deliver(email) do
              {:ok, _email} ->
                IO.puts("Email delivered successfully")

                # Create an email record
                changeset = %{
                  subject: subject,
                  content: content,
                  status: :sent,
                  delivery_status: :delivered,
                  contact_id: contact_id,
                  group_id: group_id,  # Add group_id if available
                  retry_count: 0
                }

                case create_email(changeset) do
                  {:ok, _} ->
                    {:ok, "Email record created successfully"}
                  {:error, changeset} ->
                    {:error, "Failed to create email record: #{inspect(changeset)}"}
                end

              {:error, reason} ->
                IO.puts("Failed to deliver email: #{reason}")
                {:error, "Failed to deliver email"}
            end

          _ ->
            IO.puts("Contact not found")
            {:error, "Contact not found"}
        end

      _ ->
        IO.puts("One or more keys not found in the map")
        {:error, "One or more keys not found in the map"}
    end
  end

  def send_email_to_group(%Email{} = email, subject,body , group_id) do
    # Fetch all contacts in the specified group
    # contacts = Repo.all(from(c in Contact, where: c.group_id == ^group_id))

    # # Iterate through the contacts and send the email to each one
    # Enum.each(contacts, fn contact ->
    #   # send_email_to_contact(email, subject,body ,contact)
    # end)
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
