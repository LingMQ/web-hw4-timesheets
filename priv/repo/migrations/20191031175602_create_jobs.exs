defmodule Timesheets.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :jobname, :string
      add :desc, :text
      add :code, :string
      add :budgethours, :integer
      add :manager, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:jobs, [:manager])
  end
end
