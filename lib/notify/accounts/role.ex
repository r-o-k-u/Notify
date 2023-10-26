defmodule Notify.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role" do
    field :active, :boolean, default: true
    field :name, :string
    #belongs_to :user, Notify.Accounts.User, foreign_key: :role_id
    has_many :users, Notify.Accounts.User
    has_many :permissions, Notify.Permissions.Permission

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name )a
  @optional_fields ~w(active permissions)a

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
  end
end
