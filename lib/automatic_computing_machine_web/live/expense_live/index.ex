defmodule AutomaticComputingMachineWeb.ExpenseLive.Index do
  use AutomaticComputingMachineWeb, :live_view

  alias AutomaticComputingMachine.Item
  alias AutomaticComputingMachine.Item.Expense
	alias AutomaticComputingMachine.Accounts

  @impl true
  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    {:ok,
      socket
      |> assign(:expenses, list_expenses(user.id))
      |> assign(:current_user, user)} #, temporary_assigns: [expenses: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Expense")
    |> assign(:expense, Item.get_expense!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Expense")
    |> assign(:expense, %Expense{user_id: socket.assigns.current_user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Expenses")
    |> assign(:expense, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    expense = Item.get_expense!(id)
    {:ok, _} = Item.delete_expense(expense)

    {:noreply, assign(socket, :expenses, list_expenses(socket.assigns.current_user.id))}
  end

  defp list_expenses(user_id) do
    Item.list_expenses(user_id)
  end
end
