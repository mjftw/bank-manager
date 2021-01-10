defmodule Bank.Transaction do
  @enforce_keys [:amount, :account_num, :datetime]
  defstruct amount: nil, account_num: nil, datetime: nil
end
