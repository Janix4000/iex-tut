import Parser

defmodule JSONParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some json " <> str}

  @impl Parser
  def extensions, do: ~w[json]
end


parser = JSONParser()

JSONParser.parse!("")

Parser.parse!(JSONParser, "")
