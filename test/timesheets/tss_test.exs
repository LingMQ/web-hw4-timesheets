defmodule Timesheets.TSSTest do
  use Timesheets.DataCase

  alias Timesheets.TSS

  describe "tss" do
    alias Timesheets.TSS.TS

    @valid_attrs %{status: "some status", workerid: 42}
    @update_attrs %{status: "some updated status", workerid: 43}
    @invalid_attrs %{status: nil, workerid: nil}

    def ts_fixture(attrs \\ %{}) do
      {:ok, ts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TSS.create_ts()

      ts
    end

    test "list_tss/0 returns all tss" do
      ts = ts_fixture()
      assert TSS.list_tss() == [ts]
    end

    test "get_ts!/1 returns the ts with given id" do
      ts = ts_fixture()
      assert TSS.get_ts!(ts.id) == ts
    end

    test "create_ts/1 with valid data creates a ts" do
      assert {:ok, %TS{} = ts} = TSS.create_ts(@valid_attrs)
      assert ts.status == "some status"
      assert ts.workerid == 42
    end

    test "create_ts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TSS.create_ts(@invalid_attrs)
    end

    test "update_ts/2 with valid data updates the ts" do
      ts = ts_fixture()
      assert {:ok, %TS{} = ts} = TSS.update_ts(ts, @update_attrs)
      assert ts.status == "some updated status"
      assert ts.workerid == 43
    end

    test "update_ts/2 with invalid data returns error changeset" do
      ts = ts_fixture()
      assert {:error, %Ecto.Changeset{}} = TSS.update_ts(ts, @invalid_attrs)
      assert ts == TSS.get_ts!(ts.id)
    end

    test "delete_ts/1 deletes the ts" do
      ts = ts_fixture()
      assert {:ok, %TS{}} = TSS.delete_ts(ts)
      assert_raise Ecto.NoResultsError, fn -> TSS.get_ts!(ts.id) end
    end

    test "change_ts/1 returns a ts changeset" do
      ts = ts_fixture()
      assert %Ecto.Changeset{} = TSS.change_ts(ts)
    end
  end
end
