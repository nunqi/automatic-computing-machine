defmodule AutomaticComputingMachine.ItemTest do
  use AutomaticComputingMachine.DataCase

  alias AutomaticComputingMachine.Item

  describe "expenses" do
    alias AutomaticComputingMachine.Item.Expense

    import AutomaticComputingMachine.ItemFixtures

    @invalid_attrs %{title: nil, value: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Item.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Item.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{title: "some title", value: "120.5"}

      assert {:ok, %Expense{} = expense} = Item.create_expense(valid_attrs)
      assert expense.title == "some title"
      assert expense.value == Decimal.new("120.5")
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Item.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{title: "some updated title", value: "456.7"}

      assert {:ok, %Expense{} = expense} = Item.update_expense(expense, update_attrs)
      assert expense.title == "some updated title"
      assert expense.value == Decimal.new("456.7")
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Item.update_expense(expense, @invalid_attrs)
      assert expense == Item.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Item.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Item.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Item.change_expense(expense)
    end
  end

  describe "revenues" do
    alias AutomaticComputingMachine.Item.Revenue

    import AutomaticComputingMachine.ItemFixtures

    @invalid_attrs %{title: nil, value: nil}

    test "list_revenues/0 returns all revenues" do
      revenue = revenue_fixture()
      assert Item.list_revenues() == [revenue]
    end

    test "get_revenue!/1 returns the revenue with given id" do
      revenue = revenue_fixture()
      assert Item.get_revenue!(revenue.id) == revenue
    end

    test "create_revenue/1 with valid data creates a revenue" do
      valid_attrs = %{title: "some title", value: "120.5"}

      assert {:ok, %Revenue{} = revenue} = Item.create_revenue(valid_attrs)
      assert revenue.title == "some title"
      assert revenue.value == Decimal.new("120.5")
    end

    test "create_revenue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Item.create_revenue(@invalid_attrs)
    end

    test "update_revenue/2 with valid data updates the revenue" do
      revenue = revenue_fixture()
      update_attrs = %{title: "some updated title", value: "456.7"}

      assert {:ok, %Revenue{} = revenue} = Item.update_revenue(revenue, update_attrs)
      assert revenue.title == "some updated title"
      assert revenue.value == Decimal.new("456.7")
    end

    test "update_revenue/2 with invalid data returns error changeset" do
      revenue = revenue_fixture()
      assert {:error, %Ecto.Changeset{}} = Item.update_revenue(revenue, @invalid_attrs)
      assert revenue == Item.get_revenue!(revenue.id)
    end

    test "delete_revenue/1 deletes the revenue" do
      revenue = revenue_fixture()
      assert {:ok, %Revenue{}} = Item.delete_revenue(revenue)
      assert_raise Ecto.NoResultsError, fn -> Item.get_revenue!(revenue.id) end
    end

    test "change_revenue/1 returns a revenue changeset" do
      revenue = revenue_fixture()
      assert %Ecto.Changeset{} = Item.change_revenue(revenue)
    end
  end
end
