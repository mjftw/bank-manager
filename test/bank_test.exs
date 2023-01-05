defmodule BankTest do
  use ExUnit.Case

  alias Bank.Account
  alias Bank.Transaction

  doctest Bank

  setup do
    %{now: DateTime.now!("Etc/UTC")}
  end

  describe "balance/1" do
    test "should give correct balance when no transactions" do
      account = %Account{account_num: 123, initial_balance: 100, transactions: []}

      assert Bank.balance(account) == 100
    end

    test "should give correct balance with transactions", %{now: now} do
      account = %Account{
        account_num: 123,
        initial_balance: 100,
        transactions: [
          %Transaction{amount: 10, account_num: 321, datetime: now},
          %Transaction{amount: 75, account_num: 321, datetime: now},
          %Transaction{amount: -15, account_num: 321, datetime: now}
        ]
      }

      assert Bank.balance(account) == 100 + 10 + 75 - 15
    end
  end

  describe "transfer/3" do
    @tag :skip
    test "should add complementary transactions to both accounts" do
      # TODO
    end

    @tag :skip
    test "should do nothing when transferring zero balance" do
      # TODO
    end

    @tag :skip
    test "should give error when from account balance too low" do
      # TODO
    end

    @tag :skip
    test "should give an error when transferring to the same account" do
      # TODO
    end
  end
end
