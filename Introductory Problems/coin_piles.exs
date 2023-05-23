# Coin Piles
#
# You have two coin piles containing a and b coins.
# On each move, you can either remove one coin from the left pile
# and two coins from the right pile, or two coins from the left pile
# and one coin from the right pile.
#
# Your task is to efficiently find out if you can empty both the piles.
#
# Input
# The first input line has an integer t: the number of tests.
#
# After this, there are t
#  lines, each of which has two integers a and b: the numbers of coins in the piles.
#
# Output
# For each test, print "YES" if you can empty the piles and "NO" otherwise.
# Constraints
# 1≤t≤10^5
# 0≤a,b≤10^9
#
# Example
#
# Input:
# 3
# 2 1
# 2 2
# 3 3
#
# Output:
# YES
# NO
# YES

defmodule CoinPiles do

  defp read_file(file) do
    [_t | pairs] = File.read!(file) |> String.split("\n", trim: true)
    for p <- pairs do
      p |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
    end
  end

  defp coin_piles(list) do
    for [a, b] <- list do
      [min, max] = Enum.sort([a, b])
      cond do
        (max > 2 * min) -> IO.puts("NO")
        rem(a + b, 3) == 0 -> IO.puts("YES")
        true -> IO.puts("NO")
      end
    end
  end

  def run(), do: read_file("input.txt") |> coin_piles

end

CoinPiles.run()
