# There are 88418 paths in a 7×7 grid from the upper-left square to the lower-left square.
# Each path corresponds to a 48-character description consisting of
# characters D (down), U (up), L (left) and R (right).
#
# For example, the path
#
# [https://cses.fi/file/3624b569007eb03818b6611755f1bdbe4cdbd0a8334baf9fedc5365914bdd661]
#
# corresponds to the description DRURRRRRDDDLUULDDDLDRRURDDLLLLLURULURRUULDLLDDDD.
#
# You are given a description of a path which may also contain characters ? (any direction).
# Your task is to calculate the number of paths that match the description.
#
# Input
# The only input line has a 48
# -character string of characters ?, D, U, L and R.
#
# Output
# Print one integer: the total number of paths.
#
# Example
#
# Input:
# ??????R??????U??????????????????????????LD????D?
#
# Output:
# 201


defmodule GridPaths do

  @moves %{"U" => [-1, 0], "D" => [1, 0], "L" => [0, -1], "R" => [0, 1]}

  defp read_file(file) do
    File.read!(file) |>String.trim() |> String.split("", trim: true)
  end

  defp is_inside_map([i, j], map_size) do
    cond do
      i < 1 or i > map_size or j < 1 or j > map_size -> false
      true -> true
    end
  end

  defp next_pos(curr_pos, move, map_size) do
   cond do
      move == "?" -> for {_m, p} <- @moves, do: List.zip([curr_pos, p]) |>  Enum.map(&Tuple.sum/1)
      true -> [List.zip([curr_pos, @moves[move]]) |> Enum.map(&Tuple.sum/1)]
    end
    |> Enum.filter(&is_inside_map(&1, map_size))
  end

  # if we can go left/right or up/down only, we split the grid in two and the path
  # can't cross itself, so there are no solutions
  defp split_grid([[i, j], [l, m]]) when i == l and abs(j-m) == 2, do: []
  defp split_grid([[i, j], [l, m]]) when j == m and abs(i-l) == 2, do: []
  defp split_grid(list), do: list

  defp grid_path([], final_pos, _curr_path, total_paths, map_size) when final_pos == [map_size, 1], do: total_paths + 1
  defp grid_path(_move_list, final_pos, _curr_path, total_paths, map_size) when final_pos == [map_size, 1], do: total_paths
  defp grid_path([], _final_pos, _curr_path, total_paths, _map_size), do: total_paths


  defp grid_path(move_list, curr_pos, curr_path, total_paths, map_size) do
    [next_move | rest_moves] = move_list
    next_pos = next_pos(curr_pos, next_move, map_size)
               |> Enum.filter(fn x -> not MapSet.member?(curr_path, x) end)
               |> split_grid()

    for n <- next_pos, reduce: 0 do
      acc ->
        acc + grid_path(rest_moves, n, MapSet.put(curr_path, n), total_paths, map_size)
    end
  end

  defp grid_path(move_list, map_size \\ 7) do
    grid_path(move_list, [1, 1], MapSet.new([[1, 1]]), 0, map_size)
  end

  def run() do
    read_file("input.txt") |>  grid_path()  |> IO.inspect()
  end

end

GridPaths.run()
