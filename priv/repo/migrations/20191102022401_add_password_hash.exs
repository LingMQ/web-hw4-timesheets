defmodule Timesheets.Repo.Migrations.AddPasswordHash do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password_hash, :string, default: "pw", null: false
    end
  end
end
