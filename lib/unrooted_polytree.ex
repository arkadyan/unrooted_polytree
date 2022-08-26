defmodule UnrootedPolytree do
  @moduledoc """
  A data type and related functions to support an unrooted (multiple starting nodes) polytree (a tree-like graph with edges).
  """

  alias UnrootedPolytree.{Edges, Node}

  @type nodes_by_id :: %{Node.id() => Node.t()}
  @type edges_by_id :: %{Node.id() => Edges.t()}

  @type t :: %__MODULE__{
          by_id: nodes_by_id(),
          edges: edges_by_id(),
          starting_nodes: [Node.id()]
        }

  @type id_and_value :: {Node.id(), any()}

  defstruct by_id: %{}, edges: %{}, starting_nodes: []

  @spec node_for_id(t(), Node.id()) :: {:ok, Node.t()} | :error
  def node_for_id(%__MODULE__{by_id: by_id}, id), do: Map.fetch(by_id, id)

  @spec edges_for_id(t(), Node.id()) :: Edges.t()
  def edges_for_id(%__MODULE__{edges: edges}, id), do: Map.get(edges, id, %Edges{})

  @doc """
  Construct an UnrootedPolytree from a list of values and associated ID strings
  """
  @spec from_list([id_and_value()]) :: t()
  @spec from_list([id_and_value()], t()) :: t()
  @spec from_list([id_and_value()], t(), Node.id()) :: t()
  def from_list(list), do: from_list(list, %UnrootedPolytree{})

  defp from_list([], tree), do: tree

  defp from_list(
         [{id, value} | tail],
         %__MODULE__{by_id: by_id, edges: edges, starting_nodes: starting_nodes}
       ) do
    new_tree = %__MODULE__{
      by_id: add_by_id(by_id, id, value),
      edges: edges,
      starting_nodes: [id | starting_nodes]
    }

    from_list(tail, new_tree, id)
  end

  defp from_list([], tree, _previous_id), do: tree

  defp from_list(
         [{id, value} | tail],
         %__MODULE__{by_id: by_id, starting_nodes: starting_nodes} = tree,
         previous_id
       ) do
    new_tree = %__MODULE__{
      by_id: add_by_id(by_id, id, value),
      edges: add_next_and_previous_edges(tree, id, previous_id),
      starting_nodes: starting_nodes
    }

    from_list(tail, new_tree, id)
  end

  @spec add_by_id(nodes_by_id(), Node.id(), any()) :: nodes_by_id()
  defp add_by_id(by_id, id, value),
    do: Map.merge(by_id, %{id => Node.from_id_and_value(id, value)})

  @spec add_next_and_previous_edges(t(), Node.id(), Node.id()) :: edges_by_id()
  defp add_next_and_previous_edges(%UnrootedPolytree{edges: edges} = tree, next_id, previous_id) do
    Map.merge(
      edges,
      %{
        next_id => tree |> edges_for_id(next_id) |> Edges.add_previous(previous_id),
        previous_id => tree |> edges_for_id(previous_id) |> Edges.add_next(next_id)
      }
    )
  end
end
