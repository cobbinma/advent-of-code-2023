defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(fn line ->
      [_, game] = line |> String.split(": ")
      [winners, numbers] = game |> String.split(" | ")

      {winners
       |> String.split(" ")
       |> Enum.filter(fn winner -> winner != "" end)
       |> Enum.map(fn winner -> String.to_integer(winner) end),
       numbers
       |> String.split(" ")
       |> Enum.filter(fn number -> number != "" end)
       |> Enum.map(fn number -> String.to_integer(number) end)}
    end)
    |> Enum.map(fn {winners, numbers} ->
      amount =
        numbers
        |> Enum.filter(fn number -> Enum.member?(winners, number) end)
        |> length()

      case amount do
        0 -> 0
        other -> Integer.pow(2, other - 1)
      end
    end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(fn line ->
      [_, game] = line |> String.split(": ")
      [winners, numbers] = game |> String.split(" | ")

      {winners
       |> String.split(" ")
       |> Enum.filter(fn winner -> winner != "" end)
       |> Enum.map(fn winner -> String.to_integer(winner) end),
       numbers
       |> String.split(" ")
       |> Enum.filter(fn number -> number != "" end)
       |> Enum.map(fn number -> String.to_integer(number) end)}
    end)
    |> Enum.map(fn {winners, numbers} ->
      numbers
      |> Enum.filter(fn number -> Enum.member?(winners, number) end)
      |> length()
    end)
    |> Enum.with_index()
    |> Enum.reduce({0, %{}}, fn {wins, index}, {total, copies} ->
      copies = Map.update(copies, index, 1, fn existing -> existing + 1 end)
      multiply = Map.get(copies, index)

      copies =
        if(wins > 0) do
          (index + 1)..(index + wins)
          |> Enum.reduce(copies, fn index, copies ->
            Map.update(copies, index, multiply, fn existing -> existing + multiply end)
          end)
        else
          copies
        end

      {total + multiply, copies}
    end)
    |> Kernel.then(fn {total, _} -> total end)
  end
end
