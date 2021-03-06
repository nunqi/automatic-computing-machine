defmodule AutomaticComputingMachineWeb.RevenueLive.Index do
  use AutomaticComputingMachineWeb, :live_view

  alias AutomaticComputingMachine.Item
  alias AutomaticComputingMachine.Item.Revenue
	alias AutomaticComputingMachine.Accounts

  @impl true
  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    {:ok,
      socket
      |> assign(:revenues, list_revenues(user.id))
      |> assign(:current_user, user)} #, temporary_assigns: [expenses: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Revenue")
    |> assign(:revenue, Item.get_revenue!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Revenue")
    |> assign(:revenue, %Revenue{user_id: socket.assigns.current_user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Revenues")
    |> assign(:revenue, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    revenue = Item.get_revenue!(id)
    {:ok, _} = Item.delete_revenue(revenue)

    {:noreply, assign(socket, :revenues, list_revenues(socket.assigns.current_user.id))}
  end

  defp list_revenues(user_id) do
    Item.list_revenues(user_id)
  end
end
