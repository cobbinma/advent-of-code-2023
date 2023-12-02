defmodule AdventOfCode.Day02 do
  def part1({input, {red, green, blue}}) do
    input
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(fn line -> String.replace_prefix(line, "Game ", "") |> String.split(": ") end)
    |> Enum.map(fn [game, cubes] -> {String.to_integer(game), String.split(cubes, "; ")} end)
    |> Enum.map(fn {game, sets} ->
      {game,
       sets
       |> Enum.map(fn set ->
         String.split(set, ", ")
         |> Enum.map(fn cubes ->
           [amount, colour] = String.split(cubes, " ")
           {String.to_integer(amount), colour}
         end)
         |> Enum.map(fn {amount, colour} ->
           case colour do
             "red" -> amount <= red
             "blue" -> amount <= blue
             "green" -> amount <= green
           end
         end)
       end)}
    end)
    |> Enum.map(fn {game, sets} -> {game, List.flatten(sets) |> Enum.member?(false)} end)
    |> Enum.filter(fn {_game, impossible} -> !impossible end)
    |> Enum.reduce(0, fn {game, _}, acc -> game + acc end)
  end

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(fn line -> String.replace_prefix(line, "Game ", "") |> String.split(": ") end)
    |> Enum.map(fn [_, cubes] -> String.split(cubes, "; ") end)
    |> Enum.map(fn sets ->
      sets
      |> Enum.map(fn set ->
        String.split(set, ", ")
        |> Enum.map(fn cubes ->
          [amount, colour] = String.split(cubes, " ")
          {String.to_integer(amount), colour}
        end)
      end)
      |> List.flatten()
      |> Enum.reduce({0, 0, 0}, fn {amount, colour}, {red, green, blue} ->
        case colour do
          "red" -> {Kernel.max(red, amount), green, blue}
          "green" -> {red, Kernel.max(green, amount), blue}
          "blue" -> {red, green, Kernel.max(blue, amount)}
        end
      end)
    end)
    |> Enum.map(fn {red, green, blue} -> red * green * blue end)
    |> Enum.reduce(0, fn game, acc -> acc + game end)
  end
end
