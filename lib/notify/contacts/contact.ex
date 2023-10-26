defmodule Notify.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :active, :boolean, default: false
    field :name, :string
    field :email, :string
    field :phone, :string
    field :user_id, :id
    field :group_id, :id

    timestamps(type: :utc_datetime)
  end


  @required_fields ~w(name email phone  )a
  @optional_fields ~w(active group_id user_id)a

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
  end
end
