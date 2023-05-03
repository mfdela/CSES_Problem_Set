# You are given a DNA sequence: a string consisting of characters A, C, G, and T. 
# Your task is to find the longest repetition in the sequence. 
# This is a maximum-length substring containing only one type of character.
#
# Input
# The only input line contains a string of n characters.
#
# Output
# Print one integer: the length of the longest repetition.
#
# Constraints
# 1≤n≤10^6
# 
# Example
#
# Input:
# ATTCGGGA
# 
# Output:
# 3


defmodule Repetitions do

  defp read_file(file) do
    File.read!(file)
    |> String.split("", trim: true)
  end


  defp check_sequence([h | t]), do: check_sequence(t, h , 1, "", 1)

  defp check_sequence([], _, _, _, longest_seq) do
    IO.puts(longest_seq)
  end

  defp check_sequence([h | t], current_char, current_seq, longest_char, longest_seq) do
    cond do
      (h == current_char) and current_seq == longest_seq  -> check_sequence(t, current_char, current_seq + 1, current_char, current_seq + 1)
      (h == current_char) and current_seq < longest_seq  -> check_sequence(t, current_char, current_seq + 1, longest_char, longest_seq)
      true -> check_sequence(t, h , 1, longest_char, longest_seq)
    end
  end

  def run() do
    read_file("input.txt") |> check_sequence()
  end

end

Repetitions.run()
