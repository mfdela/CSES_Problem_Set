# A number spiral is an infinite grid whose upper-left square has number 1.
# Here are the first five layers of the spiral:
#
#               --------------------------
#               |  1 |  2 |  9 | 10 | 25 |
#               |  4 |  3 |  8 | 11 | 24 |
#               |  5 |  6 |  7 | 12 | 23 |
#               | 16 | 15 | 14 | 13 | 22 |
#               | 17 | 18 | 19 | 20 | 21 |
#               --------------------------
#
# Your task is to find out the number in row y
#  and column x
#
# Input
# The first input line contains an integer t: the number of tests.
# After this, there are t
#  lines, each containing integers y
#  and x
#
# Output
# For each test, print the number in row y
#  and column x
#
# Constraints
# 1≤t≤10^5
# 1≤y,x≤10^9
#
# Example
#
# Input:
# 3
# 2 3
# 1 1
# 4 2
#
# Output:
# 8
# 1
# 15


defmodule NumberSpiral do
  # Each spiral is a n x n square. 
  # When n is even the spiral starts from the top and end on the left,
  # when n is odd it starts from the left and end on the top

  defp read_file(file)  do
    [_ | pairs] = File.read!(file) |> String.split("\n", trim: true)
    for p <- pairs do
      p |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
    end
  end

  defp compute_position([row, column]) do
    [m, n] = Enum.sort([row, column])
    # spiral n starts at (n-1)^2+1 and stops at n^2

    # first determine if we are starting from the left or from the top
    first = cond do
      row >= column -> 1
      true -> -1
    end

    # dir determine if we are going in a descending or or ascending order
    dir = case rem(n, 2) do
      0 -> -1
      1 -> 1
    end

    # final sequence, ascending or descending in the n-th spiral
    seq = first * dir

    # determine starting point depending if we are ascending or descending
    start = cond do
      seq == 1 -> (n-1)**2+1
      seq == -1 -> n**2
    end

    start + seq * (m - 1)

  end

  def run() do
    for pair <- read_file("input.txt") do
      pair |> compute_position() |> IO.puts()
    end
  end



end
  
NumberSpiral.run()
