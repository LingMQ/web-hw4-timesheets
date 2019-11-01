defmodule Timesheets.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :manager, :boolean, default: false
    field :manager_id, :integer
    field :name, :string

    has_many :tasks, Timesheets.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :manager, :manager_id])
    |> validate_required([:name, :email, :manager, :manager_id])
  end
end
