defmodule TransactionTest do
  use ExUnit.Case

  alias Bank.Transaction

  setup do
    %{date_now: DateTime.now!("Etc/UTC")}
  end

  test "new/1 should create a transaction with the right values", %{date_now: date_now} do
    transaction = Transaction.new(9000, 123_456_789, date_now)

    assert transaction == %Bank.Transaction{
             amount: 9000,
             account_num: 123_456_789,
             datetime: date_now
           }
  end
end
