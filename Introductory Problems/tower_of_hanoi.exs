# Tower of Hanoi
#
# The Tower of Hanoi game consists of three stacks (left, middle and right)
# and n round disks of different sizes.
# Initially, the left stack has all the disks,
# in increasing order of size from top to bottom.
#
# The goal is to move all the disks to the right stack using the middle stack.
# On each move you can move the uppermost disk from a stack to another stack.
# In addition, it is not allowed to place a larger disk on a smaller disk.
#
# Your task is to find a solution that minimizes the number of moves.
#
# Input
# The only input line has an integer n: the number of disks.
#
# Output
# First print an integer k: the minimum number of moves.
# After this, print k lines that describe the moves.
# Each line has two integers a and b: you move a disk from stack a to stack b
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
# 3
# 1 2
# 1 3
# 2 3


defmodule TowerHanoi do
  defp read_file(file), do: File.read!(file) |> String.trim() |> String.to_integer()

  defp towerhanoy(n, source, aux, dest), do: towerhanoy(n, source, aux, dest, [])

  defp towerhanoy(0, _source, _aux, _dest, moves), do: moves

  defp towerhanoy(n, source, aux, dest, moves) do
    first_moves = towerhanoy(n-1, source, dest, aux, moves)
    towerhanoy(n-1, aux, source, dest, first_moves ++ [[source, dest]])
  end

  def run() do
   moves = read_file("input.txt") |> towerhanoy("1", "2", "3")
   length(moves) |> IO.puts()
   for m <- moves, do: m |> Enum.join(" ") |> IO.puts()
  end
end


TowerHanoi.run()
