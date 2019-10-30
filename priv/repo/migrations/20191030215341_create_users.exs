defmodule Timesheets.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :manager, :boolean, default: false, null: false
      add :manager_id, :integer

      timestamps()
    end

  end
end
