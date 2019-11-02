defmodule TimesheetsWeb.TSController do
  use TimesheetsWeb, :controller

  alias Timesheets.TSS
  alias Timesheets.TSS.TS

  alias Timesheets.Users
  alias Timesheets.Tasks

  def index(conn, _params) do
    tss = TSS.list_tss()
    render(conn, "index.html", tss: tss, user_tool: Users)
  end

  def new(conn, _params) do
    changeset = TSS.change_ts(%TS{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ts" => ts_params}) do
    case TSS.create_ts(ts_params) do
      {:ok, ts} ->
        conn
        |> put_flash(:info, "Ts created successfully.")
        |> redirect(to: Routes.ts_path(conn, :show, ts))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ts = TSS.get_ts!(id)
    render(conn, "show.html", ts: ts, task_tool: Tasks)
  end

  def edit(conn, %{"id" => id}) do
    ts = TSS.get_ts!(id)
    case TSS.approve_sheet(id) do
      {:ok, ts} ->
        conn
        |> put_flash(:info, "Timesheets approved successfully.")
        |> redirect(to: Routes.ts_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ts: ts, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "ts" => ts_params}) do
    ts = TSS.get_ts!(id)

    case TSS.update_ts(ts, ts_params) do
      {:ok, ts} ->
        conn
        |> put_flash(:info, "Ts updated successfully.")
        |> redirect(to: Routes.ts_path(conn, :show, ts))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ts: ts, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ts = TSS.get_ts!(id)
    {:ok, _ts} = TSS.delete_ts(ts)

    conn
    |> put_flash(:info, "Ts deleted successfully.")
    |> redirect(to: Routes.ts_path(conn, :index))
  end

end
