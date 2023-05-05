# Your task is to calculate the number of trailing zeros in the factorial n!
#
# For example, 20!=2432902008176640000 and it has 4 trailing zeros.
#
# Input
# The only input line has an integer n
#
# Output
# Print the number of trailing zeros in n!
#
# Constraints
# 1≤n≤10^9
#
# Example
#
# Input:
# 20
#
# Output:
# 4


defmodule TrailingZeros do
  defp read_file(file) do
    File.read!(file) |> String.trim() |> String.to_integer()
  end

  defp trailing_zeros(n) do
    # to get a zero we need to have a power of 2 and a power of 5 in the factorial
    # each 2 * 5 gives a 0. Since the exponent of 5 is always < than the exponent
    # of 2, we just need to count the powers of 5 in the factorial.
    power_5(n, 1, 0)
  end


  defp power_5(n, exp, count) do
    f = div(n, 5 ** exp)
    cond do
      f == 0 -> count
      true -> power_5(n, exp + 1, count + f)
    end
  end

  def run() do
    read_file("input.txt") |> trailing_zeros() |> IO.puts
  end
end

TrailingZeros.run()
