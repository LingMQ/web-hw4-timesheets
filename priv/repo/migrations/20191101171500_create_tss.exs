defmodule Timesheets.Repo.Migrations.CreateTss do
  use Ecto.Migration

  def change do
    create table(:tss) do
      add :workerid, :integer
      add :status, :string

      timestamps()
    end

  end
end
