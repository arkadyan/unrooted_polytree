defmodule UnrootedPolytree.Node do
  @moduledoc """
  A node in an UnrootedPolytree. Contains any value, and a unique string ID.
  """

  @type id :: String.t()

  @type t :: %__MODULE__{
          id: id(),
          value: any()
        }

  @enforce_keys [:id, :value]

  defstruct @enforce_keys

  @doc ~S"""
  Returns the ID string of this node.

  iex> UnrootedPolytree.Node.id(%UnrootedPolytree.Node{id: "a", value: %{foo: "bar"}})
  "a"
  """
  @spec id(t()) :: id()
  def id(%__MODULE__{id: id}), do: id

  @doc ~S"""
  Returns the value of this node.

  iex> UnrootedPolytree.Node.value(%UnrootedPolytree.Node{id: "a", value: %{foo: "bar"}})
  %{foo: "bar"}
  """
  @spec value(t()) :: any()
  def value(%__MODULE__{value: value}), do: value
end
