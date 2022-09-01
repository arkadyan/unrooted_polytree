# UnrootedPolytree

A data type and related functions to support an unrooted (multiple starting nodes) polytree (a tree-like graph with edges).

Pictoral example:

    O--->O--->O              O--->O
                \            ˄
                ˅          /
      O--->O--->O--->O--->O--->O--->O--->O
                            \
                            ˅
                            O

## Installation

This package can be installed by adding `unrooted_polytree` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unrooted_polytree, "~> 0.1.0"}
  ]
end
```

## Documentation

Full documentation is available on [HexDocs](https://hexdocs.pm/unrooted_polytree).

## License

`UnrootedPolytree` is licensed under the [MIT](LICENSE) license.
