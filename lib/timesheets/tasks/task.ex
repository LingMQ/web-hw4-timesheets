defmodule Timesheets.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :hours, :integer
    field :jobcode, :string
    field :worker, :id
    field :timesheetsid, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:hours, :jobcode, :worker, :timesheetsid])
    |> validate_required([:hours, :jobcode, :worker, :timesheetsid])
  end
end
