# You are given all numbers between 1,2,…,n except one. Your task is to find the missing number.
#
# Input
# The first input line contains an integer n
# The second line contains n−1 numbers. Each number is distinct and between 1 and n (inclusive).
#
# Output
# Print the missing number.
#
# Constraints
# 2≤n≤2⋅10^5
#
# Example
#
# Input:
# 5
# 2 3 1 5
#
# Output:
# 4


defmodule MissingNumber do

  defp read_file(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&String.split(&1, " ", trim: true))
    |> Enum.map(&String.to_integer/1)
  end

  def run() do
    [n | list] = read_file("input.txt") 
    sum = list 
          |> Enum.sum()
    sum_n = div(n * (n + 1), 2)
    IO.puts("Missing: #{(sum_n - sum)}") 
  end

end

MissingNumber.run()
