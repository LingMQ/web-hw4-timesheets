defmodule Timesheets.TSS do
  @moduledoc """
  The TSS context.
  """

  import Ecto.Query, warn: false
  alias Timesheets.Repo

  alias Timesheets.TSS.TS

  @doc """
  Returns the list of tss.

  ## Examples

      iex> list_tss()
      [%TS{}, ...]

  """
  def list_tss do
    Repo.all(TS)
  end

  @doc """
  Gets a single ts.

  Raises `Ecto.NoResultsError` if the Ts does not exist.

  ## Examples

      iex> get_ts!(123)
      %TS{}

      iex> get_ts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ts!(id), do: Repo.get!(TS, id)

  @doc """
  Creates a ts.

  ## Examples

      iex> create_ts(%{field: value})
      {:ok, %TS{}}

      iex> create_ts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ts(attrs \\ %{}) do
    %TS{}
    |> TS.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
  end

  @doc """
  Updates a ts.

  ## Examples

      iex> update_ts(ts, %{field: new_value})
      {:ok, %TS{}}

      iex> update_ts(ts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ts(%TS{} = ts, attrs) do
    ts
    |> TS.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TS.

  ## Examples

      iex> delete_ts(ts)
      {:ok, %TS{}}

      iex> delete_ts(ts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ts(%TS{} = ts) do
    Repo.delete(ts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ts changes.

  ## Examples

      iex> change_ts(ts)
      %Ecto.Changeset{source: %TS{}}

  """
  def change_ts(%TS{} = ts) do
    TS.changeset(ts, %{})
  end
end
