defmodule UnrootedPolytree.Edges do
  @moduledoc """
  Directional edges for a Node. Includes both next and previous edges.
  """

  alias UnrootedPolytree.Node

  @type t :: %__MODULE__{
          next: [Node.id()],
          previous: [Node.id()]
        }

  defstruct next: [], previous: []

  @doc """
  Returns a list of the next nodes.

  iex> UnrootedPolytree.Edges.next(%UnrootedPolytree.Edges{next: ["x", "y", "z"]})
  ["x", "y", "z"]
  """
  @spec next(t()) :: [Node.id()]
  def next(%__MODULE__{next: next}), do: next

  @doc """
  Returns a list of the previous nodes.

  iex> UnrootedPolytree.Edges.previous(%UnrootedPolytree.Edges{previous: ["a", "b", "c"]})
  ["a", "b", "c"]
  """
  @spec previous(t()) :: [Node.id()]
  def previous(%__MODULE__{previous: previous}), do: previous
end
