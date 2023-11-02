defmodule Notify.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :active, :boolean, default: true
    field :name, :string
    field :permissions, :map

    has_many :users, Notify.Accounts.User

    timestamps(type: :utc_datetime)
  end

  # @required_fields ~w(name permissions)a
  # @optional_fields ~w(active)a



  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :permissions])
    |> validate_required([:name, :permissions])
    # |> cast(attrs, @required_fields, @optional_fields)
    # |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> validate_at_least_one_permission()
    |> Notify.Accounts.Permission.validate_permissions(:permissions)
  end

  defp validate_at_least_one_permission(changeset) do
    validate_change(changeset, :permissions, fn field, permissions ->
      if map_size(permissions) == 0 do
        [{field, "must have at least one permission"}]
      else
        []
      end
    end)
  end
end
