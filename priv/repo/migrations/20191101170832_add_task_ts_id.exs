defmodule Timesheets.Repo.Migrations.AddTaskTsID do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :timesheetsid, :integer, default: -1, null: false
    end
  end
end
