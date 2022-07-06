import Parser

defmodule YAMLParser do
  @behaviour Parser

  @impl Parser
  def pars(str), do: {:ok, "some yaml " <> str}

  @impl Parser
  def extensions, do: ~w[yml]
end
