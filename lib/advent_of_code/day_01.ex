defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> trebuchet()
  end

  def part2(args) do
    args
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(fn line ->
      line
      |> String.replace("one", "one1one")
      |> String.replace("two", "two2two")
      |> String.replace("three", "three3three")
      |> String.replace("four", "four4four")
      |> String.replace("five", "five5five")
      |> String.replace("six", "six6six")
      |> String.replace("seven", "seven7seven")
      |> String.replace("eight", "eight8eight")
      |> String.replace("nine", "nine9nine")
    end)
    |> trebuchet()
  end

  def trebuchet(args) do
    args
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(fn c -> c |> Integer.parse() end)
      |> Enum.filter(fn result -> result != :error end)
      |> Enum.map(fn {value, _} -> value end)
    end)
    |> Enum.map(fn numbers -> {Enum.at(numbers, 0), Enum.at(numbers, -1)} end)
    |> Enum.map(fn {first, last} ->
      Integer.to_string(first) <> Integer.to_string(last)
    end)
    |> Enum.map(fn number -> number |> Integer.parse() end)
    |> Enum.map(fn {value, _} -> value end)
    |> Enum.reduce(0, &+/2)
  end
end
