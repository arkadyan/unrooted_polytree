defmodule UnrootedPolytreeTest do
  use ExUnit.Case
  doctest UnrootedPolytree

  alias UnrootedPolytree.{Edges, Node}

  describe "from_list/1" do
    test "constructs an UnrootedPolytree from a list of values and associated ID strings" do
      list = [
        {"one", 1},
        {"two", 2},
        {"three", 3}
      ]

      expected = %UnrootedPolytree{
        by_id: %{
          "one" => %Node{id: "one", value: 1},
          "two" => %Node{id: "two", value: 2},
          "three" => %Node{id: "three", value: 3}
        },
        edges: %{
          "one" => %Edges{next: ["two"], previous: []},
          "two" => %Edges{next: ["three"], previous: ["one"]},
          "three" => %Edges{next: [], previous: ["two"]}
        },
        starting_nodes: ["one"]
      }

      assert UnrootedPolytree.from_list(list) == expected
    end

    test "given an empty list returns an empty tree" do
      assert UnrootedPolytree.from_list([]) == %UnrootedPolytree{}
    end
  end
end
