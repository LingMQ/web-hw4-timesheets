defmodule Timesheets.TSS.TS do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tss" do
    field :status, :string
    field :workerid, :integer

    timestamps()
  end

  @doc false
  def changeset(ts, attrs) do
    ts
    |> cast(attrs, [:workerid, :status])
    |> validate_required([:workerid, :status])
  end
end
