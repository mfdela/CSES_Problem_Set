# Your task is to divide the numbers 1,2,…,n into two sets of equal sum.
#
# Input
# The only input line contains an integer n
#
# Output
# Print "YES", if the division is possible, and "NO" otherwise.
# After this, if the division is possible, print an example of how to create the sets. First, print the number of elements in the first set followed by the elements themselves in a separate line, and then, print the second set in a similar way.
#
# Constraints
# 1≤n≤10^6
#
# Example 1
#
# Input:
# 7
#
# Output:
# YES
# 4
# 1 2 4 7
# 3
# 3 5 6
#
# Example 2
#
# Input:
# 6
#
# Output:
# NO


defmodule TwoSet do

  defp read_file(file) do
    File.read!(file) |> String.trim() |> String.to_integer()
  end

  defp equal_partitions(1), do: []
  defp equal_partitions(2), do: []
  defp equal_partitions(3) do
   [[1, 2], [3]]
  end
  defp equal_partitions(5), do: []
  defp equal_partitions(6), do: []

  defp equal_partitions(n) do
    # if n mod 4 == 0 then
    # n(n + 1) / 2 is even, we can split the set in two parts
    # using Gauss algorithm, associating n with 1, n - 1 with 2, etc.
    #
    # if n <> 0 mod 4, then n-3 = 0 mod 4
    # so we can calculate the partitions for 4..n
    # and we add {1, 2} and {3} to the sets

    {range, k, start} = cond do
      rem(n, 4) == 0 -> {1..div(n, 2)//2, 0, [MapSet.new([]), MapSet.new([])]}
      true -> {4..(div(n, 2) + 1)//2, 3, [MapSet.new([1, 2]), MapSet.new([3])]}
    end
    [f, s] = for i <- range, reduce: start do
      acc ->
        [first_set, second_set] = acc
        [first_set |> MapSet.put(i) |> MapSet.put(n - i + k + 1),
         second_set |> MapSet.put(i + 1) |> MapSet.put(n - i + k)]
    end
    # extra check
    #cond do
    #  Enum.sum(f) == Enum.sum(s) -> [f, s]
    #  true -> []
    #end
    [f, s]
  end

  def run() do
    sol = read_file("input.txt") |> equal_partitions()
    cond do
      sol == [] -> IO.puts("NO")
      true -> IO.puts("YES"); for s <- sol, do: (IO.puts(Enum.count(s)); IO.puts(Enum.join(s, " ")))
    end
  end
end

TwoSet.run()
