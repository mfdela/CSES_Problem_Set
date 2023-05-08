# Given a string, your task is to generate all different strings that can be created using its characters.
#
# Input
# The only input line has a string of length n.
# Each character is between a–z.
#
# Output
# First print an integer k: the number of strings.
# Then print k lines: the strings in alphabetical order.
#
# Constraints
# 1≤n≤8
#
# Example
#
# Input:
# aabac
#
# Output:
# 20
# aaabc
# aaacb
# aabac
# aabca
# aacab
# aacba
# abaac
# abaca
# abcaa
# acaab
# acaba
# acbaa
# baaac
# baaca
# bacaa
# bcaaa
# caaab
# caaba
# cabaa
# cbaaa


defmodule CreatingStrings do

  defp read_file(file) do
    File.read!(file) |> String.trim() |> String.graphemes()
  end

  defp permutations([]), do: [[]]
  defp permutations(list), do: for elem <- list, rest <- permutations(list--[elem]), do: [elem|rest]

  def run() do
    out = read_file("input.txt") |> Enum.sort() |> permutations() |> Enum.uniq()
    length(out) |> IO.puts()
    for o <- out, do: Enum.join(o, "") |> IO.puts()
  end

end

CreatingStrings.run()
