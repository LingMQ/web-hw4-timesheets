defmodule Timesheets.Repo.Migrations.AddDateInTS do
  use Ecto.Migration

  def change do
    alter table("tss") do
      add :date, :date, null: false
    end
  end
end
