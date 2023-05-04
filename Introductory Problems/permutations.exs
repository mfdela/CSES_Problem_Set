# A permutation of integers 1,2,…,n is called beautiful if there are no adjacent elements whose difference is 1
#
# Given n , construct a beautiful permutation if such a permutation exists.
#
# Input
# The only input line contains an integer n
#
# Output
# Print a beautiful permutation of integers 1,2,…,n. If there are several solutions, you may print any of them. If there are no solutions, print "NO SOLUTION".
#
# Constraints
# 1≤n≤10^6
#
# Example 1
#
# Input:
# 5
#
# Output:
# 4 2 5 3 1
#
# Example 2
#
# Input:
# 3
#
# Output:
# NO SOLUTION

defmodule Permutations do

  def read_file(file) do
    File.read!(file) |> String.trim() |> String.to_integer()
  end

  # classic permutations computation
  # defp permutations([]), do: [[]]
  # defp permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]
  
  # But we don't want to generate all permutations before checking them
  
  defp beautiful_permutations(n) when is_integer(n) do
    Enum.to_list(1..n) |> beautiful_permutations(n, [], [])
  end

  defp beautiful_permutations([], _, _, sol), do: sol
  
  defp beautiful_permutations(list, length, [], []) do
    for elem <- list, reduce: [] do
      acc ->
         beautiful_permutations(list -- [elem], length, [elem], acc)
    end
  end

  defp beautiful_permutations(list, length, curr_sol, sol) do
    for elem <- list, abs(elem - hd(curr_sol)) > 1, reduce: sol do
      acc -> 
        new_curr = [elem|curr_sol]
        cond do 
          length(new_curr) == length -> new_curr
          true -> beautiful_permutations(list -- [elem], length, new_curr, acc)
        end
    end
  end


  def run() do
    n = read_file("input.txt")
    perm = beautiful_permutations(n)
    cond do 
      perm == [] -> IO.puts("NO SOLUTION")
      true -> perm |> Enum.join(" ") |> IO.puts()
    end
  end
end

Permutations.run()
