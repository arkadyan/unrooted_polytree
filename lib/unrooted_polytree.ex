defmodule UnrootedPolytree do
  @moduledoc """
  A data type and related functions to support an unrooted (multiple starting nodes) polytree (a tree-like graph with edges).
  """

  alias UnrootedPolytree.{Edges, Node}

  @type t :: %__MODULE__{
          by_id: %{Node.id() => Node.t()},
          edges: %{Node.id() => Edges.t()},
          starting_nodes: [Node.id()]
        }

  defstruct by_id: %{}, edges: %{}, starting_nodes: []
end
