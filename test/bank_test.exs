defmodule BankTest do
  use ExUnit.Case

  alias Bank.Account
  alias Bank.Transaction

  setup do
    %{now: DateTime.now!("Etc/UTC")}
  end

  describe "balance/1" do
    test "should give correct balance when no transactions" do
      account = %Account{account_num: 123, initial_balance: 100}

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
    test "should add complementary transactions to both accounts" do
      from = %Account{account_num: 321, initial_balance: 100}
      to = %Account{account_num: 123, initial_balance: 100}

      {:ok, {new_from, new_to}} = Bank.transfer(from, to, 10)
      [from_transaction | _] = new_from.transactions
      [to_transaction | _] = new_to.transactions

      assert from_transaction.amount == -to_transaction.amount
    end

    test "should do nothing when transferring zero balance" do
      from = %Account{account_num: 321, initial_balance: 100}
      to = %Account{account_num: 123, initial_balance: 100}

      {:ok, {new_from, new_to}} = Bank.transfer(from, to, 0)

      assert new_from == from
      assert new_to == to
    end

    test "should give error when from account balance too low" do
      from = %Account{account_num: 321, initial_balance: 100}
      to = %Account{account_num: 123, initial_balance: 100}

      assert {:error, message} = Bank.transfer(from, to, 101)

      assert message == "Payee balance too low"
    end

    test "should give an error when transferring to the same account" do
      account = %Account{account_num: 321, initial_balance: 100}

      assert {:error, message} = Bank.transfer(account, account, 200)

      assert message == "Cannot transfer to the same account"
    end
  end
end
