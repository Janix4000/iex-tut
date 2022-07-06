defmodule Concat do
  def concat(a, b, sep \\ " ") do
    case {a, b} do
      {a, nil} -> a
      _ -> a <> sep <> b
    end
  end
end
