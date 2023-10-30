defmodule Notify.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :active, :boolean, default: true
      add :permissions, :map

      timestamps()
    end

    create index(:roles, [:name], unique: true)
  end
end
