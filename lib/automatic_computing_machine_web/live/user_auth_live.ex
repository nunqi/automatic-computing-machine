defmodule AutomaticComputingMachineWeb.UserAuthLive do
	import Phoenix.LiveView
	alias AutomaticComputingMachine.Accounts

	def on_mount(:user, _params, %{"user_token" => user_token} = _session, socket) do
		socket =
			socket
			|> assign(:current_user, Accounts.get_user_by_session_token(user_token))
		if socket.assigns.current_user do
			{:cont, socket}
		else
			{:halt, redirect(socket, to: "/login")}
		end
	end
end
#live_session :user, on_mount: {UserAuthLive, :user}, root_layout: {AutomaticComputingMachineWeb.LayoutView, "root.html"} do
#	# Expenses routes
#	live "/expenses", ExpenseLive.Index, :index
#	live "/expenses/new", ExpenseLive.Index, :new
#	live "/expenses/:id/edit", ExpenseLive.Index, :edit
#
#	live "/expenses/:id", ExpenseLive.Show, :show
#	live "/expenses/:id/show/edit", ExpenseLive.Show, :edit
#
#	# Revenues routes
#	live "/revenues", RevenueLive.Index, :index
#	live "/revenues/new", RevenueLive.Index, :new
#	live "/revenues/:id/edit", RevenueLive.Index, :edit
#
#	live "/revenues/:id", RevenueLive.Show, :show
#	live "/revenues/:id/show/edit", RevenueLive.Show, :edit
#end
