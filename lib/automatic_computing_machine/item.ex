defmodule AutomaticComputingMachine.Item do
  @moduledoc """
  The Item context.
  """

  import Ecto.Query, warn: false
  alias AutomaticComputingMachine.Repo

  alias AutomaticComputingMachine.Item.Expense
  alias AutomaticComputingMachine.Item.Revenue

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """
  def list_expenses do
    Repo.all(Expense)
  end

  def list_expenses(user_id) do
    Repo.all(from e in Expense, where: e.user_id == ^user_id)
  end

  @doc """
  Gets a single expense.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id), do: Repo.get!(Expense, id)

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:expense_created)
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
    |> broadcast(:expense_updated)
  end

  @doc """
  Deletes a expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{data: %Expense{}}

  """
  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end

  @doc """
  Returns the list of revenues.

  ## Examples

      iex> list_revenues()
      [%Revenue{}, ...]

  """
  def list_revenues do
    Repo.all(Revenue)
  end

  def list_revenues(user_id) do
    Repo.all(from r in Revenue, where: r.user_id == ^user_id)
  end

  @doc """
  Gets a single revenue.

  Raises `Ecto.NoResultsError` if the Revenue does not exist.

  ## Examples

      iex> get_revenue!(123)
      %Revenue{}

      iex> get_revenue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_revenue!(id), do: Repo.get!(Revenue, id)

  @doc """
  Creates a revenue.

  ## Examples

      iex> create_revenue(%{field: value})
      {:ok, %Revenue{}}

      iex> create_revenue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_revenue(attrs \\ %{}) do
    %Revenue{}
    |> Revenue.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:revenue_created)
  end

  @doc """
  Updates a revenue.

  ## Examples

      iex> update_revenue(revenue, %{field: new_value})
      {:ok, %Revenue{}}

      iex> update_revenue(revenue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_revenue(%Revenue{} = revenue, attrs) do
    revenue
    |> Revenue.changeset(attrs)
    |> Repo.update()
    |> broadcast(:revenue_updated)
  end

  @doc """
  Deletes a revenue.

  ## Examples

      iex> delete_revenue(revenue)
      {:ok, %Revenue{}}

      iex> delete_revenue(revenue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_revenue(%Revenue{} = revenue) do
    Repo.delete(revenue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking revenue changes.

  ## Examples

      iex> change_revenue(revenue)
      %Ecto.Changeset{data: %Revenue{}}

  """
  def change_revenue(%Revenue{} = revenue, attrs \\ %{}) do
    Revenue.changeset(revenue, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(AutomaticComputingMachine.PubSub, "items")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, item}, event) do
    Phoenix.PubSub.broadcast(AutomaticComputingMachine.PubSub, "items", {event, item})
    {:ok, item}
  end
end
