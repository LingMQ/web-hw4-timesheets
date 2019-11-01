defmodule TimesheetsWeb.TSControllerTest do
  use TimesheetsWeb.ConnCase

  alias Timesheets.TSS

  @create_attrs %{status: "some status", workerid: 42}
  @update_attrs %{status: "some updated status", workerid: 43}
  @invalid_attrs %{status: nil, workerid: nil}

  def fixture(:ts) do
    {:ok, ts} = TSS.create_ts(@create_attrs)
    ts
  end

  describe "index" do
    test "lists all tss", %{conn: conn} do
      conn = get(conn, Routes.ts_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tss"
    end
  end

  describe "new ts" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.ts_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ts"
    end
  end

  describe "create ts" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ts_path(conn, :create), ts: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ts_path(conn, :show, id)

      conn = get(conn, Routes.ts_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ts"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ts_path(conn, :create), ts: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ts"
    end
  end

  describe "edit ts" do
    setup [:create_ts]

    test "renders form for editing chosen ts", %{conn: conn, ts: ts} do
      conn = get(conn, Routes.ts_path(conn, :edit, ts))
      assert html_response(conn, 200) =~ "Edit Ts"
    end
  end

  describe "update ts" do
    setup [:create_ts]

    test "redirects when data is valid", %{conn: conn, ts: ts} do
      conn = put(conn, Routes.ts_path(conn, :update, ts), ts: @update_attrs)
      assert redirected_to(conn) == Routes.ts_path(conn, :show, ts)

      conn = get(conn, Routes.ts_path(conn, :show, ts))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, ts: ts} do
      conn = put(conn, Routes.ts_path(conn, :update, ts), ts: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ts"
    end
  end

  describe "delete ts" do
    setup [:create_ts]

    test "deletes chosen ts", %{conn: conn, ts: ts} do
      conn = delete(conn, Routes.ts_path(conn, :delete, ts))
      assert redirected_to(conn) == Routes.ts_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.ts_path(conn, :show, ts))
      end
    end
  end

  defp create_ts(_) do
    ts = fixture(:ts)
    {:ok, ts: ts}
  end
end
