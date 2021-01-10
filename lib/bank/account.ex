defmodule Bank.Account do
  @doc """
  The initial balance is measured in pence, not pounds.
  This is to avoid floating point errors.
  """
  @enforce_keys [:account_num, :initial_balance]
  defstruct account_num: nil, initial_balance: nil, transactions: []
end
