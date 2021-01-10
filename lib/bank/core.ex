defmodule Bank.Core do
  @spec transfer(Bank.Account, Bank.Account, integer) ::
          {:ok, {Bank.Account, Bank.Account}} | {:error, String.t()}
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

  @spec balance(Bank.Account) :: integer
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

  @spec add_transaction(Bank.Account, Bank.Transaction) :: Bank.Account
  defp add_transaction(account, transaction) do
    Map.update(
      account,
      :transactions,
      [transaction],
      fn all_trans -> [transaction | all_trans] end
    )
  end
end
