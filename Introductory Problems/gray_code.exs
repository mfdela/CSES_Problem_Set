# Gray Code
#
# A Gray code is a list of all 2n bit strings of length n,
# where any two successive strings differ in exactly one bit
# (i.e., their Hamming distance is one).
#
# Your task is to create a Gray code for a given length n
#
# Input
# The only input line has an integer n
#
# Output
# Print 2^n lines that describe the Gray code. You can print any valid solution.
#
# Constraints
# 1≤n≤16
#
# Example
#
# Input:
# 2
#
# Output:
# 00
# 01
# 11
# 10


defmodule GrayCode do
  defp read_file(file), do: File.read!(file) |> String.trim() |> String.to_integer()

  defp gray_code(0), do: ["0"]
  defp gray_code(1), do: ["0", "1"]

  defp gray_code(n) do
    l = gray_code(n-1)
    l1 = for i <- l, do: "0" <> i
    l2 = for i <- Enum.reverse(l), do: "1" <> i
    l1 ++ l2
  end

  def run() do
    l = read_file("input.txt") |> gray_code()
    for i <- l, do: IO.puts(i)
  end
end

GrayCode.run()
