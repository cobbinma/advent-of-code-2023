defmodule AdventOfCode.Day09 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn history ->
      history
      |> differences([history])
      |> Enum.reduce(0, fn history, acc ->
        last = Enum.at(history, -1)
        acc + last
      end)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn history ->
      history
      |> differences([history])
      |> Enum.reduce(0, fn history, acc ->
        first = Enum.at(history, 0)
        first - acc
      end)
    end)
    |> Enum.sum()
  end

  defp differences(current, differences) do
    next =
      current |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [a, b | _] -> b - a end)

    if Enum.all?(Enum.map(next, fn difference -> difference == 0 end)) do
      differences
    else
      differences = [next | differences]
      differences(next, differences)
    end
  end
end
