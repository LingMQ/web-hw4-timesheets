defmodule TimesheetsWeb.TaskController do
  use TimesheetsWeb, :controller

  alias Timesheets.Tasks
  alias Timesheets.Tasks.Task

  alias Timesheets.TSS

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _params) do
    jobcode_list = [_params["jobcode1"], _params["jobcode2"], _params["jobcode3"], _params["jobcode4"],
      _params["jobcode5"], _params["jobcode6"], _params["jobcode7"], _params["jobcode8"]]

    hour_list = [_params["hours1"], _params["hours2"], _params["hours3"], _params["hours4"], _params["hours5"],
      _params["hours6"], _params["hours7"], _params["hours8"]]

    id = _params["workerid"]
    date = _params["date"]
    IO.inspect("fgkwlr")
    IO.inspect(date)

    hourss = hour_list
    |> Enum.map(fn n -> Integer.parse(n) end)
    |> Enum.filter(fn(x) -> x !== :error end)
    |> Enum.map(fn {n, _} -> n end)

    hourss = Enum.sum(hourss)
    sheet = nil
    if hourss === 8 do
      case TSS.create_ts(%{workerid: id, status: "New", date: date}) do
        {:ok, sheet} ->
          conn
          |> put_flash(:info, "TimeSheets created successfully.")
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end

      entry = Enum.zip(jobcode_list, hour_list)
      Enum.map(entry, fn{c, h} -> {
          if h !== 0 do
             task_params = %{"date" => date, "jobcode" => c, "hours" => h, "worker" => id, "timesheetsid" => sheet}
             Tasks.create_task(task_params)
          end}
      end)

      conn
      |> put_flash(:info, "Task created successfully.") |> redirect(to: Routes.task_path(conn, :index))
    end
    conn
    |> put_flash(:info, "Your work hours is not 8 hours.") |> redirect(to: Routes.job_path(conn, :index))
  end

#  def create_task(conn, jobcode_list, hour_list, date, id, index) when index < (length(jobcode_list)) do
#    jobcode = Enum.at(jobcode_list, index)
#    hour = Enum.at(hour_list, index)
#
#    if hour !== "" do
#      task_params = %{"date" => date, "jobcode" => jobcode, "hours" => hour, "worker" => id}
#
#      case Tasks.create_task(task_params) do
#        {:ok, task} ->
#          conn
#          |> put_flash(:info, "Task created successfully.")
#          |> redirect(to: Routes.task_path(conn, :show, task))
#
#        {:error, %Ecto.Changeset{} = changeset} ->
#          render(conn, "new.html", changeset: changeset)
#      end
#    end
#  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
