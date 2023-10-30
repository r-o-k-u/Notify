defmodule Notify.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :msisdn, :string
      add :plan, :string
      add :active, :boolean
      add :hashed_password, :string
      add :confirmed_at, :naive_datetime
      add :custom_permissions, :map
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:email], unique: true)

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
