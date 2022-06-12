defmodule AutomaticComputingMachineWeb.RevenueLiveTest do
  use AutomaticComputingMachineWeb.ConnCase

  import Phoenix.LiveViewTest
  import AutomaticComputingMachine.ItemFixtures

  @create_attrs %{title: "some title", value: "120.5"}
  @update_attrs %{title: "some updated title", value: "456.7"}
  @invalid_attrs %{title: nil, value: nil}

  defp create_revenue(_) do
    revenue = revenue_fixture()
    %{revenue: revenue}
  end

  describe "Index" do
    setup [:create_revenue]

    test "lists all revenues", %{conn: conn, revenue: revenue} do
      {:ok, _index_live, html} = live(conn, Routes.revenue_index_path(conn, :index))

      assert html =~ "Listing Revenues"
      assert html =~ revenue.title
    end

    test "saves new revenue", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.revenue_index_path(conn, :index))

      assert index_live |> element("a", "New Revenue") |> render_click() =~
               "New Revenue"

      assert_patch(index_live, Routes.revenue_index_path(conn, :new))

      assert index_live
             |> form("#revenue-form", revenue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#revenue-form", revenue: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.revenue_index_path(conn, :index))

      assert html =~ "Revenue created successfully"
      assert html =~ "some title"
    end

    test "updates revenue in listing", %{conn: conn, revenue: revenue} do
      {:ok, index_live, _html} = live(conn, Routes.revenue_index_path(conn, :index))

      assert index_live |> element("#revenue-#{revenue.id} a", "Edit") |> render_click() =~
               "Edit Revenue"

      assert_patch(index_live, Routes.revenue_index_path(conn, :edit, revenue))

      assert index_live
             |> form("#revenue-form", revenue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#revenue-form", revenue: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.revenue_index_path(conn, :index))

      assert html =~ "Revenue updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes revenue in listing", %{conn: conn, revenue: revenue} do
      {:ok, index_live, _html} = live(conn, Routes.revenue_index_path(conn, :index))

      assert index_live |> element("#revenue-#{revenue.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#revenue-#{revenue.id}")
    end
  end

  describe "Show" do
    setup [:create_revenue]

    test "displays revenue", %{conn: conn, revenue: revenue} do
      {:ok, _show_live, html} = live(conn, Routes.revenue_show_path(conn, :show, revenue))

      assert html =~ "Show Revenue"
      assert html =~ revenue.title
    end

    test "updates revenue within modal", %{conn: conn, revenue: revenue} do
      {:ok, show_live, _html} = live(conn, Routes.revenue_show_path(conn, :show, revenue))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Revenue"

      assert_patch(show_live, Routes.revenue_show_path(conn, :edit, revenue))

      assert show_live
             |> form("#revenue-form", revenue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#revenue-form", revenue: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.revenue_show_path(conn, :show, revenue))

      assert html =~ "Revenue updated successfully"
      assert html =~ "some updated title"
    end
  end
end
