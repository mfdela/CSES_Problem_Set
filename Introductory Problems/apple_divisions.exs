# Apple Division
#
# There are n apples with known weights.
# Your task is to divide the apples into two groups so that the
# difference between the weights of the groups is minimal.
#
# Input
# The first input line has an integer n: the number of apples.
#
# The next line has n
#  integers p1,p2,…,pn: the weight of each apple.
#
# Output
# Print one integer: the minimum difference between the weights of the groups.
#
# Constraints
# 1≤n≤20
#
# 1≤pi≤10^9
#
# Example
#
# Input:
# 5
# 3 2 7 4 1
#
# Output:
# 1
#
# Explanation: Group 1 has weights 2, 3 and 4 (total weight 9), and group 2 has weights 1 and 7 (total weight 8).


defmodule AppleDivisions do
  defp read_file(file) do
    [_, weights] = File.read!(file) |> String.split("\n", trim: true)
    weights |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def combinations(_, 0), do: [[]]
  def combinations([], _), do: []
  def combinations([h|t], m) do
    (for l <- combinations(t, m-1), do: [h|l]) ++ combinations(t, m)
  end

  defp apple_divisions(weight_list) do
    sum = Enum.sum(weight_list)
    for i <- 1..(div(length(weight_list), 2) + 1), reduce: sum do
      acc ->
        for c <- combinations(weight_list, i), reduce: acc do
          acc ->
            s = abs(2 * Enum.sum(c) - sum)
            cond do
              s < acc -> s
              true -> acc
            end
        end
    end

  end

  def run, do: read_file("input.txt") |> apple_divisions() |> IO.puts()
  
end


AppleDivisions.run()
