defmodule Notify.Emails.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field :status, Ecto.Enum, values: [:unsent, :sent, :failed, :resent, :deleted]
    field :delivery_status, Ecto.Enum, values: [:delivered, :failed]
    field :subject, :string
    field :content, :string
    field :retry_count, :integer
    field :last_retry, :time
    field :user_id, :id
    field :contact_id, :id
    field :group_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:subject, :content, :status,:group_id,:user_id, :retry_count, :last_retry])
    |> validate_required([:subject, :content])
  end
end
