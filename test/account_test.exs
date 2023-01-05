defmodule AccountTest do
  use ExUnit.Case

  alias Bank.Account

  test "new/2 should create an account with the right values" do
    account = Account.new(123_456_789, 123)

    assert account.account_num == 123_456_789
    assert account.initial_balance == 123
  end

  test "new/2 should create an account with no transactions" do
    account = Account.new(123_456_789, 123)

    assert account.transactions == []
  end

  test "new/1 should set the account balance to zero if not provided" do
    account = Account.new(123_456_789)

    assert account.initial_balance == 0
  end

  test "new/2 should raise an error when balance is not a number" do
    assert_raise RuntimeError, "Balance must be a number", fn ->
      Account.new(1_231_231, "not a number")
    end
  end
end
