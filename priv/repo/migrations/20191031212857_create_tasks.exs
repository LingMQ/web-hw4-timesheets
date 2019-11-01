defmodule Timesheets.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :hours, :integer
      add :jobcode, :string
      add :worker, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:worker])
  end
end
