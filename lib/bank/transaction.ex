defmodule Bank.Transaction do
  @enforce_keys [:amount, :account_num, :datetime]
  defstruct amount: nil, account_num: nil, datetime: nil

  @spec new(any, any, any) :: %Bank.Transaction{account_num: any, amount: any, datetime: any}
  @doc """
  Create a new transaction
  """
  def new(amount, other_account, datetime) do
    %Bank.Transaction{amount: amount, account_num: other_account, datetime: datetime}
  end
end
