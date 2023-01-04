defmodule Bank.Account do
  @doc """
  The initial balance is measured in pence, not pounds.
  This is to avoid floating point errors.
  """
  @enforce_keys [:account_num, :initial_balance]
  defstruct account_num: nil, initial_balance: nil, transactions: []

  @doc """
  Create a new bank account
  """
  def new(account_num), do: new(account_num, 0)

  def new(_, balance) when not is_number(balance) do
    raise("Balance must be a number")
  end

  def new(account_num, balance) do
    %Bank.Account{account_num: account_num, initial_balance: balance, transactions: []}
  end
end
