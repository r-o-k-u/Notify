defmodule Notify.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :subject, :string
      add :content, :string
      add :status, :string
      add :retry_count, :integer
      add :last_retry, :time
      add :user_id, references(:users, on_delete: :nothing)
      add :contact_id, references(:contacts, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:emails, [:user_id])
    create index(:emails, [:contact_id])
    create index(:emails, [:group_id])
  end
end
