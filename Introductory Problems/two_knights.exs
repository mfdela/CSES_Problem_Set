# Your task is to count for k=1,2,…,n
# the number of ways two knights can be placed on a k×k
# chessboard so that they do not attack each other.
#
#Input
# The only input line contains an integer n
#
# Output
# Print n integers: the results.
#
# Constraints
# 1≤n≤10000
#
# Example
#
# Input:
# 8
#
# Output:
# 0
# 6
# 28
# 96
# 252
# 550
# 1056
# 1848

defmodule TwoKnigths do

  defp read_file(file) do
    File.read!(file) |> String.trim() |> String.to_integer()
  end

  defp knigth_reach([i, j], k) do
    all_pos = MapSet.new([[i - 2, j - 1], [i - 2, j + 1], [i - 1, j + 2], [i + 1, j + 2], [i + 2, j - 1], [i + 2, j + 1], [i - 1, j - 2], [i + 1, j - 2]])
    allowed_pos = for p <- all_pos, reduce: MapSet.new([]) do
      acc ->
        [y, x] = p
        cond do
          y >= 1 and y <= k and x >= 1 and x <= k -> MapSet.put(acc, p)
          true -> acc
        end
    end
    Enum.count(allowed_pos)
  end

  defp two_k_positions(n) when n>0 do
    for k <- 1..n do
      count = for i <- 1..k, j <- 1..k, reduce: 0 do
        acc ->
          count_reach = knigth_reach([i, j], k)
          acc + (k * k - 1 - count_reach)
      end
      div(count, 2) |> IO.puts()
    end
  end

  def run() do
    read_file("input.txt") |> two_k_positions()
  end
end

TwoKnigths.run()
