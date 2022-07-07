defmodule KV.Bucket do
  use Agent

  @doc """
  Creates a new `bucket` with the given options.
  """
  def start_link(_opts \\ []), do: Agent.start_link(fn -> %{} end)

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, id) do
    Agent.get(bucket, &Map.get(&1, id))
  end

  @doc """
  Puts a `value` into the `bucket` for the given `id`.
  """
  def put(bucket, id, value) do
    Agent.update(bucket, &Map.put(&1, id, value))
  end

  @doc """
  Delete `id` from the given `bucket`.

  Returns the current value of the given `id` if exists.
  """
  def delete(bucket, id) do
    Agent.get_and_update(bucket, &Map.pop(&1, id))
  end
end
