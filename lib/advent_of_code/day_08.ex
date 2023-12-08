defmodule AdventOfCode.Day08 do
  def part1(input) do
    {directions, nodes} =
      input
      |> String.split("\n", trim: true)
      |> Kernel.then(fn [directions | nodes] ->
        {String.graphemes(directions),
         nodes
         |> Enum.map(fn node ->
           [element, directions] =
             String.split(node, " = (") |> Enum.map(&String.replace(&1, ")", ""))

           [left, right] = String.split(directions, ", ")

           {element, left, right}
         end)}
      end)

    nodes =
      Enum.reduce(nodes, %{}, fn {element, left, right}, acc ->
        Map.put(acc, element, {left, right})
      end)

    navigate(nodes, directions, directions, "AAA", 0)
  end

  def part2(input) do
    {directions, nodes} =
      input
      |> String.split("\n", trim: true)
      |> Kernel.then(fn [directions | nodes] ->
        {String.graphemes(directions),
         nodes
         |> Enum.map(fn node ->
           [element, directions] =
             String.split(node, " = (") |> Enum.map(&String.replace(&1, ")", ""))

           [left, right] = String.split(directions, ", ")

           {element, left, right}
         end)}
      end)

    nodes =
      Enum.reduce(nodes, %{}, fn {element, left, right}, acc ->
        Map.put(acc, element, {left, right})
      end)

    starting =
      Enum.filter(nodes, fn {element, _} -> String.ends_with?(element, "A") end)
      |> Enum.map(fn {element, _} -> element end)

    navigate_multiple(nodes, directions, directions, starting, 0)
  end

  defp navigate_multiple(nodes, all_directions, directions, current, steps)
       when directions == [] do
    navigate_multiple(nodes, all_directions, all_directions, current, steps)
  end

  defp navigate_multiple(nodes, all_directions, [direction | directions], currents, steps) do
    if Enum.all?(Enum.map(currents, &String.ends_with?(&1, "Z"))) do
      steps
    else
      next =
        Enum.map(currents, fn current ->
          {left, right} = Map.get(nodes, current)

          case direction do
            "L" -> left
            "R" -> right
          end
        end)

      navigate_multiple(nodes, all_directions, directions, next, steps + 1)
    end
  end

  defp navigate(nodes, all_directions, directions, current, steps) when directions == [] do
    navigate(nodes, all_directions, all_directions, current, steps)
  end

  defp navigate(_nodes, _all_directions, _directions, current, steps) when current == "ZZZ" do
    steps
  end

  defp navigate(nodes, all_directions, [direction | directions], current, steps) do
    {left, right} = Map.get(nodes, current)

    next =
      case direction do
        "L" -> left
        "R" -> right
      end

    navigate(nodes, all_directions, directions, next, steps + 1)
  end
end
