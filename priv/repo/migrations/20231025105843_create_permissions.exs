defmodule Notify.Repo.Migrations.CreatePermission do
  use Ecto.Migration

  def change do
    create table(:permission) do
      add :active, :boolean, default: true
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
