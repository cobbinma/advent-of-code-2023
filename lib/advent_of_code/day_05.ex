defmodule AdventOfCode.Day05 do
  def part1(args) do
    {seeds, maps} =
      args
      |> String.split("\n", parts: 2)
      |> Kernel.then(fn [seeds, rest] ->
        {seeds
         |> String.replace_prefix("seeds: ", "")
         |> String.split(" ")
         |> Enum.map(fn value -> String.to_integer(value) end),
         rest
         |> String.split("\n\n")
         |> Enum.map(fn map ->
           [_, mappings] = map |> String.split("map:\n", parts: 2)

           mappings
           |> String.split("\n")
           |> Enum.filter(fn mapping -> mapping != "" end)
           |> Enum.map(fn mapping ->
             String.split(mapping, " ")
             |> Enum.map(fn value -> String.to_integer(value) end)
             |> Kernel.then(fn [destination, source, range] ->
               %{destination: destination, source: source, range: range}
             end)
           end)
         end)}
      end)

    Enum.reduce(maps, seeds, fn mappings, seeds ->
      seeds
      |> Enum.map(fn seed ->
        Enum.reduce_while(mappings, seed, fn mapping, seed ->
          if(
            mapping.destination > mapping.source && seed >= mapping.source &&
              seed <= mapping.source + mapping.range
          ) do
            {:halt, seed + (mapping.destination - mapping.source)}
          else
            if(
              mapping.source > mapping.destination && seed >= mapping.source &&
                seed <= mapping.source + mapping.range
            ) do
              {:halt, seed - (mapping.source - mapping.destination)}
            else
              {:cont, seed}
            end
          end
        end)
      end)
    end)
    |> Enum.min()
  end

  def part2(args) do
    {seeds, maps} =
      args
      |> String.split("\n", parts: 2)
      |> Kernel.then(fn [seeds, rest] ->
        {seeds
         |> String.replace_prefix("seeds: ", "")
         |> String.split(" ")
         |> Enum.map(fn value -> String.to_integer(value) end)
         |> Enum.chunk_every(2)
         |> Enum.flat_map(fn [start, range] ->
           Enum.reduce(0..(range - 1), [], fn index, acc ->
             [start + index | acc]
           end)
         end),
         rest
         |> String.split("\n\n")
         |> Enum.map(fn map ->
           [_, mappings] = map |> String.split("map:\n", parts: 2)

           mappings
           |> String.split("\n")
           |> Enum.filter(fn mapping -> mapping != "" end)
           |> Enum.map(fn mapping ->
             String.split(mapping, " ")
             |> Enum.map(fn value -> String.to_integer(value) end)
             |> Kernel.then(fn [destination, source, range] ->
               %{destination: destination, source: source, range: range}
             end)
           end)
         end)}
      end)

    Enum.reduce(maps, seeds, fn mappings, seeds ->
      seeds
      |> Enum.map(fn seed ->
        Enum.reduce_while(mappings, seed, fn mapping, seed ->
          if(
            mapping.destination > mapping.source && seed >= mapping.source &&
              seed <= mapping.source + mapping.range
          ) do
            {:halt, seed + (mapping.destination - mapping.source)}
          else
            if(
              mapping.source > mapping.destination && seed >= mapping.source &&
                seed <= mapping.source + mapping.range
            ) do
              {:halt, seed - (mapping.source - mapping.destination)}
            else
              {:cont, seed}
            end
          end
        end)
      end)
    end)
    |> Enum.min()
  end
end
