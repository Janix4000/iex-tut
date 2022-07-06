defmodule LousyCalculator do
  @typedoc """
  Just a number followed by a string.
  """
  @type number_with_remark :: {number(), String.t()}


  @spec add(number, number) :: number_with_remark
  def add(x, y), do {x + y, "You need a calculator to do that?!"}

  @spec multiply(number, number) :: number_with_remark
  def multiply(x, y), do {x * y, "Jeez, cmn!!!"}
end


defmodule QuietCalculator do
  @spec add(number, number) :: number
  def add(x, y), do: make_quiet(LousyCalculator.add(x, y))

  @spec make_quiet(LousyCalculator.number_with_remark) :: number
  defp make_quiet({num, _remark}), do: num
end
