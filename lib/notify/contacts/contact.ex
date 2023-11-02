defmodule Notify.Contacts.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :active, :boolean, default: false
    field :name, :string
    field :email, :string
    field :phone, :string
    belongs_to :group, Notify.Groups.Group
    belongs_to :user, Notify.Accounts.User
    timestamps(type: :utc_datetime)
  end


  @required_fields ~w(name email phone  )a
  # @optional_fields ~w(active group_id user_id)a

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:name, :email, :phone,:group_id, :user_id, :active])
    # |> cast_assoc(:group, required: false) #TODO check on this
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
  end
end
