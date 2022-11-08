defmodule UnrootedPolytreeTest do
  use ExUnit.Case
  doctest UnrootedPolytree

  alias UnrootedPolytree.{Edges, Node}

  @green_line_example %UnrootedPolytree{
    by_id: %{
      "ball" => %Node{id: "ball", value: "ball"},
      "bland" => %Node{id: "bland", value: "bland"},
      "buest" => %Node{id: "buest", value: "buest"},
      "clmnl" => %Node{id: "clmnl", value: "clmnl"},
      "coecl" => %Node{id: "coecl", value: "coecl"},
      "fenwy" => %Node{id: "fenwy", value: "fenwy"},
      "gover" => %Node{id: "gover", value: "gover"},
      "hsmnl" => %Node{id: "hsmnl", value: "hsmnl"},
      "hymnl" => %Node{id: "hymnl", value: "hymnl"},
      "kencl" => %Node{id: "kencl", value: "kencl"},
      "lake" => %Node{id: "lake", value: "lake"},
      "lech" => %Node{id: "lech", value: "lech"},
      "medt" => %Node{id: "medt", value: "medt"},
      "north" => %Node{id: "north", value: "north"},
      "pktrm" => %Node{id: "pktrm", value: "pktrm"},
      "prmnl" => %Node{id: "prmnl", value: "prmnl"},
      "river" => %Node{id: "river", value: "river"},
      "smary" => %Node{id: "smary", value: "smary"},
      "unsqu" => %Node{id: "unsqu", value: "unsqu"}
    },
    edges: %{
      "ball" => %Edges{next: ["medt"], previous: ["lech"]},
      "bland" => %Edges{next: ["kencl"], previous: ["buest"]},
      "buest" => %Edges{next: ["bland"], previous: ["lake"]},
      "clmnl" => %Edges{next: ["smary"], previous: []},
      "coecl" => %Edges{next: ["pktrm"], previous: ["prmnl", "hymnl"]},
      "fenwy" => %Edges{next: ["kencl"], previous: ["river"]},
      "gover" => %Edges{next: ["north"], previous: ["pktrm"]},
      "hsmnl" => %Edges{next: ["prmnl"], previous: []},
      "hymnl" => %Edges{next: ["coecl"], previous: ["kencl"]},
      "kencl" => %Edges{next: ["hymnl"], previous: ["fenwy", "smary", "bland"]},
      "lake" => %Edges{next: ["buest"], previous: []},
      "lech" => %Edges{next: ["ball", "unsqu"], previous: ["north"]},
      "medt" => %Edges{next: [], previous: ["ball"]},
      "north" => %Edges{next: ["lech"], previous: ["gover"]},
      "pktrm" => %Edges{next: ["gover"], previous: ["coecl"]},
      "prmnl" => %Edges{next: ["coecl"], previous: ["hsmnl"]},
      "river" => %Edges{next: ["fenwy"], previous: []},
      "smary" => %Edges{next: ["kencl"], previous: ["clmnl"]},
      "unsqu" => %Edges{next: [], previous: ["lech"]}
    },
    starting_nodes: ["hsmnl", "river", "clmnl", "lake"]
  }

  describe "from_lists/1" do
    test "constructs an UnrootedPolytree from a list of lists of values and associated ID strings" do
      b = [
        {"lake", "lake"},
        {"buest", "buest"},
        {"bland", "bland"},
        {"kencl", "kencl"},
        {"hymnl", "hymnl"},
        {"coecl", "coecl"},
        {"pktrm", "pktrm"},
        {"gover", "gover"}
      ]

      c = [
        {"clmnl", "clmnl"},
        {"smary", "smary"},
        {"kencl", "kencl"},
        {"hymnl", "hymnl"},
        {"coecl", "coecl"},
        {"pktrm", "pktrm"},
        {"gover", "gover"}
      ]

      d = [
        {"river", "river"},
        {"fenwy", "fenwy"},
        {"kencl", "kencl"},
        {"hymnl", "hymnl"},
        {"coecl", "coecl"},
        {"pktrm", "pktrm"},
        {"gover", "gover"},
        {"north", "north"},
        {"lech", "lech"},
        {"unsqu", "unsqu"}
      ]

      e = [
        {"hsmnl", "hsmnl"},
        {"prmnl", "prmnl"},
        {"coecl", "coecl"},
        {"pktrm", "pktrm"},
        {"gover", "gover"},
        {"north", "north"},
        {"lech", "lech"},
        {"ball", "ball"},
        {"medt", "medt"}
      ]

      list_of_lists = [b, c, d, e]

      expected = @green_line_example

      assert UnrootedPolytree.from_lists(list_of_lists) == expected
    end

    test "given an empty list returns an empty tree" do
      assert UnrootedPolytree.from_lists([]) == %UnrootedPolytree{}
    end

    test "constructs an UnrootedPolytree from a single list of values and associated ID strings" do
      list_of_lists = [
        [
          {"one", 1},
          {"two", 2},
          {"three", 3}
        ]
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

      assert UnrootedPolytree.from_lists(list_of_lists) == expected
    end

    test "merges duplicate starting nodes" do
      list_of_lists = [
        [
          {"a", "a"},
          {"b", "b"},
          {"x", "x"}
        ],
        [
          {"a", "a"},
          {"b", "b"},
          {"y", "y"}
        ]
      ]

      expected = %UnrootedPolytree{
        by_id: %{
          "a" => %Node{id: "a", value: "a"},
          "b" => %Node{id: "b", value: "b"},
          "x" => %Node{id: "x", value: "x"},
          "y" => %Node{id: "y", value: "y"}
        },
        edges: %{
          "a" => %Edges{next: ["b"], previous: []},
          "b" => %Edges{next: ["y", "x"], previous: ["a"]},
          "x" => %Edges{next: [], previous: ["b"]},
          "y" => %Edges{next: [], previous: ["b"]}
        },
        starting_nodes: ["a"]
      }

      assert UnrootedPolytree.from_lists(list_of_lists) == expected
    end
  end

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

  describe "node_for_id/2" do
    test "returns the value of the requested node" do
      assert UnrootedPolytree.node_for_id(@green_line_example, "coecl") ==
               {:ok, %UnrootedPolytree.Node{id: "coecl", value: "coecl"}}
    end
  end

  describe "edges_for_id/2" do
    test "returns the edges for the requested node" do
      assert UnrootedPolytree.edges_for_id(@green_line_example, "coecl") ==
               %Edges{next: ["pktrm"], previous: ["prmnl", "hymnl"]}
    end
  end
end
