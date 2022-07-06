defmodule Parser do
  @doc """
  Parses a string.
  """
  @callback parse(String.t()) :: {:ok, term} | {:error, String.t()}

  @doc """
  List all supported file extensions.
  """
  @callback extensions() :: [String.t()]

  @doc """
  Parses a string or raises error.
  """

  def foo(a, b), do: a + b

  def parse!(implementation, contents) do
    case implementation.parse(contents) do
      {:ok, data} -> data
      {:error, error} -> raise ArgumentError, "parsing error: #{error}"
    end
  end
end

JSONParser.foo(3)
