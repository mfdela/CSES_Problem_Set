# Palindrome Reorder
#
# Given a string, your task is to reorder its letters in such a way
# that it becomes a palindrome (i.e., it reads the same forwards and backwards).
#
# Input
# The only input line has a string of length n
#  consisting of characters A–Z.
#
# Output
# Print a palindrome consisting of the characters of the original string. You may print any valid solution. If there are no solutions, print "NO SOLUTION".
#
# Constraints
# 1≤n≤10^6
#
# Example
#
# Input:
# AAAACACBA
#
# Output:
# AACABACAA

defmodule PalindromeReorder do

  defp read_file(file), do: File.read!(file) |> String.trim()

  defp palindrome(string) do
    freq = string |> String.graphemes |> Enum.frequencies()
    odd_freq = freq |> Map.values()
             |> Enum.reduce_while(0, fn x, acc ->
                count = if rem(x, 2) == 1, do: acc + 1, else: acc
                if count > 1, do: {:halt, count}, else: {:cont, count}
              end)
    if (odd_freq > 1) do
      # there's more than one single character, the string can't be palindrome
      IO.puts("NO SOLUTION")
    else
      s = for {char, count} <- freq, reduce: [[], [], []] do
        acc ->
          [first_half, center, second_half] = acc
          cond do
            count == 1 ->  [first_half, [char], second_half]
            true -> [[String.duplicate(char, div(count, 2)) | first_half], center, second_half ++ [String.duplicate(char, div(count, 2))]]
          end
      end
      s |> Enum.join("") |> IO.puts()
    end
  end

  def run(), do: read_file("input.txt") |> palindrome()
  
end


PalindromeReorder.run()
