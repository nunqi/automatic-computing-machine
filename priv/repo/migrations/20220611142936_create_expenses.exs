defmodule AutomaticComputingMachine.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :title, :string
      add :value, :decimal
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:expenses, [:user_id])
  end
end
