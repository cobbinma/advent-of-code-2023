defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      [_, values] = String.split(row, ":")
      values |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(fn {time, record} ->
      0..time
      |> Enum.filter(fn hold ->
        distance = (time - hold) * hold
        distance > record
      end)
    end)
    |> Enum.map(&length/1)
    |> Enum.reduce(1, fn wins, acc -> wins * acc end)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      [_, values] = String.split(row, ":")
      values |> String.replace(" ", "") |> String.to_integer()
    end)
    |> Kernel.then(fn [time, record] ->
      0..time
      |> Enum.filter(fn hold ->
        distance = (time - hold) * hold
        distance > record
      end)
      |> length()
    end)
  end
end
