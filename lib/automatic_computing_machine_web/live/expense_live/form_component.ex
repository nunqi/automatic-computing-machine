defmodule AutomaticComputingMachineWeb.ExpenseLive.FormComponent do
  use AutomaticComputingMachineWeb, :live_component

  alias AutomaticComputingMachine.Item

  @impl true
  def update(%{expense: expense} = assigns, socket) do
    changeset = Item.change_expense(expense)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:current_user_id, expense.user_id)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"expense" => expense_params}, socket) do
    changeset =
      socket.assigns.expense
      |> Item.change_expense(expense_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"expense" => expense_params}, socket) do
    new_expense = Map.put(expense_params, "user_id", socket.assigns.current_user_id)
    save_expense(socket, socket.assigns.action, new_expense)
  end

  defp save_expense(socket, :edit, expense_params) do
    case Item.update_expense(socket.assigns.expense, expense_params) do
      {:ok, _expense} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expense updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_expense(socket, :new, expense_params) do
    case Item.create_expense(expense_params) do
      {:ok, _expense} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expense created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
