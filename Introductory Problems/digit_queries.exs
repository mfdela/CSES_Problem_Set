# Consider an infinite string that consists of all positive integers in increasing order:
#
# 12345678910111213141516171819202122232425...
#
# Your task is to process q
#  queries of the form: what is the digit at position k
#  in the string?
#
# Input
# The first input line has an integer q: the number of queries.
#
# After this, there are q lines that describe the queries.
# Each line has an integer k: a 1-indexed position in the string.
#
# Output
# For each query, print the corresponding digit.
#
# Constraints
# 1≤q≤1000
#
# 1≤k≤10^18
#
# Example
#
# Input:
# 3
# 7
# 19
# 12
#
# Output:
# 7
# 4
# 1

defmodule DigitQueries do
  defp read_file(file) do
    [_ | queries] = File.read!(file) |> String.split("\n", trim: true)
    queries |> Enum.map(&String.to_integer/1)
  end


  defp string_pos_n(n) do
    string_pos_n(n, 9, 1)
  end

  defp string_pos_n(n, p, i) when n<p, do: [n, i]
  defp string_pos_n(n, p, i) do
    string_pos_n(n - p, 9 * (i + 1) * trunc(:math.pow(10, i)), i + 1)
  end


  defp string_pos(n) do
    [m, i] = string_pos_n(n)
    trunc(:math.pow(10, i-1)) + div(m - 1,i)
    |> Integer.to_string()
    |> String.split("", trim: true)
    |> Enum.at(rem(m - 1, i))
  end

  def run() do
    read_file("input.txt") |> Enum.map(fn x -> string_pos(x) |> IO.puts() end)
  end
end

DigitQueries.run()
