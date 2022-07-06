defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect(@initial_state)

  @my_data 14
  def first_data, do: @my_data
  @my_data 13
  def second_data, do: @my_data
end
