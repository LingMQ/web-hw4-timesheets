defmodule Timesheets.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :hours, :integer
    field :jobcode, :string
    field :worker, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:hours, :jobcode, :worker])
    |> validate_required([:hours, :jobcode, :worker])
  end
end
