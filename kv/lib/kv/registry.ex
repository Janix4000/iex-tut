defmodule KV.Registry do
  use GenServer

  @doc """
  Starts the registry.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Loop up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket associated with `name` in the `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  @impl true
  def init(:ok) do
    named_buckets = %{}
    refs = %{}
    {:ok, {named_buckets, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {named_buckets, _} = state
    {:reply, Map.fetch(named_buckets, name), state}
  end

  @impl true
  def handle_cast({:create, name}, {named_buckets, refs}) do
    if Map.has_key?(named_buckets, name) do
      {:noreply, named_buckets}
    else
      {:ok, bucket} = KV.Bucket.start_link()
      ref = Process.monitor(bucket)
      refs = Map.put(refs, ref, name)
      named_buckets = Map.put(named_buckets, name, bucket)
      {:noreply, {named_buckets, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {named_buckets, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(named_buckets, name)
    {:noreply, {named_buckets, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in KV.Registry: #{inspect(msg)}")
    {:noreply, state}
  end
end
