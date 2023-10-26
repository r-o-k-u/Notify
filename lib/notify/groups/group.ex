defmodule Notify.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :active, :boolean, default: false
    field :name, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
