defmodule AutomaticComputingMachineWeb.PageController do
  use AutomaticComputingMachineWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
