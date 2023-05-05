# Your task is to calculate the number of bit strings of length n
# For example, if n=3, the correct answer is 8,
# because the possible bit strings are 000, 001, 010, 011, 100, 101, 110, and 111.
#
# Input
# The only input line has an integer n
#
# Output
# Print the result modulo 10^9+7
#
# Constraints
# 1≤n≤10^6
#
# Example
#
# Input:
# 3
#
# Output:
# 8

defmodule BitStrings do

  defp read_file(file) do
    File.read!(file) |> String.trim() |> String.to_integer()
  end

  defp bitstrings(n) do
    # 2 ^^ n is > 10^9+7 for n >= 30
    # elixir vm is smart enough to compute the result
    # otherwise we could decompose the result in
    # 2^30 * 2^30 * ... until we reach 2^n
    rem(2 ** n, 1000000007)
  end

  def run() do
    read_file("input.txt") |> bitstrings() |> IO.puts()
  end
end

BitStrings.run()
