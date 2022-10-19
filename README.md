# UnrootedPolytree

A data type and related functions to support an unrooted (multiple starting nodes) polytree (a tree-like graph with edges).

Pictoral example:

```text
O--->O--->O              O--->O
            \            ˄
            ˅          /
  O--->O--->O--->O--->O--->O--->O--->O
                        \
                        ˅
                        O
```

## Installation

This package can be installed by adding `unrooted_polytree` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unrooted_polytree, "~> 0.1.0"}
  ]
end
```

## Usage

Construct an `UnrootedPolytree` struct by passing a list of lists to `UnrootedPolytree.from_lists/1`. The values in the inner list should be a 2-item tuple composed of:

- An ID string
- A value of any type

IDs are treatead as unique within the `UnrootedPolytree` struct, and are used to determine branching structures.

The first item in each inner list is a starting node in the `UnrootedPolytree` struct.

Example:

```elixir
unrooted_polytree = UnrootedPolytree.from_lists([
  [
    {"a1", %{ id: "a1" }},
    {"a2", %{ id: "a2" }},
    {"m1", %{ id: "m1" }},
    {"m2", %{ id: "m2" }}
  ],
  [
    {"b1", %{ id: "b1" }},
    {"b2", %{ id: "b2" }},
    {"b3", %{ id: "b3" }},
    {"m1", %{ id: "m1" }},
    {"m2", %{ id: "m2" }},
    {"m3", %{ id: "m3" }},
    {"y1", %{ id: "y1" }}
  ],
  [
    {"c1", %{ id: "c1" }},
    {"c2", %{ id: "c2" }},
    {"m2", %{ id: "m2" }},
    {"m3", %{ id: "m3" }},
    {"x1", %{ id: "x1" }},
    {"x2", %{ id: "x2" }},
  ],
])
```

This results in the branching structure:

```text
        a1 ---> a2                          x1 ---> x2
                      \                    ˄
                        ˅                  /
b1 ---> b2 ---> b3 ---> m1 ---> m2 ---> m3
                                ˄          \
                              /            ˅
                c1 ---> c2                  y1
```

with the starting nodes:

```elixir
["a1", "b1", "c1"]
```

Retrieve the value of a node:

```elixir
> UnrootedPolytree.node_for_id(unrooted_polytree, "m1")
{:ok, %UnrootedPolytree.Node{id: "m1", value: %{id: "m1"}}}
```

Retrieve the edges for a node:

```elixir
> UnrootedPolytree.edges_for_id(unrooted_polytree, "m1")
%Edges{next: ["m2"], previous: ["a2", "b3"]}
```

## Documentation

Full documentation is available on [HexDocs](https://hexdocs.pm/unrooted_polytree).

## License

`UnrootedPolytree` is licensed under the [MIT](LICENSE) license.
