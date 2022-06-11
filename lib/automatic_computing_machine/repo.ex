defmodule AutomaticComputingMachine.Repo do
  use Ecto.Repo,
    otp_app: :automatic_computing_machine,
    adapter: Ecto.Adapters.Postgres
end
