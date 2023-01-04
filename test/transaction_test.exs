defmodule TransactionTest do
  use ExUnit.Case

  alias Bank.Transaction

  setup do
    %{date_now: DateTime.now!("Etc/UTC")}
  end

  @tag :skip
  test "new/1 should create a transaction with the right values", %{date_now: date_now} do
    # TODO
  end
end
