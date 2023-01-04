defmodule Bank do
  def transfer(from, to, 0), do: {:ok, {from, to}}
  def transfer(from, to, _) when from == to, do: {:error, "Cannot transfer to the same account"}

  def transfer(from_account, to_account, amount) do
    case balance(from_account) >= amount do
      false ->
        {:error, "Payee balance too low"}

      true ->
        {:ok, now} = DateTime.now("Etc/UTC")

        debited_from =
          add_transaction(from_account, %Bank.Transaction{
            amount: -amount,
            account_num: to_account.account_num,
            datetime: now
          })

        credited_to =
          add_transaction(to_account, %Bank.Transaction{
            amount: amount,
            account_num: from_account.account_num,
            datetime: now
          })

        {:ok, {debited_from, credited_to}}
    end
  end

  def balance(account) do
    case Enum.empty?(account.transactions) do
      true ->
        account.initial_balance

      false ->
        transactions_sum =
          account.transactions
          |> Enum.map(fn transaction -> transaction.amount end)
          |> Enum.reduce(&(&1 + &2))

        account.initial_balance + transactions_sum
    end
  end

  defp add_transaction(account, transaction) do
    # New transactions are stored at the start of the list rather than the end
    # as this is much more efficient.
    Map.update(
      account,
      :transactions,
      [transaction],
      fn all_trans -> [transaction | all_trans] end
    )
  end
end
