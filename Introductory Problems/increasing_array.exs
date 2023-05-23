# Increasing Arrays
#
# You are given an array of n integers.
# You want to modify the array so that it is increasing, i.e., every element is at least as large as the previous element.
# On each move, you may increase the value of any element by one. What is the minimum number of moves required?
#
# Input
# The first input line contains an integer n: the size of the array.
# Then, the second line contains n integers x1,x2,…,xn: the contents of the array.
#
# Output
# Print the minimum number of moves.
#
# Constraints
# 1≤n≤2⋅10^5
# 1≤xi≤10^9
#
# Example

# Input:
# 5
# 3 2 5 1 7
#
# Output:
# 5

defmodule IncreasingArray do

  defp read(file) do
    [_ | array] =  File.read!(file) |> String.split("\n", trim: true)
    array |> hd() |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
  end

  defp pos(num) when num >= 0, do: num

  defp pos(_num), do: 0

  defp scan([h, t], moves), do: IO.puts(moves +  pos(h - t))

  defp scan([h | t], moves) do
    [next | _] = t
    scan(t, moves + pos(h - next))
  end

  def run, do: read("input.txt") |> scan(0)
  
end

IncreasingArray.run()
