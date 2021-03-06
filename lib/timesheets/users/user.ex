defmodule Timesheets.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :manager, :boolean, default: false
    field :manager_id, :integer
    field :name, :string

    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :tasks, Timesheets.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :manager, :manager_id, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> validate_length(:password, min: 2)
    |> hash_password()
    |> validate_required([:name, :email, :manager, :manager_id, :password_hash])
  end

  def hash_password(cset) do
    pw = get_change(cset, :password)
    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end

end
