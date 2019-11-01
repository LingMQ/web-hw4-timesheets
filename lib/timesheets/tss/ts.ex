defmodule Timesheets.TSS.TS do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tss" do
    field :status, :string
    field :workerid, :integer
    field :date, :date
    timestamps()
  end

  @doc false
  def changeset(ts, attrs) do
    ts
    |> cast(attrs, [:workerid, :status, :date])
    |> validate_required([:workerid, :status, :date])
  end
end
