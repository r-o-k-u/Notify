defmodule Notify.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :active, :boolean, default: true
    field :name, :string

    has_many :role, Notify.Accounts.Role

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w(name )a
  @optional_fields ~w(active)a

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
  end
end
