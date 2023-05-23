# Weird Algorithm
#
# Consider an algorithm that takes as input a positive integer n.
# If n is even, the algorithm divides it by two, and if n
# is odd, the algorithm multiplies it by three and adds one. The algorithm repeats this, until n
# is one. For example, the sequence for n=3
# is as follows:
# 3→10→5→16→8→4→2→1
#
# Your task is to simulate the execution of the algorithm for a given value of n
#
# Input
# The only input line contains an integer n
#
# Output
# Print a line that contains all values of n during the algorithm.
#
# Constraints
# 1≤n≤10^6
#
# Example
#
# Input:
# 3
#
# Output:
# 3 10 5 16 8 4 2 1


defmodule WeirdAlgorithm do

  defp op(n) when rem(n, 2) == 0, do: div(n, 2)

  defp op(n), do: 3 * n + 1

  defp sequence(1), do: IO.puts(1)

  defp sequence(n) do
    IO.write(" #{n} -> ")
    sequence(op(n))
  end

  def start(n) do
    IO.write(" #{n} -> ")
    sequence(op(n))
  end

end


Enum.each(1..10**6, &WeirdAlgorithm.start(&1))
