defmodule AutomaticComputingMachine.Repo.Migrations.CreateRevenues do
  use Ecto.Migration

  def change do
    create table(:revenues) do
      add :title, :string
      add :value, :decimal
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:revenues, [:user_id])
  end
end
