# Bank

Simple bank account manager.

Designed to demonstrate the idea of event sourcing, where the current state is
not explicitly saved, all transactions that modify the state are.
Following this method the current state can be computed by performing a reduction
over all the transactions.

This idea maps nicely to a bank that makes transactions between accounts, so this
is the example I've implemented.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bank, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bank](https://hexdocs.pm/bank).

