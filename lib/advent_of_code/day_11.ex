defmodule AdventOfCode.Day11 do
  def part1(input) do
    input
    |> galaxies()
    |> distances(2)
  end

  def part2(input) do
    input
    |> galaxies()
    |> distances(10)
  end

  defp galaxies(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      String.graphemes(line)
      |> Enum.with_index()
      |> Enum.filter(fn {c, _} -> c != "." end)
      |> Enum.map(fn {_, x} -> {x, y} end)
    end)
  end

  defp distances(galaxies, factor) do
    factor = factor - 1

    combinations(galaxies, 2)
    |> Enum.map(fn [{x1, y1}, {x2, y2}] ->
      {dx, dy} = {abs(x1 - x2), abs(y1 - y2)}

      dx =
        if max(x1, x2) > min(x1, x2) do
          d =
            (min(x1, x2) + 1)..(max(x1, x2) - 1)
            |> Enum.map(fn x ->
              galaxies |> Enum.any?(fn {v, _} -> v == x end)
            end)
            |> Enum.filter(&(!&1))
            |> length()

          d * factor + dx
        else
          dx
        end

      dy =
        if max(y1, y2) > min(y1, y2) do
          d =
            (min(y1, y2) + 1)..(max(y1, y2) - 1)
            |> Enum.map(fn y ->
              galaxies
              |> Enum.any?(fn {_, v} -> v == y end)
            end)
            |> Enum.filter(&(!&1))
            |> length()

          d * factor + dy
        else
          dy
        end

      {dx, dy}
    end)
    |> Enum.map(fn {dx, dy} -> dx + dy end)
    |> Enum.sum()
  end

  defp combinations(list, num)
  defp combinations(_list, 0), do: [[]]
  defp combinations(list = [], _num), do: list

  defp combinations([head | tail], num) do
    Enum.map(combinations(tail, num - 1), &[head | &1]) ++
      combinations(tail, num)
  end
end
