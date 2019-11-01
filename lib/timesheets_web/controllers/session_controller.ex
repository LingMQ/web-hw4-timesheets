defmodule TimesheetsWeb.SessionController do
  use TimesheetsWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email}) do
    user = Timesheets.Users.get_user_by_email(email)
    if user do
      if user.manager == true do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back, Manager #{user.name}")
        |> redirect(to: Routes.page_path(conn, :index))
      else
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back, #{user.name}")
        |> redirect(to: Routes.job_path(conn, :index))
      end
    else
      conn
      |> put_flash(:error, "Login failed.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end