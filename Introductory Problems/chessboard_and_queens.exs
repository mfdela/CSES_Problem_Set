# Your task is to place eight queens on a chessboard so that
# no two queens are attacking each other.
# As an additional challenge, each square is either free or reserved,
# and you can only place queens on the free squares.
# However, the reserved squares do not prevent queens from attacking each other.
#
# How many possible ways are there to place the queens?
#
# Input
# The input has eight lines, and each of them has eight characters.
# Each square is either free (.) or reserved (*).
#
# Output
# Print one integer: the number of ways you can place the queens.
#
# Example
#
# Input:
# ........
# ........
# ..*.....
# ........
# ........
# .....**.
# ...*....
# ........
#
# Output:
# 65

Mix.install([
  {:permutation, "~> 0.2.0"}
])

defmodule ChessboardAndQueens do
  defp read_file(file) do
    for {row, r} <- File.read!(file) |> String.split("\n", trim: true) |> Enum.with_index(), reduce: %{} do
      acc ->
        row_map = for {char, c} <- row |> String.split("", trim: true) |> Enum.with_index(), reduce: %{} do
          acc ->
            Map.put(acc, c, char)
        end
        Map.put(acc, r, row_map)
    end
  end

  defp queen_reach([], _), do: false

  defp queen_reach([q | queens], [i, j]) do
    [q_i, q_j] = q
    cond do
      q_i == i or q_j == j or abs(q_i - i) == (abs q_j - j) -> true
      true -> queen_reach(queens, [i, j])
    end
  end

  defp eight_queens(board, queens, sol, cols, n, k \\ 8)

  defp eight_queens(_board, queens, sol, _cols, n,  k) when n == k do
    MapSet.put(sol, queens)
  end

  defp eight_queens(board, queens, sol, cols, n,  k) do
    for i <- n..(k-1), j <- cols,
      board[i][j] == ".",
      queen_reach(queens, [i, j]) == false,
      reduce: sol do
      acc ->
        eight_queens(board, [[i ,j] | queens], acc, cols -- [j], n + 1,  k)
    end
  end

  defp eight_queens(board) do
    eight_queens(board, [], MapSet.new([]), Enum.to_list(0..7), 0)
  end

  def run() do
    read_file("input.txt") |> eight_queens() |> Enum.count() |> IO.inspect()
  end
end

ChessboardAndQueens.run()
