defmodule AccountTest do
  use ExUnit.Case

  alias Bank.Account

  test "new/2 should create an account with the right values" do
    account = Account.new(999, 0)

    assert account == %Bank.Account{account_num: 999, initial_balance: 0, transactions: []}
  end

  test "new/1 should set the account balance to zero if not provided" do
    %{initial_balance: balance} = Account.new(999)

    assert balance == 0
  end

  test "new/2 should raise an error when balance is not a number" do
    assert_raise RuntimeError, fn ->
      Account.new(123, "not a number")
    end
  end
end
